import 'dart:async';
import '../../domain/services/chat_realtime.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/chat.dart';
import '../../domain/usecases/chat_usecases.dart';

class ChatState {
  const ChatState({
    this.messages = const [],
    this.loading = true,
    this.sending = false,
    this.hasOlder = false,
    this.failed = false,
    this.loaded = false,
  });
  final List<ChatMessage> messages;
  final bool loading, sending, hasOlder, failed, loaded;
}

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._useCases, this.conversationId, {ChatRealtime? realtime})
    : _realtime = realtime,
      super(const ChatState());
  final ChatUseCases _useCases;
  final int conversationId;
  final ChatRealtime? _realtime;
  StreamSubscription<ChatLiveUpdate>? _live;
  bool _refreshPending = false;
  bool Function()? _isVisible;
  bool get realtimeConnected => _realtime?.connected ?? false;
  void resumeLive({required bool Function() isVisible}) {
    _isVisible = isVisible;
    if (_live != null || _realtime == null || isClosed) return;
    _live = _realtime.updates.listen((update) {
      if (!isClosed &&
          isVisible() &&
          update.connected &&
          (update.conversationId == null ||
              update.conversationId == conversationId)) {
        unawaited(poll());
      }
    });
    _realtime.acquire();
  }

  Future<void> pauseLive() async {
    final live = _live;
    _live = null;
    if (live != null) {
      await live.cancel();
      _realtime?.release();
    }
  }

  @override
  Future<void> close() async {
    await pauseLive();
    await super.close();
  }

  bool _fetching = false;
  int _afterId = 0;
  bool _loaded = false;
  String? _pendingBody, _pendingNonce;
  ChatUpload? _pendingAttachment;
  void _state({
    List<ChatMessage>? messages,
    bool? loading,
    bool? sending,
    bool? hasOlder,
    bool failed = false,
  }) {
    if (isClosed) return;
    emit(
      ChatState(
        messages: messages ?? state.messages,
        loading: loading ?? state.loading,
        sending: sending ?? state.sending,
        hasOlder: hasOlder ?? state.hasOlder,
        failed: failed,
        loaded: _loaded,
      ),
    );
  }

  List<ChatMessage> _merged(List<ChatMessage> rows) {
    final map = {
      for (final row in [...state.messages, ...rows]) row.id: row,
    };
    return map.values.toList()..sort((a, b) => a.id.compareTo(b.id));
  }

  Future<void> poll({bool older = false}) async {
    if (isClosed) return;
    if (_fetching) {
      if (!older) _refreshPending = true;
      return;
    }
    _fetching = true;
    final result = await _useCases.messages(
      conversationId,
      beforeId: older && state.messages.isNotEmpty
          ? state.messages.first.id
          : null,
      afterId: !older && _loaded && _afterId > 0 ? _afterId : null,
    );
    if (isClosed) {
      _fetching = false;
      return;
    }
    await result.fold(
      (failure) async {
        if (!_loaded) _state(loading: false, failed: true);
      },
      (ChatPage page) async {
        if (!older &&
            _loaded &&
            _afterId > 0 &&
            page.hasMore &&
            page.items.isNotEmpty &&
            page.items.last.id > _afterId) {
          _refreshPending = true;
        }
        if (!older && page.items.isNotEmpty && page.items.last.id > _afterId) {
          _afterId = page.items.last.id;
        }
        final hasOlder = older || !_loaded ? page.hasMore : state.hasOlder;
        final wasLoaded = _loaded;
        _loaded = true;
        _state(
          messages: _merged(page.items),
          loading: false,
          hasOlder: hasOlder,
          failed: wasLoaded && state.failed,
        );
        if (_afterId > 0 && (_isVisible?.call() ?? true)) {
          await _useCases.read(conversationId, _afterId);
        }
      },
    );
    _fetching = false;
    if (_refreshPending && !isClosed) {
      _refreshPending = false;
      await poll();
    }
  }

  Future<bool> send(String text, {ChatUpload? attachment}) async {
    final body = text.trim();
    if (state.sending ||
        state.loading ||
        !_loaded ||
        (body.isEmpty && attachment == null) ||
        (attachment != null && attachment.bytes.length > 10 * 1024 * 1024) ||
        body.length > 5000) {
      return false;
    }
    if (_pendingBody != body || !identical(_pendingAttachment, attachment)) {
      _pendingBody = body;
      _pendingAttachment = attachment;
      _pendingNonce = const Uuid().v4();
    }
    _state(sending: true);
    final result = await _useCases.send(
      conversationId,
      body,
      _pendingNonce!,
      attachment: attachment,
    );
    if (isClosed) return false;
    return result.fold(
      (failure) {
        _state(sending: false, failed: true);
        return false;
      },
      (ChatMessage message) {
        _pendingBody = null;
        _pendingAttachment = null;
        _pendingNonce = null;
        _state(messages: _merged([message]), sending: false);
        return true;
      },
    );
  }
}

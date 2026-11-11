import 'dart:async';
import '../../domain/services/chat_realtime.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/chat.dart';
import '../../domain/usecases/chat_usecases.dart';

class ConversationsState {
  const ConversationsState({
    this.threads = const [],
    this.loading = false,
    this.busy = false,
    this.hasMore = false,
    this.failed = false,
  });
  final List<ChatThread> threads;
  final bool loading, busy, hasMore, failed;
}

class ConversationsCubit extends Cubit<ConversationsState> {
  ConversationsCubit(this._useCases, {ChatRealtime? realtime})
    : _realtime = realtime,
      super(const ConversationsState());
  final ChatUseCases _useCases;
  final ChatRealtime? _realtime;
  StreamSubscription<ChatLiveUpdate>? _live;
  bool _livePending = false;
  bool get realtimeConnected => _realtime?.connected ?? false;
  void resumeLive() {
    if (_live != null || _realtime == null || isClosed) return;
    _live = _realtime.updates.listen((update) {
      if (update.connected && !isClosed) unawaited(load(refresh: true));
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

  int _page = 0;
  bool _starting = false;
  Future<void> load({bool more = false, bool refresh = false}) async {
    if (state.loading || state.busy) {
      if (refresh) _livePending = true;
      return;
    }
    if (more && !state.hasMore) return;
    final priorPage = _page, priorMore = state.hasMore;
    emit(
      ConversationsState(
        threads: state.threads,
        loading: true,
        hasMore: state.hasMore,
      ),
    );
    final next = more ? _page + 1 : 1;
    final result = await _useCases.threads(next);
    if (isClosed) return;
    result.fold(
      (_) => emit(
        ConversationsState(
          threads: state.threads,
          hasMore: state.hasMore,
          failed: true,
        ),
      ),
      (ChatThreadPage page) {
        _page = refresh ? priorPage : next;
        emit(
          ConversationsState(
            threads: more
                ? [
                    ...{
                      for (final thread in [...state.threads, ...page.items])
                        thread.id: thread,
                    }.values,
                  ]
                : refresh && priorPage > 1
                ? [
                    ...page.items,
                    ...state.threads.where(
                      (thread) =>
                          !page.items.any((fresh) => fresh.id == thread.id),
                    ),
                  ]
                : page.items,
            hasMore: refresh && priorPage > 1 ? priorMore : page.hasMore,
          ),
        );
      },
    );
    if (_livePending && !isClosed) {
      _livePending = false;
      await load(refresh: true);
    }
  }

  Future<ChatThread?> start({int? vendorId}) async {
    if (_starting) return null;
    _starting = true;
    emit(
      ConversationsState(
        threads: state.threads,
        busy: true,
        hasMore: state.hasMore,
      ),
    );
    final result = await _useCases.start(vendorId: vendorId);
    _starting = false;
    if (isClosed) return null;
    return result.fold(
      (_) {
        emit(
          ConversationsState(
            threads: state.threads,
            hasMore: state.hasMore,
            failed: true,
          ),
        );
        return null;
      },
      (ChatThread thread) {
        emit(
          ConversationsState(threads: state.threads, hasMore: state.hasMore),
        );
        return thread;
      },
    );
  }
}

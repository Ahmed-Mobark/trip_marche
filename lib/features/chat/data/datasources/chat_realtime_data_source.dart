import 'chat_socket.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../core/network/network_service/api_basehelper.dart';
import '../../domain/services/chat_realtime.dart';

/// Private Pusher protocol v7 client for Reverb/Pusher, shared by chat screens.
class ChatRealtimeDataSource implements ChatRealtime {
  ChatRealtimeDataSource(this._api, {WebSocketChannel Function(Uri)? connect})
    : _connect = connect;
  final ApiBaseHelper _api;
  final WebSocketChannel Function(Uri)? _connect;
  final _updates = StreamController<ChatLiveUpdate>.broadcast();
  WebSocketChannel? _socket;
  StreamSubscription<dynamic>? _subscription;
  Timer? _retry, _heartbeat, _deadline;
  int _references = 0, _generation = 0, _attempt = 0;
  bool _connected = false;
  @override
  Stream<ChatLiveUpdate> get updates => _updates.stream;
  @override
  bool get connected => _connected;
  @override
  void acquire() {
    if (++_references == 1) unawaited(_open());
  }

  @override
  void release() {
    if (_references == 0) return;
    if (--_references == 0) {
      ++_generation;
      _retry?.cancel();
      _clean();
      _state(false);
    }
  }

  void _state(bool value) {
    _connected = value;
    _updates.add(ChatLiveUpdate(connected: value, reason: 'connection'));
  }

  void _clean() {
    _deadline?.cancel();
    _heartbeat?.cancel();
    unawaited(_subscription?.cancel());
    _subscription = null;
    unawaited(_socket?.sink.close());
    _socket = null;
  }

  bool _current(int generation) => _references > 0 && generation == _generation;
  void _schedule(int generation, {Duration? delay}) {
    if (!_current(generation)) return;
    _retry?.cancel();
    _retry = Timer(
      delay ??
          Duration(
            milliseconds:
                min(30000, 1000 * pow(2, min(_attempt++, 5)).toInt()) +
                Random().nextInt(500),
          ),
      () => unawaited(_open()),
    );
  }

  void _lost(int generation) {
    if (!_current(generation)) return;
    ++_generation;
    _clean();
    _state(false);
    _schedule(_generation);
  }

  void _timeout(int generation, Duration delay) {
    _deadline?.cancel();
    _deadline = Timer(delay, () => _lost(generation));
  }

  Future<void> _open() async {
    if (_references == 0) return;
    final generation = ++_generation;
    _clean();
    _state(false);
    try {
      final response = await _api.get<Map<String, dynamic>>(
        url: 'chat/realtime',
      );
      if (!_current(generation)) return;
      final config = Map<String, dynamic>.from(response['data'] as Map);
      if (config['enabled'] != true) {
        _schedule(generation, delay: const Duration(seconds: 30));
        return;
      }
      final uri = Uri(
        scheme: config['scheme'] as String,
        host: config['host'] as String,
        port: (config['port'] as num).toInt(),
        path: '/app/${config['key']}',
        queryParameters: {
          'protocol': '7',
          'client': 'trevlen-flutter',
          'version': '1.0',
          'flash': 'false',
        },
      );
      final channel = _socket =
          _connect?.call(uri) ??
          openChatSocket(uri, origin: config['origin'] as String?);
      var activity = const Duration(seconds: 60);
      var subscribed = false;
      void arm() {
        _heartbeat?.cancel();
        _heartbeat = Timer(activity, () {
          if (_current(generation)) {
            channel.sink.add(jsonEncode({'event': 'pusher:ping', 'data': {}}));
            _timeout(generation, const Duration(seconds: 10));
          }
        });
      }

      _timeout(generation, const Duration(seconds: 15));
      _subscription = channel.stream.listen(
        (frame) async {
          if (!_current(generation)) return;
          try {
            final envelope =
                jsonDecode(frame as String) as Map<String, dynamic>;
            final raw = envelope['data'];
            final data = raw is String ? jsonDecode(raw) : raw;
            final event = envelope['event'];
            if (event == 'pusher:connection_established') {
              final settings = Map<String, dynamic>.from(data as Map);
              activity = Duration(
                seconds: max(
                  1,
                  min(
                    60,
                    (settings['activity_timeout'] as num?)?.toInt() ?? 60,
                  ),
                ),
              );
              // The endpoint is fixed to the authenticated API, never a URL from a frame.
              final auth = await _api.post<Map<String, dynamic>>(
                url: 'chat/broadcasting/auth',
                body: {
                  'socket_id': settings['socket_id'],
                  'channel_name': config['channel'],
                },
              );
              if (!_current(generation)) return;
              channel.sink.add(
                jsonEncode({
                  'event': 'pusher:subscribe',
                  'data': {'channel': config['channel'], 'auth': auth['auth']},
                }),
              );
            } else if (event == 'pusher_internal:subscription_succeeded' &&
                envelope['channel'] == config['channel']) {
              subscribed = true;
              _attempt = 0;
              _deadline?.cancel();
              _state(true);
            } else if (event == 'pusher:ping') {
              channel.sink.add(
                jsonEncode({'event': 'pusher:pong', 'data': {}}),
              );
            } else if (event == 'pusher:pong') {
              _deadline?.cancel();
            } else if (event == 'chat.changed' &&
                envelope['channel'] == config['channel'] &&
                subscribed) {
              final update = Map<String, dynamic>.from(data as Map);
              _updates.add(
                ChatLiveUpdate(
                  conversationId: int.tryParse('${update['conversation_id']}'),
                  messageId: int.tryParse('${update['message_id']}'),
                  reason: '${update['reason'] ?? 'message'}',
                  connected: true,
                ),
              );
            } else if (event == 'pusher:error' ||
                event == 'pusher:subscription_error') {
              _lost(generation);
              return;
            }
            if (_current(generation)) arm();
          } catch (_) {
            _lost(generation);
          }
        },
        onError: (Object error) => _lost(generation),
        onDone: () => _lost(generation),
        cancelOnError: true,
      );
      await channel.ready;
    } catch (_) {
      if (_current(generation)) _lost(generation);
    }
  }
}

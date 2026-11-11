import 'dart:io';
import 'package:trip_marche/features/chat/data/datasources/chat_socket_io.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/chat/data/datasources/chat_realtime_data_source.dart';
import 'package:trip_marche/features/chat/domain/services/chat_realtime.dart';
import 'package:trip_marche/features/chat/domain/usecases/chat_usecases.dart';
import 'package:trip_marche/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:trip_marche/features/chat/domain/entities/chat.dart';
import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'chat_test.dart' show FakeChatRepository, message;

class FakeApi extends Fake implements ApiBaseHelper {
  bool enabled = true;
  final authRequests = <Map<String, dynamic>>[];
  Completer<Map<String, dynamic>>? authorization;
  @override
  Future<T> get<T>({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Options? options,
    ApiEnvironment environment = ApiEnvironment.primary,
    bool includeCurrency = false,
  }) async =>
      {
            'data': {
              'enabled': enabled,
              'scheme': 'wss',
              'host': 'chat.example.org',
              'port': 443,
              'key': 'public-key',
              'channel': 'private-chat.user.1',
            },
          }
          as T;
  @override
  Future<T> post<T>({
    required String url,
    Map<String, dynamic>? body,
    FormData? formData,
    Options? options,
    ApiEnvironment environment = ApiEnvironment.primary,
    Map<String, dynamic>? queryParameters,
    bool includeCurrency = false,
  }) async {
    expect(url, 'chat/broadcasting/auth');
    authRequests.add(body!);
    return await (authorization?.future ??
            Future.value({'auth': 'public-key:signature'}))
        as T;
  }
}

class FakeSink extends Fake implements WebSocketSink {
  final sent = <Map<String, dynamic>>[];
  bool closed = false;
  @override
  void add(dynamic data) {
    sent.add(jsonDecode(data as String) as Map<String, dynamic>);
  }

  @override
  Future<void> close([int? closeCode, String? closeReason]) async {
    closed = true;
  }
}

class FakeChannel extends Fake implements WebSocketChannel {
  final input = StreamController<String>();
  final output = FakeSink();
  @override
  Stream<dynamic> get stream => input.stream;
  @override
  WebSocketSink get sink => output;
  @override
  Future<void> get ready => Future.value();
  void frame(String event, Map<String, dynamic> data, {String? channel}) =>
      input.add(
        jsonEncode({
          'event': event,
          'data': jsonEncode(data),
          if (channel != null) 'channel': channel,
        }),
      );
  Future<void> dispose() => input.close();
}

Future<void> flush() async {
  for (var i = 0; i < 4; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}

class FakeLive implements ChatRealtime {
  final changes = StreamController<ChatLiveUpdate>.broadcast();
  int references = 0;
  @override
  bool connected = true;
  @override
  Stream<ChatLiveUpdate> get updates => changes.stream;
  @override
  void acquire() {
    references++;
  }

  @override
  void release() {
    references--;
  }
}

void main() {
  test(
    'authenticates only the private user channel and forwards confirmed events',
    () async {
      final api = FakeApi(), socket = FakeChannel();
      final updates = <ChatLiveUpdate>[];
      final client = ChatRealtimeDataSource(
        api,
        connect: (uri) {
          expect(uri.scheme, 'wss');
          expect(uri.queryParameters['protocol'], '7');
          return socket;
        },
      );
      final subscription = client.updates.listen(updates.add);
      client.acquire();
      await flush();
      socket.frame('pusher:connection_established', {
        'socket_id': '12.34',
        'activity_timeout': 30,
      });
      await flush();
      expect(api.authRequests.single, {
        'socket_id': '12.34',
        'channel_name': 'private-chat.user.1',
      });
      expect(socket.output.sent.single['event'], 'pusher:subscribe');
      expect(client.connected, false);
      socket.frame(
        'pusher_internal:subscription_succeeded',
        {},
        channel: 'private-chat.user.1',
      );
      await flush();
      expect(client.connected, true);
      socket.frame('chat.changed', {
        'conversation_id': 8,
        'message_id': 9,
      }, channel: 'private-chat.user.2');
      socket.frame('chat.changed', {
        'conversation_id': 8,
        'message_id': 9,
      }, channel: 'private-chat.user.1');
      socket.frame('pusher:ping', {});
      await flush();
      expect(updates.where((event) => event.conversationId == 8).length, 1);
      expect(socket.output.sent.last['event'], 'pusher:pong');
      client.release();
      await subscription.cancel();
      await socket.dispose();
      expect(socket.output.closed, true);
    },
  );
  test(
    'shared screens retain a single socket until the last screen closes',
    () async {
      final socket = FakeChannel();
      var connects = 0;
      final client = ChatRealtimeDataSource(
        FakeApi(),
        connect: (_) {
          connects++;
          return socket;
        },
      );
      client.acquire();
      client.acquire();
      await flush();
      expect(connects, 1);
      client.release();
      expect(socket.output.closed, false);
      client.release();
      await flush();
      expect(socket.output.closed, true);
      await socket.dispose();
    },
  );
  test(
    'authorization completing after disposal cannot subscribe an old socket',
    () async {
      final api = FakeApi()..authorization = Completer<Map<String, dynamic>>();
      final socket = FakeChannel();
      final client = ChatRealtimeDataSource(api, connect: (_) => socket);
      client.acquire();
      await flush();
      socket.frame('pusher:connection_established', {'socket_id': '1.2'});
      await flush();
      client.release();
      api.authorization!.complete({'auth': 'signature'});
      await flush();
      expect(socket.output.sent, isEmpty);
      await socket.dispose();
    },
  );
  test(
    'missing runtime configuration never opens a socket and release cancels retries',
    () async {
      final api = FakeApi()..enabled = false;
      var connects = 0;
      final client = ChatRealtimeDataSource(
        api,
        connect: (_) {
          connects++;
          throw StateError('unexpected');
        },
      );
      client.acquire();
      await flush();
      expect(connects, 0);
      expect(client.connected, false);
      client.release();
    },
  );
  test(
    'realtime event during an active fetch triggers catch-up without waiting for a timer',
    () async {
      final live = FakeLive(), repo = FakeChatRepository();
      final initial = Completer<Either<Failure, ChatPage>>();
      var calls = 0;
      repo.fetch = (_, _) async {
        calls++;
        return calls == 1
            ? initial.future
            : Right(ChatPage([message(2)], false));
      };
      final cubit = ChatCubit(ChatUseCases(repo), 1, realtime: live);
      cubit.resumeLive(isVisible: () => true);
      final first = cubit.poll();
      live.changes.add(
        const ChatLiveUpdate(conversationId: 1, messageId: 2, connected: true),
      );
      await flush();
      initial.complete(Right(ChatPage([message(1)], false)));
      await first;
      expect(calls, 2);
      expect(cubit.state.messages.map((row) => row.id), [1, 2]);
      expect(repo.cursors, [null, 1]);
      await cubit.close();
      expect(live.references, 0);
      await live.changes.close();
    },
  );
  test(
    'reconnection drains all newer cursor pages and ignores other conversations',
    () async {
      final live = FakeLive(), repo = FakeChatRepository();
      var calls = 0;
      repo.fetch = (_, after) async {
        calls++;
        return Right(ChatPage([message(calls)], calls == 2));
      };
      final cubit = ChatCubit(ChatUseCases(repo), 1, realtime: live);
      await cubit.poll();
      cubit.resumeLive(isVisible: () => true);
      live.changes.add(
        const ChatLiveUpdate(conversationId: 99, connected: true),
      );
      await flush();
      expect(calls, 1);
      live.changes.add(
        const ChatLiveUpdate(reason: 'connection', connected: true),
      );
      await flush();
      expect(calls, 3);
      expect(cubit.state.messages.map((row) => row.id), [1, 2, 3]);
      await cubit.close();
      await live.changes.close();
    },
  );
  test(
    'native socket sends the configured Origin and exchanges real WebSocket frames',
    () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final origin = Completer<String?>();
      final accepted = Completer<WebSocket>();
      final listener = server.listen((request) async {
        origin.complete(request.headers.value('origin'));
        final socket = await WebSocketTransformer.upgrade(request);
        accepted.complete(socket);
        socket.add('connected');
      });
      final client = openChatSocket(
        Uri.parse('ws://127.0.0.1:${server.port}'),
        origin: 'https://api.example.org',
      );
      try {
        await client.ready;
        expect(await origin.future, 'https://api.example.org');
        expect(await client.stream.first, 'connected');
      } finally {
        await client.sink.close();
        if (accepted.isCompleted) await (await accepted.future).close();
        await listener.cancel();
        await server.close(force: true);
      }
    },
  );
  test(
    'a lost socket reconnects and reauthorizes before becoming connected again',
    () async {
      final api = FakeApi(), first = FakeChannel(), second = FakeChannel();
      var connections = 0;
      final client = ChatRealtimeDataSource(
        api,
        connect: (_) => ++connections == 1 ? first : second,
      );
      client.acquire();
      await flush();
      first.frame('pusher:connection_established', {'socket_id': '1.2'});
      await flush();
      first.frame(
        'pusher_internal:subscription_succeeded',
        {},
        channel: 'private-chat.user.1',
      );
      await flush();
      expect(connections, 1);
      expect(api.authRequests.length, 1);
      expect(first.output.sent.map((frame) => frame['event']).toList(), [
        'pusher:subscribe',
      ]);
      expect(client.connected, true);
      await first.input.close();
      await flush();
      expect(client.connected, false);
      await Future<void>.delayed(const Duration(seconds: 2));
      expect(connections, 2);
      second.frame('pusher:connection_established', {'socket_id': '3.4'});
      await flush();
      expect(api.authRequests.last['socket_id'], '3.4');
      expect(client.connected, false);
      second.frame(
        'pusher_internal:subscription_succeeded',
        {},
        channel: 'private-chat.user.1',
      );
      await flush();
      expect(client.connected, true);
      client.release();
      await second.dispose();
      await flush();
    },
  );
}

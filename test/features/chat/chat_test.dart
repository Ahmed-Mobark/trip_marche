import 'dart:typed_data';
import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/core/notification/notification_payload.dart';
import 'package:trip_marche/core/translation/app_localizations.dart';
import 'package:trip_marche/features/chat/domain/entities/chat.dart';
import 'package:trip_marche/features/chat/domain/repositories/chat_repository.dart';
import 'package:trip_marche/features/chat/domain/usecases/chat_usecases.dart';
import 'package:trip_marche/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:trip_marche/features/chat/presentation/view/chat_view.dart';

ChatMessage message(int id, {bool mine = false}) => ChatMessage(
  id: id,
  body: 'Message $id',
  isMine: mine,
  senderName: 'Company',
  createdAt: DateTime.utc(2026, 10, 31),
);

class FakeChatRepository implements ChatRepository {
  final cursors = <int?>[], nonces = <String>[], reads = <int>[];
  Future<Either<Failure, ChatPage>> Function(int?, int?)? fetch;
  Future<Either<Failure, ChatMessage>> Function(String, String)? deliver;
  @override
  Future<Either<Failure, Uint8List>> attachment(int id, int messageId) async =>
      Right(Uint8List(0));
  @override
  Future<Either<Failure, ChatPage>> messages(
    int id, {
    int? beforeId,
    int? afterId,
  }) {
    cursors.add(afterId);
    return fetch?.call(beforeId, afterId) ??
        Future.value(const Right(ChatPage([], false)));
  }

  @override
  Future<Either<Failure, ChatMessage>> send(
    int id,
    String body,
    String clientId, {
    ChatUpload? attachment,
  }) {
    nonces.add(clientId);
    return deliver?.call(body, clientId) ??
        Future.value(Right(message(10, mine: true)));
  }

  @override
  Future<Either<Failure, Unit>> read(int id, int lastId) async {
    reads.add(lastId);
    return const Right(unit);
  }

  @override
  Future<Either<Failure, ChatThread>> start({int? vendorId}) async =>
      const Right(
        ChatThread(id: 1, title: 'Company', unreadCount: 0, kind: 'vendor'),
      );
  @override
  Future<Either<Failure, ChatThreadPage>> threads(int page) async =>
      const Right(ChatThreadPage([], false));
}

void main() {
  test(
    'sending never advances the fetch cursor past unseen incoming messages',
    () async {
      final repo = FakeChatRepository();
      var calls = 0;
      repo.fetch = (before, after) async =>
          Right(ChatPage([message(++calls)], false));
      final cubit = ChatCubit(ChatUseCases(repo), 1);
      await cubit.poll();
      await cubit.send('Question');
      await cubit.poll();
      expect(repo.cursors, [null, 1]);
      expect(cubit.state.messages.map((m) => m.id), [1, 2, 10]);
      expect(repo.reads, [1, 2]);
      await cubit.close();
    },
  );
  test(
    'retry keeps the nonce for the same draft and changes it for a new draft',
    () async {
      final repo = FakeChatRepository();
      repo.deliver = (body, nonce) async =>
          const Left(NetworkFailure(message: 'Offline'));
      final cubit = ChatCubit(ChatUseCases(repo), 1);
      await cubit.poll();
      expect(await cubit.send('Question'), false);
      expect(cubit.state.loaded, true);
      expect(cubit.state.failed, true);
      await cubit.send('Question');
      await cubit.send('Changed question');
      expect(repo.nonces[0], repo.nonces[1]);
      expect(repo.nonces[2], isNot(repo.nonces[1]));
      await cubit.close();
    },
  );
  test(
    'older messages merge by ID without moving the forward cursor',
    () async {
      final repo = FakeChatRepository();
      repo.fetch = (before, after) async => Right(
        before != null
            ? ChatPage([message(1), message(2)], false)
            : ChatPage([message(2), message(3)], true),
      );
      final cubit = ChatCubit(ChatUseCases(repo), 1);
      await cubit.poll();
      await cubit.poll(older: true);
      await cubit.poll();
      expect(cubit.state.messages.map((m) => m.id), [1, 2, 3]);
      expect(repo.cursors.last, 3);
      expect(cubit.state.hasOlder, false);
      await cubit.close();
    },
  );
  test(
    'overlapping fetches are skipped and a disposed screen ignores its response',
    () async {
      final repo = FakeChatRepository();
      final pending = Completer<Either<Failure, ChatPage>>();
      repo.fetch = (_, _) => pending.future;
      final cubit = ChatCubit(ChatUseCases(repo), 1);
      final first = cubit.poll();
      await cubit.poll();
      expect(repo.cursors.length, 1);
      await cubit.close();
      pending.complete(Right(ChatPage([message(1)], false)));
      await first;
      expect(repo.reads, isEmpty);
    },
  );
  test('notification accepts a numeric conversation ID from FCM', () {
    expect(
      NotificationPayload.fromMap({
        'action': 'conversation',
        'conversation_id': '25',
      }).conversationId,
      25,
    );
  });
  testWidgets(
    'failed first message leaves the draft and send controls visible',
    (tester) async {
      await sl.reset();
      final repo = FakeChatRepository();
      repo.deliver = (_, _) async =>
          const Left(NetworkFailure(message: 'Offline'));
      sl.registerFactoryParam<ChatCubit, int, void>(
        (id, _) => ChatCubit(ChatUseCases(repo), id),
      );
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ChatView(conversationId: 1),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'My question');
      await tester.tap(find.byTooltip('Send'));
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('My question'), findsOneWidget);
      expect(find.byTooltip('Send'), findsOneWidget);
      await tester.pumpWidget(const SizedBox());
      await sl.reset();
    },
  );
}

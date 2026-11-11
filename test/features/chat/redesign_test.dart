import 'dart:io';
import 'dart:ui' as ui;
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/core/theme/app_theme.dart';
import 'package:trip_marche/core/translation/app_localizations.dart';
import 'package:trip_marche/features/chat/data/models/chat_models.dart';
import 'package:trip_marche/features/chat/domain/entities/chat.dart';
import 'package:trip_marche/features/chat/domain/usecases/chat_usecases.dart';
import 'package:trip_marche/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:trip_marche/features/chat/presentation/view/chat_view.dart';
import 'chat_test.dart' show FakeChatRepository;
import 'package:trip_marche/core/storage/data/storage.dart';
import 'package:trip_marche/features/chat/presentation/cubit/conversations_cubit.dart';
import 'package:trip_marche/features/chat/presentation/view/conversations_view.dart';

class _Storage implements Storage {
  @override
  String getToken() => 'isolated-test-token';
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _InboxRepository extends FakeChatRepository {
  @override
  Future<Either<Failure, ChatThreadPage>> threads(int page) async => Right(
    ChatThreadPage([
      ChatThread(
        id: 1,
        title: 'Wanderlust Travel',
        unreadCount: 2,
        kind: 'vendor',
        lastMessage: 'Your meeting point details are ready.',
        lastMessageAt: DateTime(2026, 11, 1, 19, 18),
      ),
      ChatThread(
        id: 2,
        title: 'TrevLen Support',
        unreadCount: 0,
        kind: 'support',
        lastMessageKind: 'audio',
        lastMessageAt: DateTime(2026, 11, 1, 18, 42),
      ),
    ], false),
  );
}

void main() {
  setUpAll(() async {
    final path = Platform.environment['TREVLEN_CHAT_PREVIEW_FONT'];
    if (path != null) {
      final loader = FontLoader('ReadexPro')
        ..addFont(
          File(path).readAsBytes().then((value) => ByteData.sublistView(value)),
        );
      await loader.load();
      final icons = FontLoader('packages/iconsax/iconsax')
        ..addFont(
          rootBundle.load('packages/iconsax/lib/assets/fonts/iconsax.ttf'),
        );
      await icons.load();
      final material = FontLoader('MaterialIcons')
        ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
      await material.load();
    }
  });
  test('legacy messages remain compatible and media/list metadata parses', () {
    final legacy = ChatMessageModel.fromJson({
      'id': 1,
      'body': 'Hello',
      'is_mine': true,
    });
    expect(legacy.attachment, isNull);
    final media = ChatMessageModel.fromJson({
      'id': 2,
      'attachment': {'kind': 'audio', 'mime': 'audio/mp4', 'size': 2800},
    });
    expect(media.attachment!.kind, 'audio');
    expect(media.attachment!.size, 2800);
    final thread = ChatThreadModel.fromJson({
      'id': 3,
      'last_message_kind': 'image',
      'last_message_at': '2026-11-01T12:00:00Z',
      'avatar_url': 'https://example.test/logo.png',
    });
    expect(thread.lastMessageKind, 'image');
    expect(thread.lastMessageAt, isNotNull);
  });

  test(
    'empty-caption attachments retry with the same nonce and retain failure state',
    () async {
      final repo = FakeChatRepository();
      repo.deliver = (_, _) async =>
          const Left(NetworkFailure(message: 'Offline'));
      final cubit = ChatCubit(ChatUseCases(repo), 1);
      await cubit.poll();
      final upload = ChatUpload(
        bytes: Uint8List.fromList([1, 2, 3]),
        name: 'voice.m4a',
        mime: 'audio/mp4',
        kind: 'audio',
      );
      expect(await cubit.send('', attachment: upload), false);
      expect(cubit.state.failed, true);
      await cubit.send('', attachment: upload);
      expect(repo.nonces.length, 2);
      expect(repo.nonces[0], repo.nonces[1]);
      await cubit.send('New caption', attachment: upload);
      expect(repo.nonces[2], isNot(repo.nonces[1]));
      expect(await cubit.send(''), false);
      await cubit.close();
    },
  );

  testWidgets(
    'inbox cards show previews/unread state and fit a narrow Arabic viewport',
    (tester) async {
      tester.view.physicalSize = const Size(320, 720);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await sl.reset();
      sl.registerSingleton<Storage>(_Storage());
      sl.registerFactory(
        () => ConversationsCubit(ChatUseCases(_InboxRepository())),
      );
      final boundaryKey = GlobalKey();
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (_, _) => RepaintBoundary(
            key: boundaryKey,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: const Locale('ar'),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: AppTheme.appLightTheme,
              home: const ConversationsView(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Wanderlust Travel'), findsOneWidget);
      expect(
        find.text('Your meeting point details are ready.'),
        findsOneWidget,
      );
      expect(find.text('2'), findsOneWidget);
      expect(tester.takeException(), isNull);
      final output = Platform.environment['TREVLEN_CHAT_PREVIEWS'];
      if (output != null) {
        await tester.runAsync(() async {
          final boundary =
              boundaryKey.currentContext!.findRenderObject()!
                  as RenderRepaintBoundary;
          final image = await boundary.toImage(pixelRatio: 2);
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          await Directory(output).create(recursive: true);
          await File(
            '$output/inbox-ar-light.png',
          ).writeAsBytes(bytes!.buffer.asUint8List());
          image.dispose();
        });
      }
      await tester.pumpWidget(const SizedBox());
      await sl.reset();
    },
  );

  for (final locale in ['en', 'ar']) {
    for (final dark in [false, true]) {
      testWidgets(
        'composer aligns with send and fits $locale/${dark ? 'dark' : 'light'} including keyboard',
        (tester) async {
          tester.view.physicalSize = const Size(390, 844);
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          await sl.reset();
          final repo = FakeChatRepository();
          repo.fetch = (_, _) async => Right(
            ChatPage([
              ChatMessage(
                id: 1,
                body: locale == 'ar'
                    ? 'أهلًا بيك، نقدر نساعدك إزاي؟'
                    : 'Hello! How can we help with your trip?',
                isMine: false,
                senderName: 'Wanderlust Travel',
                createdAt: DateTime(2026, 11, 1, 19, 17),
              ),
              ChatMessage(
                id: 2,
                body: locale == 'ar'
                    ? 'محتاج أعرف تفاصيل نقطة التجمع.'
                    : 'Could you share the meeting point details?',
                isMine: true,
                senderName: 'Customer',
                createdAt: DateTime(2026, 11, 1, 19, 18),
              ),
            ], false),
          );
          sl.registerFactoryParam<ChatCubit, int, void>(
            (id, _) => ChatCubit(ChatUseCases(repo), id),
          );
          final boundaryKey = GlobalKey();
          await tester.pumpWidget(
            ScreenUtilInit(
              designSize: const Size(375, 812),
              builder: (_, _) => RepaintBoundary(
                key: boundaryKey,
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  locale: Locale(locale),
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  theme: AppTheme.appLightTheme,
                  darkTheme: AppTheme.appDarkTheme,
                  themeMode: dark ? ThemeMode.dark : ThemeMode.light,
                  home: const ChatView(
                    conversationId: 1,
                    title: 'Wanderlust Travel',
                  ),
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
          final input = find.byType(TextField),
              send = find.byTooltip(locale == 'ar' ? 'إرسال' : 'Send');
          expect(input, findsOneWidget);
          expect(send, findsOneWidget);
          expect(
            (tester.getCenter(input).dy - tester.getCenter(send).dy).abs(),
            lessThan(8),
          );
          final mine = find.byWidgetPredicate(
            (widget) =>
                widget is SelectableText &&
                widget.data ==
                    (locale == 'ar'
                        ? 'محتاج أعرف تفاصيل نقطة التجمع.'
                        : 'Could you share the meeting point details?'),
          );
          expect(
            (tester.widget<SelectableText>(mine).style!.color),
            AppColors.white,
          );
          final output = Platform.environment['TREVLEN_CHAT_PREVIEWS'];
          if (output != null) {
            await tester.runAsync(() async {
              final boundary =
                  boundaryKey.currentContext!.findRenderObject()!
                      as RenderRepaintBoundary;
              final image = await boundary.toImage(pixelRatio: 2);
              final data = await image.toByteData(
                format: ui.ImageByteFormat.png,
              );
              await Directory(output).create(recursive: true);
              await File(
                '$output/chat-$locale-${dark ? 'dark' : 'light'}.png',
              ).writeAsBytes(data!.buffer.asUint8List());
              image.dispose();
            });
          }
          tester.view.viewInsets = const FakeViewPadding(bottom: 300);
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
          expect(tester.getBottomLeft(send).dy, lessThan(544));
          tester.view.viewInsets = const FakeViewPadding();
          await tester.pumpWidget(const SizedBox());
          await sl.reset();
        },
      );
    }
  }
}

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:trip_marche/core/notification/notification_api.dart';
import 'package:trip_marche/core/notification/notification_unread_controller.dart';

void main() {
  test(
    'reflects the server unread state and clears it after reading',
    () async {
      final api = _FakeNotificationApi(unread: 2);
      final controller = NotificationUnreadController(api);

      await controller.refresh();
      expect(controller.hasUnread, isTrue);

      expect(await controller.markAllAsRead(), isTrue);
      expect(controller.hasUnread, isFalse);
      expect(api.markAllCalls, 1);

      controller.markUnread();
      expect(controller.hasUnread, isTrue);

      controller.clear();
      expect(controller.hasUnread, isFalse);
    },
  );

  test('an incoming push wins over an older unread-count response', () async {
    final api = _FakeNotificationApi();
    final pendingCount = Completer<int>();
    api.pendingUnreadCount = pendingCount;
    final controller = NotificationUnreadController(api);

    final refresh = controller.refresh();
    controller.markUnread();
    pendingCount.complete(0);
    await refresh;

    expect(controller.hasUnread, isTrue);
  });

  test(
    'an incoming push is not cleared by an in-flight mark-all call',
    () async {
      final api = _FakeNotificationApi();
      final pendingMarkAll = Completer<void>();
      api.pendingMarkAll = pendingMarkAll;
      final controller = NotificationUnreadController(api)..markUnread();

      final markAll = controller.markAllAsRead();
      controller.markUnread();
      pendingMarkAll.complete();
      expect(await markAll, isTrue);

      expect(controller.hasUnread, isTrue);
    },
  );
}

class _FakeNotificationApi implements NotificationApi {
  _FakeNotificationApi({this.unread = 0});

  int unread;
  int markAllCalls = 0;
  Completer<int>? pendingUnreadCount;
  Completer<void>? pendingMarkAll;

  @override
  Future<List<Map<String, dynamic>>> fetchNotifications() async => const [];

  @override
  Future<int> unreadCount() =>
      pendingUnreadCount?.future ?? Future<int>.value(unread);

  @override
  Future<void> markAsRead(int id) async {}

  @override
  Future<void> markAllAsRead() {
    markAllCalls++;
    return pendingMarkAll?.future ?? Future<void>.value();
  }

  @override
  Future<void> registerDevice(String token, {String? locale}) async {}

  @override
  Future<void> unregisterDevice(String token) async {}
}

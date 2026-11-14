import 'package:flutter/foundation.dart';

import 'notification_api.dart';

class NotificationUnreadController extends ValueNotifier<bool> {
  NotificationUnreadController(this._api) : super(false);

  final NotificationApi _api;
  int _revision = 0;

  bool get hasUnread => value;

  Future<void> refresh() async {
    final revision = _revision;
    try {
      final count = await _api.unreadCount();
      if (revision == _revision) {
        value = count > 0;
      }
    } catch (_) {
      // Keep the last known state while offline. The next resume retries.
    }
  }

  void markUnread() {
    _revision++;
    value = true;
  }

  Future<bool> markAllAsRead() async {
    final revision = _revision;
    try {
      await _api.markAllAsRead();
      if (revision == _revision) {
        _revision++;
        value = false;
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  void clear() {
    _revision++;
    value = false;
  }
}

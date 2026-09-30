import 'package:flutter/widgets.dart';

import '../../features/nav_bar/presentation/view/main_nav_view.dart';
import '../../features/notifications/presentation/view/notifications_view.dart';
import '../injection/injection_container.dart';
import '../navigation/app_navigator.dart';
import 'notification_payload.dart';

class NotificationNavigationService {
  Future<void> open(NotificationPayload payload) async {
    final navigator = sl<AppNavigator>();
    final state = navigator.navigatorKey.currentState;
    if (state == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => open(payload));
      return;
    }

    if (_shouldOpenMyTrips(payload)) {
      await navigator.pushAndRemoveUntil(
        screen: const MainNavView(initialIndex: 1),
      );
      return;
    }

    await navigator.push(screen: const NotificationsView());
  }

  bool _shouldOpenMyTrips(NotificationPayload payload) {
    final type = payload.type?.toLowerCase() ?? '';
    final action = payload.action?.toLowerCase() ?? '';
    return payload.bookingId != null ||
        type.contains('booking') ||
        type.contains('trip') ||
        action == 'trip_details';
  }
}

import 'package:flutter/widgets.dart';

import '../../features/notifications/presentation/view/notifications_view.dart';
import '../../features/trip_details/presentation/view/trip_details_view.dart';
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

    if (payload.action == 'trip_details' && payload.tripId != null) {
      await navigator.push(screen: TripDetailsView(tripId: payload.tripId!));
      return;
    }

    await navigator.push(screen: const NotificationsView());
  }
}

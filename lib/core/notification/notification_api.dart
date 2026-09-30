import 'dart:io';

import '../config/app_end_points.dart';
import '../network/network_service/api_basehelper.dart';

class NotificationApi {
  NotificationApi(this._api);

  final ApiBaseHelper _api;

  Future<List<Map<String, dynamic>>> fetchNotifications() async {
    final response = await _api.get<Map<String, dynamic>>(
      url: AppEndpoints.notifications,
      queryParameters: {'per_page': 50},
    );
    final data = response['data'];
    if (data is List) {
      return data
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
    return const [];
  }

  Future<int> unreadCount() async {
    final response = await _api.get<Map<String, dynamic>>(
      url: AppEndpoints.notificationsUnreadCount,
    );
    final data = response['data'];
    if (data is Map) {
      return int.tryParse('${data['unread_count']}') ?? 0;
    }
    return 0;
  }

  Future<void> markAsRead(int id) {
    return _api.post<Map<String, dynamic>>(
      url: AppEndpoints.notificationRead(id),
      body: {},
    );
  }

  Future<void> markAllAsRead() {
    return _api.post<Map<String, dynamic>>(
      url: AppEndpoints.notificationsMarkAllRead,
      body: {},
    );
  }

  Future<void> registerDevice(String token) {
    return _api.post<Map<String, dynamic>>(
      url: AppEndpoints.notificationDevices,
      body: {'token': token, 'platform': Platform.isIOS ? 'ios' : 'android'},
    );
  }

  Future<void> unregisterDevice(String token) {
    return _api.delete<Map<String, dynamic>>(
      url: AppEndpoints.notificationDevices,
      body: {'token': token},
    );
  }
}

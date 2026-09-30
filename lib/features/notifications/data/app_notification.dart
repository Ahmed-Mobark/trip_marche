import '../../../core/notification/notification_payload.dart';

class AppNotification {
  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
    required this.createdAtHuman,
    required this.payload,
  });

  final int id;
  final String type;
  final String title;
  final String body;
  final bool isRead;
  final DateTime? createdAt;
  final String createdAtHuman;
  final NotificationPayload payload;

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    final data = Map<String, dynamic>.from(
      json['data'] is Map ? json['data'] : {},
    );
    data['notification_id'] = json['id'];
    data['type'] = json['type'];
    data['action'] = json['action'];
    data['trip_id'] = json['trip_id'];
    data['booking_id'] = json['booking_id'];

    return AppNotification(
      id: int.tryParse('${json['id']}') ?? 0,
      type: json['type']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      isRead: json['is_read'] == true,
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      createdAtHuman: json['created_at_human']?.toString() ?? '',
      payload: NotificationPayload.fromMap(data),
    );
  }
}

class NotificationPayload {
  const NotificationPayload({
    required this.type,
    required this.action,
    this.notificationId,
    this.tripId,
    this.bookingId,
    this.data = const {},
  });

  final String? type;
  final String? action;
  final int? notificationId;
  final int? tripId;
  final int? bookingId;
  final Map<String, dynamic> data;

  factory NotificationPayload.fromMap(Map<String, dynamic> map) {
    return NotificationPayload(
      type: map['type']?.toString(),
      action: map['action']?.toString(),
      notificationId: _asInt(map['notification_id'] ?? map['id']),
      tripId: _asInt(map['trip_id']),
      bookingId: _asInt(map['booking_id']),
      data: Map<String, dynamic>.from(map),
    );
  }

  static int? _asInt(Object? value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }
}

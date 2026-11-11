import 'package:flutter_test/flutter_test.dart';
import 'package:trip_marche/core/notification/notification_labels.dart';
import 'package:trip_marche/core/translation/app_localizations_en.dart';
import 'package:trip_marche/core/translation/app_localizations_ar.dart';
import 'package:trip_marche/features/notifications/data/app_notification.dart';

void main() {
  test(
    'stored Arabic chat title renders in English without translating the message',
    () {
      final notification = AppNotification.fromJson({
        'id': 12,
        'type': 'chat.message',
        'title': 'رسالة جديدة',
        'body': 'أهلًا وسهلًا',
        'data': {'conversation_id': 5},
        'action': 'conversation',
      });
      expect(
        localizedNotificationTitle(
          type: notification.type,
          fallback: notification.title,
          strings: AppLocalizationsEn(),
        ),
        'New message',
      );
      expect(
        localizedNotificationTitle(
          type: notification.type,
          fallback: notification.title,
          strings: AppLocalizationsAr(),
        ),
        'رسالة جديدة',
      );
      expect(notification.body, 'أهلًا وسهلًا');
      expect(notification.payload.conversationId, 5);
      expect(
        localizedNotificationTitle(
          type: 'custom',
          fallback: 'رسالة كتبها الأدمن',
          strings: AppLocalizationsEn(),
        ),
        'رسالة كتبها الأدمن',
      );
    },
  );
}

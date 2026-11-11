import '../translation/app_localizations.dart';

/// System labels follow the viewer's language; authored content stays unchanged.
String localizedNotificationTitle({
  required String? type,
  required String fallback,
  required AppLocalizations strings,
}) => type == 'chat.message' ? strings.chatNewMessage : fallback;

import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../firebase_options.dart';
import '../storage/data/storage.dart';
import 'notification_api.dart';
import 'notification_navigation_service.dart';
import 'notification_payload.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (_) {}
}

class FirebaseNotificationService {
  FirebaseNotificationService(this._api, this._storage, this._navigation);

  final NotificationApi _api;
  final Storage _storage;
  final NotificationNavigationService _navigation;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  FirebaseMessaging get _messaging => FirebaseMessaging.instance;

  bool _initialized = false;
  String? _lastToken;

  Future<void> init() async {
    if (_initialized) return;

    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (error) {
      if (kDebugMode) {
        log('Firebase initialization skipped: $error');
      }
      return;
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    const androidChannel = AndroidNotificationChannel(
      'trevlen_notifications',
      'Trevlen Notifications',
      description: 'Trip and booking updates',
      importance: Importance.high,
    );

    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload == null || payload.isEmpty) return;
        final data = jsonDecode(payload);
        if (data is Map) {
          _navigation.open(
            NotificationPayload.fromMap(Map<String, dynamic>.from(data)),
          );
        }
      },
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidChannel);

    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(_showForegroundNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(_openRemoteMessage);
    _messaging.onTokenRefresh.listen(_registerToken);

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _openRemoteMessage(initialMessage);
    }

    _initialized = true;
    if (_storage.isAuthorized()) {
      await registerCurrentDevice();
    }
  }

  Future<void> requestPermission() async {
    try {
      await _messaging.requestPermission(alert: true, badge: true, sound: true);
    } catch (_) {}
  }

  Future<void> registerCurrentDevice() async {
    if (!_initialized || !_storage.isAuthorized()) return;
    await requestPermission();
    final token = await _messaging.getToken();
    if (token != null) {
      await _registerToken(token);
    }
  }

  Future<void> unregisterCurrentDevice() async {
    if (!_initialized) return;
    final token = _lastToken ?? await _messaging.getToken();
    if (token == null || !_storage.isAuthorized()) return;
    try {
      await _api.unregisterDevice(token);
    } catch (error) {
      if (kDebugMode) log('FCM token unregister failed: $error');
    }
  }

  Future<void> _registerToken(String token) async {
    if (!_storage.isAuthorized()) return;
    try {
      await _api.registerDevice(token);
      _lastToken = token;
    } catch (error) {
      if (kDebugMode) log('FCM token register failed: $error');
    }
  }

  Future<void> _showForegroundNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'trevlen_notifications',
          'Trevlen Notifications',
          channelDescription: 'Trip and booking updates',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: jsonEncode(message.data),
    );
  }

  void _openRemoteMessage(RemoteMessage message) {
    _navigation.open(NotificationPayload.fromMap(message.data));
  }
}

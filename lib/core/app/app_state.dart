import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/storage/data/storage.dart';
import 'package:trip_marche/features/auth/presentation/view/login_view.dart';
import 'package:trip_marche/features/nav_bar/presentation/view/main_nav_view.dart';
import 'package:trip_marche/features/splash/presentation/view/splash_view.dart';

class AppState {
  static Widget currentScreen() {
    Storage storage = sl<Storage>();
    final user = storage.getUserJson();
    bool isAuthorized = storage.getToken() != null;
    if (isAuthorized && user != null) {
      return const MainNavView();
    } else {
      return const SplashView();
    }
  }

  static void logout() async {
    Storage storage = sl<Storage>();
    await storage.deleteToken();
    await storage.deleteUser();
    sl<AppNavigator>().pushAndRemoveUntil(screen: const LoginView());
  }

  // ---------------------------------------------------------------------------
  // Theme persistence (single source of truth shared with [AdaptiveTheme]).
  // ---------------------------------------------------------------------------

  /// Default mode used when nothing is persisted yet.
  static const AdaptiveThemeMode defaultThemeMode = AdaptiveThemeMode.light;

  /// Reads the persisted [AdaptiveThemeMode] (or [defaultThemeMode]).
  ///
  /// Call this in `main()` BEFORE `runApp` so [AdaptiveTheme.initial] starts
  /// with the user's last choice and the app doesn't flash the wrong theme on
  /// startup.
  static AdaptiveThemeMode bootThemeMode() {
    final stored = sl<Storage>().getThemeMode();
    return _decodeThemeMode(stored) ?? defaultThemeMode;
  }

  /// Persists the active [AdaptiveThemeMode]. Call right after
  /// `AdaptiveTheme.of(context).setThemeMode(mode)`.
  static Future<void> storeThemeMode(AdaptiveThemeMode mode) {
    return sl<Storage>().storeThemeMode(themeMode: _encodeThemeMode(mode));
  }

  static String _encodeThemeMode(AdaptiveThemeMode mode) {
    switch (mode) {
      case AdaptiveThemeMode.light:
        return 'light';
      case AdaptiveThemeMode.dark:
        return 'dark';
      case AdaptiveThemeMode.system:
        return 'system';
    }
  }

  static AdaptiveThemeMode? _decodeThemeMode(String? raw) {
    switch (raw) {
      case 'light':
        return AdaptiveThemeMode.light;
      case 'dark':
        return AdaptiveThemeMode.dark;
      case 'system':
        return AdaptiveThemeMode.system;
      default:
        return null;
    }
  }
}

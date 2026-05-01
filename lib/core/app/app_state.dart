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
}

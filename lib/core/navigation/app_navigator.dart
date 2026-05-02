import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'app_page_route.dart';

class AppNavigator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void _log(String action, Widget screen) {
    if (kDebugMode) {
      log('Navigation: $action -> ${screen.runtimeType}');
    }
  }

  Future<T?> push<T>({
    required Widget screen,
    NavAnimation animation = NavAnimation.cupertino,
  }) {
    _log('PUSH', screen);
    return navigatorKey.currentState!.push<T>(
      AppPageRoute.build<T>(screen: screen, animation: animation),
    );
  }

  Future<T?> pushReplacement<T>({
    required Widget screen,
    NavAnimation animation = NavAnimation.cupertino,
  }) {
    _log('PUSH_REPLACEMENT', screen);
    return navigatorKey.currentState!.pushReplacement<T, T>(
      AppPageRoute.build<T>(screen: screen, animation: animation),
    );
  }

  Future<T?> pushAndRemoveUntil<T>({
    required Widget screen,
    NavAnimation animation = NavAnimation.cupertino,
  }) {
    _log('PUSH_AND_REMOVE_UNTIL', screen);
    return navigatorKey.currentState!.pushAndRemoveUntil<T>(
      AppPageRoute.build<T>(screen: screen, animation: animation),
      (_) => false,
    );
  }

  void pop<T extends Object?>([T? result]) {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop(result);
    }
  }

  void popToFirst() {
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

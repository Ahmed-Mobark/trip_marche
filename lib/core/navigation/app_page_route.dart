import 'package:flutter/material.dart';

enum NavAnimation { slide, fade, scale, cupertino }

class AppPageRoute {
  static PageRoute<T> build<T>({
    required Widget screen,
    required NavAnimation animation,
  }) {
    // Client requirement: replace all page transitions with a SlideTransition.
    // Duration is fixed to 300ms (regardless of [animation]).
    return _slide<T>(screen);
  }

  /// =======================
  /// Slide (same as SlidePageRoute + createRoute)
  /// Default: from right → center
  /// =======================
  static PageRoute<T> _slide<T>(Widget screen) {
    return PageRouteBuilder<T>(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, animation, __) => screen,
      transitionsBuilder: (_, animation, __, child) {
        final tween = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.ease));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

}

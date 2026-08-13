import 'package:flutter/material.dart';

extension MediaQueryBottomInsetX on BuildContext {
  /// Stable system navigation / home-indicator inset (unchanged when keyboard opens).
  double get systemBottomInset => MediaQuery.viewPaddingOf(this).bottom;

  /// Bottom inset for interactive content (includes keyboard when open).
  double get contentBottomInset => MediaQuery.paddingOf(this).bottom;
}

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Standard Material switch for dark/light theme (settings).
///
/// [value] is `true` when **dark** mode is active.
class AppThemeModeToggle extends StatelessWidget {
  const AppThemeModeToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.semanticsLabel,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      toggled: value,
      label: semanticsLabel,
      child: Switch(
        inactiveTrackColor: AppColors.scaffoldColorDark,
        activeTrackColor: AppColors.primary,
        value: value,
        onChanged: onChanged,
        thumbColor: WidgetStateProperty.all(AppColors.onImage),
      ),
    );
  }
}

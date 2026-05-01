import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// A horizontal divider with centred text, e.g. "Or Login with".
class DividerWithText extends StatelessWidget {
  /// The text displayed between the two divider lines.
  final String text;

  /// Optional text style override. Defaults to [AppTextStyles.bodySmall].
  final TextStyle? textStyle;

  /// Color of the divider lines. Defaults to [AppColors.border].
  final Color? dividerColor;

  /// Horizontal padding around the text. Defaults to 16.
  final double horizontalPadding;

  const DividerWithText({
    super.key,
    required this.text,
    this.textStyle,
    this.dividerColor,
    this.horizontalPadding = 16,
  });

  @override
  Widget build(BuildContext context) {
    final color = dividerColor ?? AppColors.border;
    return Row(
      children: [
        Expanded(child: Divider(color: color)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Text(text, style: textStyle ?? AppTextStyles.bodyMedium()),
        ),
        Expanded(child: Divider(color: color)),
      ],
    );
  }
}

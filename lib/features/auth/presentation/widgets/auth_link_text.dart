import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// A centred RichText link used for auth navigation, e.g.
/// "Don't have an account? **Create One**".
class AuthLinkText extends StatelessWidget {
  /// The leading (non-highlighted) text.
  final String leadingText;

  /// The trailing highlighted action text.
  final String actionText;

  /// Callback invoked when the widget is tapped.
  final VoidCallback? onTap;

  /// Style for the leading text. Defaults to [AppTextStyles.bodyMedium]
  /// with [AppColors.greyText(context)].
  final TextStyle? leadingStyle;

  /// Style for the action text. Defaults to Inter 14/w600/primary.
  final TextStyle? actionStyle;

  const AuthLinkText({
    super.key,
    required this.leadingText,
    required this.actionText,
    this.onTap,
    this.leadingStyle,
    this.actionStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            text: leadingText,
            style:
                leadingStyle ??
                AppTextStyles.bodyMedium(color: AppColors.greyText(context)),
            children: [
              TextSpan(
                text: actionText,
                style:
                    actionStyle ??
                    AppTextStyles.bodyMedium(
                      color: AppColors.primary,
                    ).copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

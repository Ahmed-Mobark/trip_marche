import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_styles.dart';

class SettingsRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;
  /// Row label + leading icon color (pass explicit light/dark when driven by
  /// [AdaptiveTheme] so it updates on the same frame as the theme toggle).
  final Color foregroundColor;

  const SettingsRow({
    super.key,
    required this.icon,
    required this.title,
    required this.trailing,
    required this.foregroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(vertical: 18.h),
        child: Row(
          children: [
            Icon(icon, size: 22.sp, color: foregroundColor),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodyMedium(color: foregroundColor),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

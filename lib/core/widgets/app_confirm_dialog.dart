import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

class AppConfirmDialog extends StatelessWidget {
  const AppConfirmDialog({
    super.key,
    required this.message,
    required this.primaryActionText,
    required this.onPrimaryAction,
    required this.secondaryActionText,
    required this.onSecondaryAction,
    this.primaryActionColor,
    this.secondaryActionColor,
  });

  final String message;
  final String primaryActionText;
  final VoidCallback onPrimaryAction;
  final String secondaryActionText;
  final VoidCallback onSecondaryAction;
  final Color? primaryActionColor;
  final Color? secondaryActionColor;

  @override
  Widget build(BuildContext context) {
    final radius = 18.r;
    final bg = AppColors.cardBg(context);
    final msgColor = AppColors.bodyText(context).withValues(alpha: 0.72);
    final secondaryColor =
        secondaryActionColor ?? AppColors.bodyText(context).withValues(alpha: 0.55);

    return Dialog(
      backgroundColor: AppColors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 26.w),
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(20.w, 18.h, 20.w, 14.h),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(
                color: msgColor,
              ).copyWith(height: 1.35, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onSecondaryAction,
                  style: TextButton.styleFrom(
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: secondaryColor,
                  ),
                  child: Text(
                    secondaryActionText,
                    style: AppTextStyles.bodyMedium(
                      color: secondaryColor,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(width: 6.w),
                TextButton(
                  onPressed: onPrimaryAction,
                  style: TextButton.styleFrom(
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: primaryActionColor ?? AppColors.error,
                  ),
                  child: Text(
                    primaryActionText,
                    style: AppTextStyles.bodyMedium(
                      color: primaryActionColor ?? AppColors.error,
                    ).copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/app_button.dart';

class AppConfirmationBottomSheet extends StatelessWidget {
  const AppConfirmationBottomSheet({
    super.key,
    required this.title,
    required this.description,
    required this.primaryActionText,
    required this.secondaryActionText,
    required this.onPrimaryAction,
    required this.onSecondaryAction,
    this.icon,
    this.isLoading = false,
    this.primaryActionColor,
    this.secondaryActionColor,
    this.descriptionTextStyle,
  });

  final String title;
  final String description;
  final String primaryActionText;
  final String secondaryActionText;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;
  final IconData? icon;
  final bool isLoading;
  final Color? primaryActionColor;
  final Color? secondaryActionColor;
  final TextStyle? descriptionTextStyle;

  @override
  Widget build(BuildContext context) {
    final bg = AppColors.cardBg(context);
    final dragColor = AppColors.greyText(context).withValues(alpha: 0.35);
    final titleColor = AppColors.darkText(context);
    final descColor = AppColors.greyText(context).withValues(alpha: 0.8);

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 3.5.h,
            margin: EdgeInsets.only(bottom: 20.h),
            decoration: BoxDecoration(
              color: dragColor,
              borderRadius: BorderRadius.circular(50.r),
            ),
          ),
          if (icon != null) ...[
            Icon(icon, size: 28.sp, color: primaryActionColor ?? AppColors.error),
            SizedBox(height: 14.h),
          ],
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.heading3(color: titleColor),
          ),
          SizedBox(height: 10.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: descriptionTextStyle ??
                AppTextStyles.bodyMedium(color: descColor),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  heigh: 48.h,
                  radius: 12.r,
                  color: AppColors.transparent,
                  borderColor: AppColors.border(context),
                  text: secondaryActionText,
                  style: AppTextStyles.button(
                    color: secondaryActionColor ?? AppColors.bodyText(context),
                  ),
                  onTap: isLoading ? null : onSecondaryAction,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: isLoading
                    ? AppButton(
                        heigh: 48.h,
                        radius: 12.r,
                        color: primaryActionColor ?? AppColors.primary,
                        onTap: null,
                        child: SizedBox(
                          width: 20.r,
                          height: 20.r,
                          child: const CircularProgressIndicator(
                            color: AppColors.onImage,
                            strokeWidth: 2.5,
                          ),
                        ),
                      )
                    : AppButton(
                        heigh: 48.h,
                        radius: 12.r,
                        color: primaryActionColor ?? AppColors.primary,
                        text: primaryActionText,
                        style: AppTextStyles.button(
                          color: AppColors.onPrimary(context),
                        ),
                        onTap: onPrimaryAction,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

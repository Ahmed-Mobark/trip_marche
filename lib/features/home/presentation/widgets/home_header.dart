import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_icons.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.searchHint,
    required this.locationText,
    this.onNotificationsTap,
    this.onSearchTap,
    this.hasNotification = true,
  });

  final String searchHint;
  final String locationText;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onSearchTap;
  final bool hasNotification;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: 16.w,
            end: 16.w,
            top: 10.h,
            bottom: 14.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(AppIcons.lloPng, width: 80.w),

                  const Spacer(),
                  _NotificationButton(
                    onTap: onNotificationsTap,
                    hasNotification: hasNotification,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              _SearchField(hint: searchHint, onTap: onSearchTap),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(Iconsax.location, size: 18.sp, color: AppColors.yellow),
                  SizedBox(width: 8.w),
                  Text(
                    locationText,
                    style: AppTextStyles.bodyMedium(color: AppColors.yellow),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.hint, this.onTap});

  final String hint;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.h,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Icon(
              Iconsax.search_normal,
              size: 20.sp,
              color: AppColors.greyText.withValues(alpha: 0.85),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                hint,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.greyText.withValues(alpha: 0.9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton({this.onTap, required this.hasNotification});

  final VoidCallback? onTap;
  final bool hasNotification;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        width: 44.w,
        height: 44.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.notification,
                size: 20.sp,
                color: Colors.white,
              ),
            ),
            if (hasNotification)
              PositionedDirectional(
                top: 10.w,
                end: 10.w,
                child: Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.6),
                      width: 1,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

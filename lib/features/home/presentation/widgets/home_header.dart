import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_icons.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/filter/presentation/view/filter_view.dart';

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
            top: 4.h,
            bottom: 8.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(AppIcons.lloPng, width: 90.w),
                  const Spacer(),
                  _NotificationButton(
                    onTap: onNotificationsTap,
                    hasNotification: hasNotification,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () {
                  sl<AppNavigator>().push(screen: const FilterView());
                },
                child: _SearchField(hint: searchHint, onTap: onSearchTap),
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Icon(Iconsax.location, size: 16.sp, color: AppColors.onImage.withValues(alpha: 0.6)),
                  SizedBox(width: 6.w),
                  Text(
                    locationText,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.onImage.withValues(alpha: 0.6),
                    ),
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
        height: 42.h,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: AppColors.cardBg(context),
          borderRadius: BorderRadius.circular(999.r),
        ),
        child: Row(
          children: [
            Icon(
              Iconsax.search_normal_1,
              size: 20.sp,
              color: AppColors.greyText(context).withValues(alpha: 0.85),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                hint,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyText(context).withValues(alpha: 0.9),
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
        width: 40.w,
        height: 40.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Iconsax.notification,
              size: 22.sp,
              color: AppColors.onImage,
            ),
            if (hasNotification)
              PositionedDirectional(
                top: 8.w,
                end: 8.w,
                child: Container(
                  width: 9.w,
                  height: 9.w,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.onImage.withValues(alpha: 0.6),
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

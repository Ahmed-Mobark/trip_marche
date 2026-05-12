import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_icons.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/filter/presentation/view/filter_view.dart';

/// Collapsing home header used as a [SliverPersistentHeader].
///
/// Expanded: logo + notification bell, search bar (full width), location row.
/// Collapsed: search bar (shrunk, 25% opacity) + notification bell on its right.
class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  HomeHeaderDelegate({
    required this.searchHint,
    required this.locationText,
    required this.topPadding,
    this.onNotificationsTap,
    this.hasNotification = true,
  });

  final String searchHint;
  final String locationText;
  final double topPadding;
  final VoidCallback? onNotificationsTap;
  final bool hasNotification;

  static double expandedHeight(double topPadding) =>
      topPadding + 4.h + 40.h + 8.h + 42.h + 6.h + 18.h + 8.h;

  static double collapsedHeight(double topPadding) =>
      topPadding + 8.h + 42.h + 8.h;

  @override
  double get maxExtent => expandedHeight(topPadding);

  @override
  double get minExtent => collapsedHeight(topPadding);

  @override
  bool shouldRebuild(covariant HomeHeaderDelegate oldDelegate) =>
      searchHint != oldDelegate.searchHint ||
      locationText != oldDelegate.locationText ||
      topPadding != oldDelegate.topPadding ||
      hasNotification != oldDelegate.hasNotification;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final range = maxExtent - minExtent;
    final t = (shrinkOffset / range).clamp(0.0, 1.0);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: 16.w,
            end: 16.w,
            top: topPadding + 4.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo row — fades out
              if (t < 1.0)
                Opacity(
                  opacity: (1.0 - t * 2).clamp(0.0, 1.0),
                  child: SizedBox(
                    height: (40.h * (1.0 - t)).clamp(0.0, 40.h),
                    child: Row(
                      children: [
                        Image.asset(AppIcons.lloPng, width: 90.w),
                        const Spacer(),
                        if (t < 0.5)
                          _NotificationButton(
                            onTap: onNotificationsTap,
                            hasNotification: hasNotification,
                          ),
                      ],
                    ),
                  ),
                ),

              SizedBox(height: (8.h * (1.0 - t)).clamp(0.0, 8.h)),

              // Search row — shrinks + fades + bell moves beside it
              Row(
                children: [
                  Expanded(
                    child: Opacity(
                      opacity: 1.0 - (t * 0.75),
                      child: GestureDetector(
                        onTap: () => sl<AppNavigator>()
                            .push(screen: const FilterView()),
                        child: _SearchField(hint: searchHint),
                      ),
                    ),
                  ),
                  // Bell appears next to search when collapsed
                  if (t > 0.3)
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 8.w),
                      child: Opacity(
                        opacity: ((t - 0.3) / 0.7).clamp(0.0, 1.0),
                        child: _NotificationButton(
                          onTap: onNotificationsTap,
                          hasNotification: hasNotification,
                        ),
                      ),
                    ),
                ],
              ),

              // Location row — fades out
              if (t < 1.0) ...[
                SizedBox(height: (6.h * (1.0 - t)).clamp(0.0, 6.h)),
                Opacity(
                  opacity: (1.0 - t * 2.5).clamp(0.0, 1.0),
                  child: SizedBox(
                    height: (18.h * (1.0 - t)).clamp(0.0, 18.h),
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.location,
                          size: 16.sp,
                          color: AppColors.onImage.withValues(alpha: 0.6),
                        ),
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
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.hint});

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
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

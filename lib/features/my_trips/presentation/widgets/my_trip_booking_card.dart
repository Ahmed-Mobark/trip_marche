import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/data/dummy_data.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';

class MyTripBookingCard extends StatelessWidget {
  const MyTripBookingCard({
    super.key,
    required this.trip,
    required this.statusText,
    required this.statusColor,
    required this.locationText,
    required this.primaryActionText,
    required this.secondaryActionText,
    required this.bottomActionText,
    this.onFavoriteTap,
    this.isFavorite = true,
    this.onPrimaryActionTap,
    this.onSecondaryActionTap,
    this.onBottomActionTap,
  });

  final TripItem trip;
  final String statusText;
  final Color statusColor;
  final String locationText;
  final String primaryActionText;
  final String secondaryActionText;
  final String bottomActionText;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;
  final VoidCallback? onPrimaryActionTap;
  final VoidCallback? onSecondaryActionTap;
  final VoidCallback? onBottomActionTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18.r),
            child: SizedBox(
              width: 140.w,
              height: 180.w,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AppCachedNetworkImage(
                      imageUrl: trip.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  PositionedDirectional(
                    top: 10.h,
                    start: 10.w,
                    child: Container(
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Text(
                        statusText,
                        style: AppTextStyles.bodySmall(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        trip.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.subtitle(
                          color: AppColors.darkText,
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    InkWell(
                      onTap: onFavoriteTap,
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: AppColors.inputBg,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite ? Iconsax.heart5 : Iconsax.heart,
                          size: 18.sp,
                          color: isFavorite
                              ? AppColors.red
                              : AppColors.greyText,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Iconsax.star1,
                      size: 14.sp,
                      color: AppColors.starYellow,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      trip.rating.toStringAsFixed(1),
                      style: AppTextStyles.bodySmall(
                        color: AppColors.darkText,
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      ' (112)',
                      style: AppTextStyles.bodySmall(color: AppColors.greyText),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Icon(
                      Iconsax.location,
                      size: 14.sp,
                      color: AppColors.greyText,
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        locationText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmall(
                          color: AppColors.greyText,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Iconsax.calendar_1,
                      size: 14.sp,
                      color: AppColors.greyText,
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        trip.dateRange,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmall(
                          color: AppColors.greyText,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: _ActionPill(
                        text: primaryActionText,
                        backgroundColor: AppColors.primary,
                        textColor: Colors.white,
                        onTap: onPrimaryActionTap,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: _ActionPill(
                        text: secondaryActionText,
                        backgroundColor: Colors.white,
                        textColor: AppColors.darkText,
                        borderColor: AppColors.border,
                        onTap: onSecondaryActionTap,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                _BottomAction(text: bottomActionText, onTap: onBottomActionTap),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    this.onTap,
  });

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 30.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.r),
          border: borderColor == null ? null : Border.all(color: borderColor!),
        ),
        alignment: Alignment.center,
        child: Text(text, style: AppTextStyles.bodySmall(color: textColor)),
      ),
    );
  }
}

class _BottomAction extends StatelessWidget {
  const _BottomAction({required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.border),
        ),
        padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.document_download, size: 18.sp, color: AppColors.red),
            SizedBox(width: 10.w),
            Flexible(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyMedium(color: AppColors.darkText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

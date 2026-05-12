import 'package:flutter/material.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import '../../data/models/home_section_response.dart';

class PopularTripGridCard extends StatelessWidget {
  const PopularTripGridCard({
    super.key,
    required this.trip,
    this.onTap,
    this.onFavoriteTap,
  });

  final TripModel trip;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBg(context),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColors.border(context).withValues(alpha: 0.4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AppCachedNetworkImage(
                        imageUrl: trip.coverImage,
                        fit: BoxFit.cover,
                      ),
                      if (trip.badge != null && trip.badge!.isNotEmpty)
                        PositionedDirectional(
                          top: 10.h,
                          start: 10.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.error.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              trip.badge!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodySmall(
                                color: AppColors.onImage,
                              ).copyWith(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      PositionedDirectional(
                        top: 12.h,
                        end: 12.w,
                        child: Material(
                          color: AppColors.transparent,
                          child: InkWell(
                            onTap: onFavoriteTap,
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: BoxDecoration(
                                color: AppColors.white.withValues(alpha: 0.45),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                trip.isWishlisted
                                    ? Iconsax.heart5
                                    : Iconsax.heart,
                                size: 18.sp,
                                color: trip.isWishlisted
                                    ? AppColors.error
                                    : AppColors.onImage,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 12.w, end: 12.w),
              child: Text(
                trip.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.subtitle(
                  color: AppColors.darkText(context),
                ).copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 12.w, end: 12.w),
              child: Row(
                children: [
                  Icon(Iconsax.star1, size: 14.sp, color: AppColors.starYellow),
                  SizedBox(width: 6.w),
                  Text(
                    trip.rating.toStringAsFixed(1),
                    style: AppTextStyles.bodySmall(
                      color: AppColors.darkText(context),
                    ).copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '(${trip.reviewsCount})',
                    style: AppTextStyles.bodySmall(
                      color: AppColors.greyText(context),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 12.w, end: 12.w),
              child: Row(
                children: [
                  Icon(
                    Iconsax.location,
                    size: 14.sp,
                    color: AppColors.greyText(context),
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      '${context.tr.myTripsFromPrefix} ${trip.fromLocation}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body(
                        color: AppColors.greyText(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 12.w, end: 12.w),
              child: Row(
                children: [
                  Icon(
                    Iconsax.calendar_1,
                    size: 14.sp,
                    color: AppColors.greyText(context),
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      trip.dateRange,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body(
                        color: AppColors.greyText(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 12.w,
                end: 12.w,
                bottom: 12.h,
              ),
              child: Row(
                children: [
                  if (trip.discountPrice != null) ...[
                    Text(
                      PriceFormatter.format(trip.discountPrice!, currency: trip.currency),
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.primary,
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      PriceFormatter.format(trip.price, currency: trip.currency),
                      style: AppTextStyles.bodySmall(
                        color: AppColors.greyText(context),
                      ).copyWith(decoration: TextDecoration.lineThrough),
                    ),
                  ] else
                    Text(
                      PriceFormatter.format(trip.price, currency: trip.currency),
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.primary,
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

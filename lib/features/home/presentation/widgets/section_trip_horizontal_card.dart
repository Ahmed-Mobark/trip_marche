import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/utils/price_formatter.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';

import '../../data/models/home_section_response.dart';

/// Horizontal trip card used in the generic "See all" list view for any
/// home section (Popular, Sponsored, Domestic, International, Special, …).
///
/// Visually mirrors `WishlistTripCard` / `MyTripCatalogCard` so the catalog
/// experience feels consistent across the app: cover image on the start side
/// and the trip details (title, rating, location, dates, badge, price) on
/// the end side.
class SectionTripHorizontalCard extends StatelessWidget {
  const SectionTripHorizontalCard({
    super.key,
    required this.trip,
    this.onTap,
    this.onFavoriteTap,
  });

  final TripModel trip;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  ({String text, Color color})? _derivedFlagBadge(BuildContext context) {
    if (trip.badge != null && trip.badge!.isNotEmpty) {
      return null;
    }
    if (trip.flags.recommended) {
      return (text: context.tr.wishlistRecommended, color: AppColors.warning);
    }
    if (trip.flags.sponsored) {
      return (
        text: context.tr.wishlistNewInTripMarche,
        color: AppColors.primary,
      );
    }
    if (trip.flags.special) {
      return (text: context.tr.wishlistBestPrice, color: AppColors.success);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final flagBadge = _derivedFlagBadge(context);
    final hasDiscount =
        trip.discountPrice != null && trip.discountPrice! < trip.price;

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.cardBg(context),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.all(10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 135.w,
                        height: 170.h,
                        child: AppCachedNetworkImage(
                          imageUrl: trip.coverImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (trip.badge != null && trip.badge!.isNotEmpty)
                        PositionedDirectional(
                          top: 0,
                          start: 0,
                          end: 0,
                          child: Container(
                            padding: EdgeInsetsDirectional.only(
                              start: 12.w,
                              end: 12.w,
                              top: 4.h,
                              bottom: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.starYellow,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(14.r),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                trip.badge!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodySmall(
                                  color: AppColors.onImage,
                                ).copyWith(fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              trip.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  AppTextStyles.bodySmall(
                                    color: AppColors.darkText(context),
                                  ).copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                    height: 1.25,
                                  ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          InkWell(
                            onTap: onFavoriteTap,
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              width: 38.w,
                              height: 38.w,
                              decoration: BoxDecoration(
                                color: AppColors.background(context),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                trip.isWishlisted
                                    ? Iconsax.heart5
                                    : Iconsax.heart,
                                size: 18.sp,
                                color: trip.isWishlisted
                                    ? AppColors.error
                                    : AppColors.greyText(context),
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
                              color: AppColors.darkText(context),
                            ).copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ' (${trip.reviewsCount})',
                            style: AppTextStyles.bodySmall(
                              color: AppColors.greyText(context),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
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
                              style: AppTextStyles.bodySmall(
                                color: AppColors.greyText(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Row(
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
                              style: AppTextStyles.bodySmall(
                                color: AppColors.greyText(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (flagBadge != null) ...[
                        SizedBox(height: 8.h),
                        Container(
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: flagBadge.color,
                            borderRadius: BorderRadius.circular(7.r),
                          ),
                          child: Text(
                            flagBadge.text,
                            style: AppTextStyles.bodySmall(
                              color: AppColors.onImage,
                            ).copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                      SizedBox(height: 10.h),
                      Wrap(
                        spacing: 6.w,
                        runSpacing: 4.h,
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          if (hasDiscount) ...[
                            Text(
                              PriceFormatter.format(
                                trip.discountPrice!,
                                currency: trip.currency,
                              ),
                              style:
                                  AppTextStyles.heading3(
                                    color: AppColors.darkText(context),
                                  ).copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17.sp,
                                  ),
                            ),
                            Text(
                              PriceFormatter.format(
                                trip.price,
                                currency: trip.currency,
                              ),
                              style: AppTextStyles.bodySmall(
                                color: AppColors.greyText(context),
                              ).copyWith(decoration: TextDecoration.lineThrough),
                            ),
                          ] else
                            Text(
                              PriceFormatter.format(
                                trip.price,
                                currency: trip.currency,
                              ),
                              style:
                                  AppTextStyles.heading3(
                                    color: AppColors.darkText(context),
                                  ).copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17.sp,
                                  ),
                            ),
                          Text(
                            '/${context.tr.homePerPerson}',
                            style: AppTextStyles.bodySmall(
                              color: AppColors.greyText(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

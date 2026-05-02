import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../data/models/home_section_response.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_cached_network_image.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxH = constraints.maxHeight;
        final imageH = (maxH * 0.58).clamp(116.0, 220.0);
        return GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18.r),
                  child: SizedBox(
                    height: imageH,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: AppCachedNetworkImage(
                            imageUrl: trip.coverImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        PositionedDirectional(
                          top: 10.h,
                          end: 10.w,
                          child: Material(
                            color: AppColors.transparent,
                            child: InkWell(
                              onTap: onFavoriteTap,
                              borderRadius: BorderRadius.circular(999),
                              child: Container(
                                width: 32.w,
                                height: 32.w,
                                decoration: BoxDecoration(
                                  color: AppColors.shadow.withValues(
                                    alpha: 0.35,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  trip.isWishlisted
                                      ? Iconsax.heart5
                                      : Iconsax.heart,
                                  size: 16.sp,
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
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 12.w, end: 12.w),
                  child: Text(
                    trip.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.subtitle(
                      color: AppColors.darkText,
                    ).copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 6.h),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 12.w, end: 12.w),
                  child: Row(
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
                        ' (${trip.reviewsCount})',
                        style: AppTextStyles.bodySmall(
                          color: AppColors.greyText,
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
                        color: AppColors.greyText,
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          trip.fromLocation,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.greyText,
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
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 12.w,
                    end: 12.w,
                    bottom: 12.h,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (trip.discountPrice != null) ...[
                        Text(
                          trip.discountPrice!.toStringAsFixed(0),
                          style:
                              AppTextStyles.heading3(
                                color: AppColors.darkText,
                              ).copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 18.sp,
                              ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          trip.price.toStringAsFixed(0),
                          style: AppTextStyles.bodySmall(
                            color: AppColors.greyText,
                          ).copyWith(decoration: TextDecoration.lineThrough),
                        ),
                      ] else
                        Text(
                          trip.price.toStringAsFixed(0),
                          style:
                              AppTextStyles.heading3(
                                color: AppColors.darkText,
                              ).copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 18.sp,
                              ),
                        ),
                      Text(
                        ' /Person',
                        style: AppTextStyles.bodySmall(
                          color: AppColors.greyText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

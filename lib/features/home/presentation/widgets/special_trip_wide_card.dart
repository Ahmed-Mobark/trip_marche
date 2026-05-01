import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../data/models/home_section_response.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import '../../../../core/extensions/localization.dart';

class SpecialTripWideCard extends StatelessWidget {
  const SpecialTripWideCard({
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
        padding: EdgeInsetsDirectional.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Stack(
                children: [
                  SizedBox(
                    width: 150.w,
                    height: 200.h,
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
                            top: Radius.circular(16.r),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            trip.badge!,
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
                          style: AppTextStyles.bodySmall(
                            color: AppColors.darkText,
                          ).copyWith(fontWeight: FontWeight.w800),
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
                            trip.isWishlisted ? Iconsax.heart5 : Iconsax.heart,
                            size: 18.sp,
                            color: trip.isWishlisted
                                ? AppColors.error
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
                        ' (${trip.reviewsCount})',
                        style: AppTextStyles.bodySmall(
                          color: AppColors.greyText,
                        ),
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
                  SizedBox(height: 12.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (trip.discountPrice != null) ...[
                        Text(
                          '\$${trip.discountPrice!.toStringAsFixed(0)}',
                          style: AppTextStyles.heading3(
                            color: AppColors.darkText,
                          ).copyWith(fontWeight: FontWeight.w900),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '\$${trip.price.toStringAsFixed(0)}',
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.greyText,
                          ).copyWith(decoration: TextDecoration.lineThrough),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ] else
                        Text(
                          '\$${trip.price.toStringAsFixed(0)}',
                          style: AppTextStyles.heading3(
                            color: AppColors.darkText,
                          ).copyWith(fontWeight: FontWeight.w900),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      Text(
                        ' /${context.tr.homePerPerson}',
                        style: AppTextStyles.bodySmall(
                          color: AppColors.greyText,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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

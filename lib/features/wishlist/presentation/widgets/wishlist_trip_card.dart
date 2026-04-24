import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/data/dummy_data.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import 'package:trip_marche/features/trip_details/presentation/view/trip_details_view.dart';

class WishlistTripCard extends StatelessWidget {
  const WishlistTripCard({
    super.key,
    required this.trip,
    required this.badgeText,
    required this.badgeColor,
    this.onFavoriteTap,
    this.isFavorite = true,
  });

  final TripItem trip;
  final String badgeText;
  final Color badgeColor;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        sl<AppNavigator>().push(screen: TripDetailsView());
      },
      child: Container(
        padding: EdgeInsetsDirectional.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: SizedBox(
                width: 150.w,
                height: 200.h,
                child: AppCachedNetworkImage(
                  imageUrl: trip.imageUrl,
                  fit: BoxFit.cover,
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
                          trip.location,
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
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      badgeText,
                      style: AppTextStyles.bodySmall(
                        color: Colors.white,
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$1000',
                        style: AppTextStyles.bodyMedium(
                          color: AppColors.greyText,
                        ).copyWith(decoration: TextDecoration.lineThrough),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '\$${trip.price.toStringAsFixed(0)}',
                        style: AppTextStyles.heading3(
                          color: AppColors.darkText,
                        ).copyWith(fontWeight: FontWeight.w900),
                      ),
                      Text(
                        ' /Person',
                        style: AppTextStyles.bodySmall(
                          color: AppColors.greyText,
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
    );
  }
}

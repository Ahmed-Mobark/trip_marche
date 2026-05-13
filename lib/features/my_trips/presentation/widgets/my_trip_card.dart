import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/data/dummy_data.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/my_trips/presentation/widgets/status_badge.dart';

class MyTripCard extends StatelessWidget {
  final TripItem trip;
  final VoidCallback? onTap;

  const MyTripCard({super.key, required this.trip, this.onTap});

  static double get _thumb => 110.w;
  static double get _radius => 12.r;

  @override
  Widget build(BuildContext context) {
    final thumb = _thumb;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: AppColors.cardBg(context),
          borderRadius: BorderRadius.circular(_radius),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.06),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(_radius),
                bottomStart: Radius.circular(_radius),
              ).resolve(Directionality.of(context)),
              child: CachedNetworkImage(
                imageUrl: trip.imageUrl,
                width: thumb,
                height: thumb,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: thumb,
                  height: thumb,
                  color: AppColors.inputBg(context),
                ),
                errorWidget: (context, url, error) => Container(
                  width: thumb,
                  height: thumb,
                  color: AppColors.inputBg(context),
                  child: Icon(Icons.image_not_supported, size: 24.sp),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.title,
                      style: AppTextStyles.subtitle().copyWith(fontSize: 15.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Iconsax.calendar_1,
                          size: 14.sp,
                          color: AppColors.greyText(context),
                        ),
                        SizedBox(width: 4.w),
                        Text(trip.dateRange, style: AppTextStyles.caption()),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Iconsax.location,
                          size: 14.sp,
                          color: AppColors.greyText(context),
                        ),
                        SizedBox(width: 4.w),
                        Text(trip.location, style: AppTextStyles.caption()),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${trip.price.toInt()}',
                          style: AppTextStyles.subtitle(
                            color: AppColors.primary,
                          ).copyWith(fontSize: 15.sp),
                        ),
                        if (trip.status != null)
                          StatusBadge(status: trip.status!),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

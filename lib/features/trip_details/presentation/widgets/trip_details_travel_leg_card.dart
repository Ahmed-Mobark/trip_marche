import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_details_info_card.dart';

class TripDetailsTravelLegCard extends StatelessWidget {
  const TripDetailsTravelLegCard({
    super.key,
    required this.leftCity,
    required this.leftTime,
    required this.centerIcon,
    required this.centerDate,
    required this.rightCity,
    required this.rightTime,
    this.centerLabel,
    this.flipIcon = false,
  });

  final String leftCity;
  final String leftTime;
  final IconData centerIcon;
  final String centerDate;
  final String rightCity;
  final String rightTime;
  final String? centerLabel;

  /// Set to true for return flights so the center icon points left.
  final bool flipIcon;

  @override
  Widget build(BuildContext context) {
    return TripDetailsInfoCard(
      withShadow: false,
      borderRadius: 16.r,
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      child: Row(
        children: [
          Expanded(
            child: _CityTimeColumn(
              city: leftCity,
              time: leftTime,
              alignEnd: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.flip(
                  flipX: flipIcon,
                  child: Icon(
                    centerIcon,
                    color: AppColors.greyText,
                    size: 20.sp,
                  ),
                ),
                if (centerLabel != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    centerLabel!,
                    style: AppTextStyles.caption(
                      color: AppColors.greyText,
                    ).copyWith(fontSize: 12.sp),
                  ),
                ],
                SizedBox(height: 4.h),
                Text(
                  centerDate,
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.darkText,
                  ).copyWith(fontWeight: FontWeight.w700, fontSize: 15.sp),
                ),
              ],
            ),
          ),
          Expanded(
            child: _CityTimeColumn(
              city: rightCity,
              time: rightTime,
              alignEnd: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _CityTimeColumn extends StatelessWidget {
  const _CityTimeColumn({
    required this.city,
    required this.time,
    required this.alignEnd,
  });

  final String city;
  final String time;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    final crossAxis =
        alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final textAlign = alignEnd ? TextAlign.end : TextAlign.start;

    return Column(
      crossAxisAlignment: crossAxis,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          city,
          textAlign: textAlign,
          style: TextStyles.textViewSemiBold14,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),
        Text(time, textAlign: textAlign, style: TextStyles.textViewRegular12),
      ],
    );
  }
}


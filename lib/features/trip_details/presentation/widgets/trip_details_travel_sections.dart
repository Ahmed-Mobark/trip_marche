import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_details_info_card.dart';

class TripDetailsTravelSections extends StatelessWidget {
  const TripDetailsTravelSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr.tripDetailsFlightDetailsTitle,
            style: TextStyles.textViewBold14,
          ),
          SizedBox(height: 14.h),
          _AirlineRow(
            label: context.tr.tripDetailsAirlineLabel,
            name: context.tr.tripDetailsAirlineName,
          ),
          SizedBox(height: 12.h),
          _TravelLegCard(
            leftCity: context.tr.tripDetailsFlightLeg1FromCity,
            leftTime: context.tr.tripDetailsFlightLeg1FromTime,
            centerIcon: Iconsax.airplane,
            centerDate: context.tr.tripDetailsFlightLeg1Date,
            rightCity: context.tr.tripDetailsFlightLeg1ToCity,
            rightTime: context.tr.tripDetailsFlightLeg1ToTime,
          ),
          SizedBox(height: 12.h),
          _TravelLegCard(
            leftCity: context.tr.tripDetailsFlightLeg2FromCity,
            leftTime: context.tr.tripDetailsFlightLeg2FromTime,
            centerIcon: Iconsax.airplane,
            centerDate: context.tr.tripDetailsFlightLeg2Date,
            rightCity: context.tr.tripDetailsFlightLeg2ToCity,
            rightTime: context.tr.tripDetailsFlightLeg2ToTime,
          ),
          SizedBox(height: 24.h),
          Text(
            context.tr.tripDetailsTransportationTitle,
            style: AppTextStyles.heading2(
              color: AppColors.darkText,
            ).copyWith(fontSize: 22.sp),
          ),
          SizedBox(height: 14.h),
          _TravelLegCard(
            leftCity: context.tr.tripDetailsTransportLeg1FromCity,
            leftTime: context.tr.tripDetailsTransportLeg1FromTime,
            centerIcon: Iconsax.bus,
            centerLabel: context.tr.tripDetailsTransportLeg1CenterLabel,
            centerDate: context.tr.tripDetailsTransportLeg1Date,
            rightCity: context.tr.tripDetailsTransportLeg1ToCity,
            rightTime: context.tr.tripDetailsTransportLeg1ToTime,
          ),
          SizedBox(height: 12.h),
          _TravelLegCard(
            leftCity: context.tr.tripDetailsTransportLeg2FromCity,
            leftTime: context.tr.tripDetailsTransportLeg2FromTime,
            centerIcon: Iconsax.ship,
            centerLabel: context.tr.tripDetailsTransportLeg2CenterLabel,
            centerDate: context.tr.tripDetailsTransportLeg2Date,
            rightCity: context.tr.tripDetailsTransportLeg2ToCity,
            rightTime: context.tr.tripDetailsTransportLeg2ToTime,
          ),
          SizedBox(height: 24.h),
          Text(
            context.tr.tripDetailsDestinationsTitle,
            style: AppTextStyles.heading2(
              color: AppColors.darkText,
            ).copyWith(fontSize: 22.sp),
          ),
          SizedBox(height: 14.h),
          const _DestinationsRow(),
        ],
      ),
    );
  }
}

class _AirlineRow extends StatelessWidget {
  const _AirlineRow({required this.label, required this.name});

  final String label;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Iconsax.airplane_square, size: 40.r, color: AppColors.primaryDark),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.caption(
                color: AppColors.greyText,
              ).copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 2.h),
            Text(
              name,
              style: AppTextStyles.heading3(
                color: AppColors.darkText,
              ).copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}

class _TravelLegCard extends StatelessWidget {
  const _TravelLegCard({
    required this.leftCity,
    required this.leftTime,
    required this.centerIcon,
    required this.centerDate,
    required this.rightCity,
    required this.rightTime,
    this.centerLabel,
  });

  final String leftCity;
  final String leftTime;
  final IconData centerIcon;
  final String centerDate;
  final String rightCity;
  final String rightTime;
  final String? centerLabel;

  @override
  Widget build(BuildContext context) {
    return TripDetailsInfoCard(
      withShadow: false,
      borderRadius: 18.r,
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 18.w,
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
          SizedBox(width: 12.w),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(centerIcon, color: AppColors.greyText, size: 22.sp),
              if (centerLabel != null) ...[
                SizedBox(height: 6.h),
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
                ).copyWith(fontWeight: FontWeight.w700, fontSize: 16.sp),
              ),
            ],
          ),
          SizedBox(width: 12.w),
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
    final alignment = alignEnd
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          city,
          style: AppTextStyles.heading3(
            color: AppColors.darkText,
          ).copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),
        Text(
          time,
          style: AppTextStyles.caption(
            color: AppColors.greyText,
          ).copyWith(fontSize: 13.sp),
        ),
      ],
    );
  }
}

class _DestinationsRow extends StatelessWidget {
  const _DestinationsRow();

  static const _urls = <String>[
    'https://images.unsplash.com/photo-1539635278303-d4002c07eae3?w=600',
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=600',
    'https://images.unsplash.com/photo-1528909514045-2fa4ac7a08ba?w=600',
  ];

  @override
  Widget build(BuildContext context) {
    final labels = [
      context.tr.tripDetailsDestinationDahab,
      context.tr.tripDetailsDestinationHurghada,
      context.tr.tripDetailsDestinationParis,
    ];

    return SizedBox(
      height: 96.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _urls.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (_, i) => ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AppCachedNetworkImage(
                imageUrl: _urls[i],
                width: 120.w,
                height: 96.h,
                fit: BoxFit.cover,
              ),
              Container(
                width: 120.w,
                padding: EdgeInsetsDirectional.symmetric(vertical: 8.h),
                color: Colors.black.withValues(alpha: 0.35),
                child: Text(
                  labels[i],
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.white,
                  ).copyWith(fontWeight: FontWeight.w600, fontSize: 16.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

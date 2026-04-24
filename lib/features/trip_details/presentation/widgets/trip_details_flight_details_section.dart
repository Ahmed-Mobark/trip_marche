import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_details_travel_leg_card.dart';

class TripDetailsFlightDetailsSection extends StatelessWidget {
  const TripDetailsFlightDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        TripDetailsTravelLegCard(
          leftCity: context.tr.tripDetailsFlightLeg1FromCity,
          leftTime: context.tr.tripDetailsFlightLeg1FromTime,
          centerIcon: Iconsax.airplane,
          centerDate: context.tr.tripDetailsFlightLeg1Date,
          rightCity: context.tr.tripDetailsFlightLeg1ToCity,
          rightTime: context.tr.tripDetailsFlightLeg1ToTime,
          flipIcon: false,
        ),
        SizedBox(height: 12.h),
        TripDetailsTravelLegCard(
          leftCity: context.tr.tripDetailsFlightLeg2FromCity,
          leftTime: context.tr.tripDetailsFlightLeg2FromTime,
          centerIcon: Iconsax.airplane,
          centerDate: context.tr.tripDetailsFlightLeg2Date,
          rightCity: context.tr.tripDetailsFlightLeg2ToCity,
          rightTime: context.tr.tripDetailsFlightLeg2ToTime,
          flipIcon: true,
        ),
      ],
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 44.r,
          height: 44.r,
          decoration: BoxDecoration(
            color: AppColors.primaryDark.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            Iconsax.airplane_square,
            size: 26.r,
            color: AppColors.primaryDark,
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: TextStyles.textViewRegular12),
            SizedBox(height: 2.h),
            Text(name, style: TextStyles.textViewSemiBold14),
          ],
        ),
      ],
    );
  }
}


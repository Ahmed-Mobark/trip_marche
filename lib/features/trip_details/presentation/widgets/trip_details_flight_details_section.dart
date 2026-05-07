import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'package:trip_marche/features/trip_details/presentation/trip_details_ui_formatters.dart';
import 'trip_details_travel_leg_card.dart';

class TripDetailsFlightDetailsSection extends StatelessWidget {
  const TripDetailsFlightDetailsSection({super.key, required this.trip});

  final TripDetails trip;

  int _flightSort(TripFlightLeg a, TripFlightLeg b) {
    if (a.direction == 'outbound' && b.direction != 'outbound') {
      return -1;
    }
    if (a.direction != 'outbound' && b.direction == 'outbound') {
      return 1;
    }
    return a.departAt.compareTo(b.departAt);
  }

  @override
  Widget build(BuildContext context) {
    final flights = [...trip.flights]..sort(_flightSort);
    if (flights.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr.tripDetailsFlightDetailsTitle,
            style: TextStyles.textViewBold14,
          ),
          SizedBox(height: 8.h),
          Text(
            context.tr.tripDetailsNoFlights,
            style: TextStyles.textViewRegular14.copyWith(color: AppColors.greyText(context)),
          ),
        ],
      );
    }

    final primaryAirline = flights.first.airline.name;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.tripDetailsFlightDetailsTitle,
          style: TextStyles.textViewBold14,
        ),
        SizedBox(height: 8.h),
        _AirlineRow(
          label: context.tr.tripDetailsAirlineLabel,
          name: primaryAirline,
        ),
        for (var i = 0; i < flights.length; i++) ...[
          SizedBox(height: i == 0 ? 12.h : 12.h),
          TripDetailsTravelLegCard(
            leftCity: flights[i].fromCity,
            leftTime: TripDetailsUiFormatters.timeOfDay(context, flights[i].departAt),
            centerIcon: Iconsax.airplane,
            centerDate: TripDetailsUiFormatters.monthDay(context, flights[i].departAt),
            rightCity: flights[i].toCity,
            rightTime: TripDetailsUiFormatters.timeOfDay(context, flights[i].arriveAt),
            flipIcon: flights[i].direction == 'return',
          ),
        ],
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

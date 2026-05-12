import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'trip_details_accommodation_section.dart';
import 'trip_details_destination_details_section.dart';
import 'trip_details_flight_details_section.dart';
import 'trip_details_transportation_section.dart';

class TripDetailsTravelSections extends StatelessWidget {
  const TripDetailsTravelSections({super.key, required this.trip});

  final TripDetails trip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TripDetailsFlightDetailsSection(trip: trip),
          SizedBox(height: 16.h),
          Divider(color: AppColors.border(context), height: 1),
          SizedBox(height: 16.h),
          TripDetailsTransportationSection(trip: trip),
          SizedBox(height: 24.h),
          TripDetailsDestinationDetailsSection(trip: trip),
          SizedBox(height: 24.h),
          TripDetailsAccommodationSection(trip: trip),
          SizedBox(height: 120.h),
        ],
      ),
    );
  }
}

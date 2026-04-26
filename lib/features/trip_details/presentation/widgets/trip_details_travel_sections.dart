import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'trip_details_accommodation_section.dart';
import 'trip_details_destination_details_section.dart';
import 'trip_details_flight_details_section.dart';
import 'trip_details_transportation_section.dart';

class TripDetailsTravelSections extends StatelessWidget {
  const TripDetailsTravelSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TripDetailsFlightDetailsSection(),
          SizedBox(height: 24.h),
          const TripDetailsTransportationSection(),
          SizedBox(height: 24.h),
          const TripDetailsDestinationDetailsSection(),
          SizedBox(height: 24.h),
          const TripDetailsAccommodationSection(),
          SizedBox(height: 120.h),
        ],
      ),
    );
  }
}

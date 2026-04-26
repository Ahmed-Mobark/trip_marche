import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/config/styles/styles.dart';
import '../../../../core/extensions/localization.dart';
import 'trip_details_travel_leg_card.dart';

class TripDetailsTransportationSection extends StatelessWidget {
  const TripDetailsTransportationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.tripDetailsTransportationTitle,
          style: TextStyles.textViewBold14,
        ),
        SizedBox(height: 14.h),
        TripDetailsTravelLegCard(
          leftCity: context.tr.tripDetailsTransportLeg1FromCity,
          leftTime: context.tr.tripDetailsTransportLeg1FromTime,
          centerIcon: Iconsax.bus,
          centerLabel: context.tr.tripDetailsTransportLeg1CenterLabel,
          centerDate: context.tr.tripDetailsTransportLeg1Date,
          rightCity: context.tr.tripDetailsTransportLeg1ToCity,
          rightTime: context.tr.tripDetailsTransportLeg1ToTime,
        ),
        SizedBox(height: 12.h),
        TripDetailsTravelLegCard(
          leftCity: context.tr.tripDetailsTransportLeg2FromCity,
          leftTime: context.tr.tripDetailsTransportLeg2FromTime,
          centerIcon: Iconsax.ship,
          centerLabel: context.tr.tripDetailsTransportLeg2CenterLabel,
          centerDate: context.tr.tripDetailsTransportLeg2Date,
          rightCity: context.tr.tripDetailsTransportLeg2ToCity,
          rightTime: context.tr.tripDetailsTransportLeg2ToTime,
        ),
      ],
    );
  }
}


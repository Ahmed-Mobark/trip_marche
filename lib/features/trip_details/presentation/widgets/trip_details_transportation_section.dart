import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'package:trip_marche/features/trip_details/presentation/trip_details_ui_formatters.dart';
import 'trip_details_travel_leg_card.dart';

class TripDetailsTransportationSection extends StatelessWidget {
  const TripDetailsTransportationSection({super.key, required this.trip});

  final TripDetails trip;

  IconData _iconForType(String type) {
    final t = type.toLowerCase();
    if (t.contains('boat') || t.contains('ship') || t == 'ferry') {
      return Iconsax.ship;
    }
    if (t.contains('train')) {
      return Iconsax.bus; // iconsax may not have train in set
    }
    return Iconsax.bus;
  }

  @override
  Widget build(BuildContext context) {
    final legs = trip.transports;
    if (legs.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr.tripDetailsTransportationTitle,
            style: TextStyles.textViewBold14,
          ),
          SizedBox(height: 12.h),
          Text(
            context.tr.tripDetailsNoTransport,
            style: TextStyles.textViewRegular14.copyWith(color: AppColors.greyText),
          ),
        ],
      );
    }

    final sorted = [...legs]..sort((a, b) => a.departAt.compareTo(b.departAt));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.tripDetailsTransportationTitle,
          style: TextStyles.textViewBold14,
        ),
        SizedBox(height: 14.h),
        for (var i = 0; i < sorted.length; i++) ...[
          if (i > 0) SizedBox(height: 12.h),
          TripDetailsTravelLegCard(
            leftCity: sorted[i].fromCity,
            leftTime: TripDetailsUiFormatters.timeOfDay(context, sorted[i].departAt),
            centerIcon: _iconForType(sorted[i].type),
            centerLabel: sorted[i].company.name.isNotEmpty
                ? sorted[i].company.name
                : TripDetailsUiFormatters.transportTypeLabel(sorted[i].type),
            centerDate: TripDetailsUiFormatters.monthDay(context, sorted[i].departAt),
            rightCity: sorted[i].toCity,
            rightTime: TripDetailsUiFormatters.timeOfDay(context, sorted[i].arriveAt),
          ),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/trip_details/presentation/cubit/trip_details_cubit.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_details_booking_bar.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_details_hero_header.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_details_stat_grid.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_details_post_stats_sections.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_details_program_section.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_details_travel_sections.dart';

class TripDetailsView extends StatelessWidget {
  const TripDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TripDetailsCubit(),
      child: const _TripDetailsBody(),
    );
  }
}

class _TripDetailsBody extends StatelessWidget {
  const _TripDetailsBody();

  Widget _buildStatGrid(BuildContext context) {
    return TripDetailsStatGrid(
      cells: [
        TripDetailsStatCellData(
          icon: Iconsax.calendar,
          label: context.tr.tripDetailsDurationLabel,
          value: context.tr.tripDetailsDurationValue,
        ),
        TripDetailsStatCellData(
          icon: Iconsax.people,
          label: context.tr.tripDetailsGroupSizeLabel,
          value: context.tr.tripDetailsGroupSizeValue,
        ),
        TripDetailsStatCellData(
          icon: Iconsax.routing,
          label: context.tr.tripDetailsStatCitiesLabel,
          value: context.tr.tripDetailsStatCitiesValue,
        ),
        TripDetailsStatCellData(
          icon: Iconsax.airplane,
          label: context.tr.tripDetailsTypeLabel,
          value: context.tr.tripDetailsTypeValue,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 20.w;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TripDetailsHeroHeader(),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: AppColors.white),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: horizontalPadding,
                      end: horizontalPadding,
                      bottom: 120.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStatGrid(context),
                        const TripDetailsPostStatsSections(),
                        const TripDetailsProgramSection(),
                        const TripDetailsTravelSections(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: 0,
            start: 0,
            end: 0,
            child: TripDetailsBookingBar(
              priceLabel: context.tr.tripDetailsStartingFrom,
              priceText: context.tr.tripDetailsBookingFromPrice,
              secondaryLabel: 'Pay When Arrive',
              secondaryBadgeText: '+400\$',
              bookNowText: context.tr.tripDetailsBookNow,
              onBookNow: () {},
            ),
          ),
        ],
      ),
    );
  }
}

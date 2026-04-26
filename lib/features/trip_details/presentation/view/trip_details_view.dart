import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import '../cubit/trip_details_cubit.dart';
import '../widgets/trip_details_booking_bar.dart';
import '../widgets/trip_details_hero_header.dart';
import '../widgets/trip_details_stat_grid.dart';
import '../widgets/trip_details_post_stats_sections.dart';
import '../widgets/trip_details_program_section.dart';
import '../widgets/trip_details_travel_sections.dart';

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
    // Figma-like layout: hero image + rounded "sheet" that overlaps the hero.
    final horizontalPadding = 16.w;
    final sheetTopRadius = 28.r;
    final sheetOverlap = 26.h;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: TripDetailsHeroHeader()),
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: Offset(0, -sheetOverlap),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(sheetTopRadius),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 22.r,
                          offset: Offset(0, 10.h),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: horizontalPadding,
                        end: horizontalPadding,
                        top: 18.h,
                        bottom: 140.h,
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
                ),
              ),
            ],
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

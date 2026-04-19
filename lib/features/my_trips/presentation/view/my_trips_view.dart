import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/data/dummy_data.dart';
import 'package:trip_marche/features/my_trips/presentation/widgets/my_trip_card.dart';
import 'package:trip_marche/core/extensions/localization.dart';

class MyTripsView extends StatelessWidget {
  const MyTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: true,
          title: Text(context.tr.myTripsTitle, style: AppTextStyles.heading3()),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.greyText,
            indicatorColor: AppColors.primary,
            indicatorWeight: 2.5,
            labelStyle: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            tabs: [
              Tab(text: context.tr.myTripsTabUpcoming),
              Tab(text: context.tr.myTripsTabPast),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTripList(context, DummyData.upcomingTrips),
            _buildTripList(context, DummyData.pastTrips),
          ],
        ),
      ),
    );
  }

  Widget _buildTripList(BuildContext context, List<TripItem> trips) {
    if (trips.isEmpty) {
      return _buildEmptyState(context);
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        return MyTripCard(trip: trips[index]);
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: AppColors.lightBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Iconsax.map,
              size: 36,
              color: AppColors.greyText,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.myTripsEmptyTitle,
            style: AppTextStyles.heading3(color: AppColors.secondaryText),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr.myTripsEmptyDescription,
            style: AppTextStyles.bodyMedium(color: AppColors.greyText),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            ),
            child: Text(
              context.tr.myTripsExploreTrips,
              style: AppTextStyles.button(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}

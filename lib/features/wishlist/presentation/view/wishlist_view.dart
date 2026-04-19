import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/data/dummy_data.dart';
import 'package:trip_marche/core/widgets/trip_card.dart';
import 'package:trip_marche/core/extensions/localization.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final trips = DummyData.popularTrips;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(context.tr.wishlistTitle, style: AppTextStyles.heading3()),
        automaticallyImplyLeading: false,
      ),
      body: trips.isEmpty ? _buildEmptyState(context) : _buildGrid(trips),
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
            decoration: BoxDecoration(
              color: AppColors.lightBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Iconsax.heart,
              size: 36,
              color: AppColors.greyText,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.wishlistEmptyTitle,
            style: AppTextStyles.heading3(color: AppColors.secondaryText),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr.wishlistEmptyDescription,
            style: AppTextStyles.bodyMedium(color: AppColors.greyText),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(List<TripItem> trips) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.68,
      ),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        return TripCardGrid(trip: trips[index]);
      },
    );
  }
}

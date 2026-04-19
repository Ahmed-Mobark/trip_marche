import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/data/dummy_data.dart';
import 'package:trip_marche/core/widgets/trip_card.dart';

class SearchResultView extends StatelessWidget {
  const SearchResultView({super.key});

  @override
  Widget build(BuildContext context) {
    // Combine multiple lists for search results dummy data
    final allTrips = [
      ...DummyData.popularTrips,
      ...DummyData.domesticTrips,
      ...DummyData.internationalTrips,
      ...DummyData.recommendedTrips,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildSearchBar(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.lightBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Iconsax.setting_4,
                  color: AppColors.secondaryText, size: 20),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '${allTrips.length} trips found',
              style: AppTextStyles.bodyMedium(color: AppColors.greyText),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.68,
              ),
              itemCount: allTrips.length,
              itemBuilder: (context, index) {
                return TripCardGrid(trip: allTrips[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(Iconsax.search_normal,
              color: AppColors.greyText, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Sharm El Sheikh',
              style: AppTextStyles.bodyMedium(color: AppColors.darkText),
            ),
          ),
          const Icon(Iconsax.close_circle,
              color: AppColors.greyText, size: 18),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}

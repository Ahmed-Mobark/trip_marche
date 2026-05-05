import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/data/dummy_data.dart';
import '../../../../core/widgets/trip_card.dart';
import '../../../../core/extensions/localization.dart';

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
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildSearchBar(context),
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
              child: Icon(
                Iconsax.setting_4,
                color: AppColors.secondaryText,
                size: 20,
              ),
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
              context.tr.searchTripsFound(allTrips.length.toString()),
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

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Icon(Iconsax.search_normal, color: AppColors.greyText, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              context.tr.searchQueryExample,
              style: AppTextStyles.bodyMedium(color: AppColors.darkText),
            ),
          ),
          Icon(Iconsax.close_circle, color: AppColors.greyText, size: 18),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}

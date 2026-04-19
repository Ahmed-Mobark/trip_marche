import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/config/app_images.dart';
import 'package:trip_marche/features/profile/presentation/widgets/my_reviews_empty_state.dart';
import 'package:trip_marche/features/profile/presentation/widgets/my_reviews_list.dart';

class MyReviewsView extends StatelessWidget {
  const MyReviewsView({super.key});

  // Sample review data
  static final List<Map<String, dynamic>> _reviews = [
    {
      'tripImage': AppImages.tripPlaceholder,
      'tripName': 'Sharm El Sheikh Adventure',
      'date': 'Mar 15, 2026',
      'rating': 4.5,
      'review':
          'Amazing trip! The underwater diving experience was breathtaking. Highly recommend this trip for anyone looking for adventure.',
    },
    {
      'tripImage': AppImages.tripPlaceholder,
      'tripName': 'Luxor Historical Tour',
      'date': 'Feb 20, 2026',
      'rating': 5.0,
      'review':
          'One of the best cultural experiences I have ever had. The guide was very knowledgeable and friendly.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Reviews',
          style: AppTextStyles.subtitle(),
        ),
        centerTitle: true,
      ),
      body: _reviews.isEmpty
          ? const MyReviewsEmptyState()
          : MyReviewsList(reviews: _reviews),
    );
  }
}

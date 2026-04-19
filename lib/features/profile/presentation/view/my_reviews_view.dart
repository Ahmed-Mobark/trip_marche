import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/profile/presentation/widgets/review_card.dart';

class MyReviewsView extends StatelessWidget {
  const MyReviewsView({super.key});

  // Sample review data
  static final List<Map<String, dynamic>> _reviews = [
    {
      'tripImage': 'assets/images/trip_placeholder.png',
      'tripName': 'Sharm El Sheikh Adventure',
      'date': 'Mar 15, 2026',
      'rating': 4.5,
      'review':
          'Amazing trip! The underwater diving experience was breathtaking. Highly recommend this trip for anyone looking for adventure.',
    },
    {
      'tripImage': 'assets/images/trip_placeholder.png',
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
      body: _reviews.isEmpty ? _buildEmptyState() : _buildReviewsList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.star,
            size: 64,
            color: AppColors.greyText.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'No reviews yet',
            style: AppTextStyles.subtitle(color: AppColors.greyText),
          ),
          const SizedBox(height: 8),
          Text(
            'Your reviews will appear here after\nyou review a trip.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.greyText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsList() {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: _reviews.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final review = _reviews[index];
        return ReviewCard(
          tripImage: review['tripImage'] as String,
          tripName: review['tripName'] as String,
          date: review['date'] as String,
          rating: review['rating'] as double,
          review: review['review'] as String,
        );
      },
    );
  }
}

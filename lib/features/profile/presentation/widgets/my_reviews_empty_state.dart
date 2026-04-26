import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class MyReviewsEmptyState extends StatelessWidget {
  const MyReviewsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
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
}


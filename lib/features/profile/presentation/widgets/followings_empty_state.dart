import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';

class FollowingsEmptyState extends StatelessWidget {
  const FollowingsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.building,
            size: 64,
            color: AppColors.greyText.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.followingsEmptyTitle,
            style: AppTextStyles.subtitle(color: AppColors.greyText),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr.followingsEmptyDescription,
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


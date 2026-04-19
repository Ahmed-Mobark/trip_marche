import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

class ItineraryDay extends StatelessWidget {
  final String title;
  final String description;
  final bool isExpanded;
  final VoidCallback onTap;

  const ItineraryDay({
    super.key,
    required this.title,
    required this.description,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isExpanded
              ? AppColors.primary.withValues(alpha: 0.05)
              : AppColors.lightBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isExpanded
                ? AppColors.primary.withValues(alpha: 0.3)
                : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium(
                    color: isExpanded ? AppColors.primary : AppColors.darkText,
                  ),
                ),
                Icon(
                  isExpanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
                  size: 18,
                  color: isExpanded ? AppColors.primary : AppColors.greyText,
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 8),
              Text(
                description,
                style: AppTextStyles.body(color: AppColors.secondaryText),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

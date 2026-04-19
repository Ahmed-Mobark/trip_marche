import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

class RecentSearchChip extends StatelessWidget {
  final String searchTerm;
  final VoidCallback? onTap;

  const RecentSearchChip({
    super.key,
    required this.searchTerm,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.lightBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Iconsax.clock, size: 14, color: AppColors.greyText),
            const SizedBox(width: 6),
            Text(
              searchTerm,
              style: AppTextStyles.bodySmall(color: AppColors.secondaryText),
            ),
          ],
        ),
      ),
    );
  }
}

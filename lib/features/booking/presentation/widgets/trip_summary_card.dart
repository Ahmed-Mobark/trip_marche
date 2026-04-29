import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class TripSummaryCard extends StatelessWidget {
  const TripSummaryCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.trailing,
    this.ratingRow,
  });

  final String title;
  final String subtitle;
  final String? imageUrl;
  final Widget? trailing;
  final Widget? ratingRow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.lightBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: imageUrl != null
                ? Image.network(
                    imageUrl!,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 70,
                    height: 70,
                    color: AppColors.border,
                    child: Icon(Iconsax.image, color: AppColors.greyText),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMedium(color: AppColors.darkText)),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTextStyles.bodySmall()),
                if (trailing != null) ...[
                  const SizedBox(height: 4),
                  trailing!,
                ],
                if (ratingRow != null) ...[
                  const SizedBox(height: 4),
                  ratingRow!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

class TripDetailItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const TripDetailItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.lightBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(height: 6),
          Text(value, style: AppTextStyles.bodyMedium(color: AppColors.darkText)),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.caption(color: AppColors.greyText)),
        ],
      ),
    );
  }
}

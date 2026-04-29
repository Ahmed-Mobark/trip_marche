import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class LocationTopBar extends StatelessWidget {
  final String locationName;
  final VoidCallback? onLocationTap;
  final VoidCallback? onNotificationTap;

  const LocationTopBar({
    super.key,
    required this.locationName,
    this.onLocationTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: onLocationTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Iconsax.location, color: AppColors.primary, size: 20),
                const SizedBox(width: 6),
                Text(
                  locationName,
                  style: AppTextStyles.subtitle(),
                ),
                Icon(Iconsax.arrow_down_1,
                    size: 16, color: AppColors.secondaryText),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onNotificationTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.lightBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Iconsax.notification,
                  color: AppColors.secondaryText, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}

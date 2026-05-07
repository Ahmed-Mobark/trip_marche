import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';

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
            color: AppColors.greyText(context).withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.followingsEmptyTitle,
            style: AppTextStyles.subtitle(color: AppColors.greyText(context)),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr.followingsEmptyDescription,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.greyText(context),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class HomeSearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;

  const HomeSearchBar({
    super.key,
    this.hintText = 'Search destinations, trips...',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.inputBg(context),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const SizedBox(width: 14),
              Icon(Iconsax.search_normal, color: AppColors.greyText(context), size: 20),
              const SizedBox(width: 10),
              Text(
                hintText,
                style: AppTextStyles.bodyMedium(color: AppColors.greyText(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

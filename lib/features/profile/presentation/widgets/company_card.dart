import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CompanyCard extends StatelessWidget {
  final String name;
  final String logo;
  final int tripCount;
  final bool isFollowing;
  final VoidCallback? onTap;
  final VoidCallback? onFollowTap;

  const CompanyCard({
    super.key,
    required this.name,
    required this.logo,
    required this.tripCount,
    required this.isFollowing,
    this.onTap,
    this.onFollowTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border(context)),
        ),
        child: Row(
          children: [
            // Company Logo
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                logo,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.lightBg(context),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Iconsax.building,
                    color: AppColors.greyText(context),
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Company Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.subtitle(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$tripCount Trips',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyText(context),
                    ),
                  ),
                ],
              ),
            ),
            // Follow/Following Button
            GestureDetector(
              onTap: onFollowTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isFollowing
                      ? AppColors.primary
                      : AppColors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isFollowing ? AppColors.primary : AppColors.border(context),
                  ),
                ),
                child: Text(
                  isFollowing ? 'Following' : 'Follow',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isFollowing ? AppColors.onImage : AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

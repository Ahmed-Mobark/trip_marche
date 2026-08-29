import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import 'company_follow_button.dart';

class CompanyProfileHeader extends StatelessWidget {
  const CompanyProfileHeader({
    super.key,
    required this.companyName,
    required this.avatarUrl,
    required this.rating,
    required this.reviewsCount,
    required this.isFollowing,
    required this.onFollowToggle,
    this.followersCount,
    this.tripsCount,
    this.isVerified,
    this.showFollowButton = true,
  });

  final String companyName;
  final String avatarUrl;
  final double rating;
  final int reviewsCount;
  final bool isFollowing;
  final VoidCallback onFollowToggle;
  final int? followersCount;
  final int? tripsCount;
  final bool? isVerified;
  final bool showFollowButton;

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.darkText(context);
    final greyColor = AppColors.greyText(context);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: CompanyProfileFigmaTokens.screenPadding,
      ),
      padding: EdgeInsets.only(top: CompanyProfileFigmaTokens.cardPadding * 4),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              CompanyProfileFigmaTokens.cardRadiusLarge,
            ),
            child: Container(
              width: CompanyProfileFigmaTokens.headerAvatarWidth,
              height: CompanyProfileFigmaTokens.headerAvatarHeight,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.surfaceDivider(context)),
              ),
              child: AppCachedNetworkImage(
                imageUrl: avatarUrl,
                width: CompanyProfileFigmaTokens.headerAvatarWidth,
                height: CompanyProfileFigmaTokens.headerAvatarHeight,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: CompanyProfileFigmaTokens.rowGapLarge),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        companyName,
                        style: AppTextStyles.navTitle(color: textColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isVerified == true) ...[
                      SizedBox(width: CompanyProfileFigmaTokens.rowGapMedium),
                      Container(
                        width: CompanyProfileFigmaTokens.verifiedBadgeSize,
                        height: CompanyProfileFigmaTokens.verifiedBadgeSize,
                        decoration: const BoxDecoration(
                          color: AppColors.verifiedBlue,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          size: CompanyProfileFigmaTokens.smallIconSize,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: CompanyProfileFigmaTokens.rowGapSmall),
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: rating,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star_rounded,
                        color: AppColors.starYellow,
                      ),
                      itemCount: 5,
                      itemSize: CompanyProfileFigmaTokens.starIconSize,
                      direction: Axis.horizontal,
                      unratedColor: greyColor.withValues(alpha: 0.4),
                    ),
                    SizedBox(width: CompanyProfileFigmaTokens.rowGapSmall),
                    Text(
                      rating.toStringAsFixed(1),
                      style: AppTextStyles.caption(
                        color: AppColors.ratingValue(context),
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: CompanyProfileFigmaTokens.rowGapSmall),
                    Text(
                      '($reviewsCount)',
                      style: AppTextStyles.caption(color: greyColor),
                    ),
                  ],
                ),
                if (showFollowButton) ...[
                  SizedBox(height: CompanyProfileFigmaTokens.rowGapSmall),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: CompanyFollowButton(
                      isFollowing: isFollowing,
                      onPressed: onFollowToggle,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

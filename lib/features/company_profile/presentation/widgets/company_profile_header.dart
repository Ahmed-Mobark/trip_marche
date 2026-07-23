import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';
import '../../../../core/widgets/app_cached_network_image.dart';

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

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.darkText(context);
    final borderColor = AppColors.border(context);
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
          SizedBox(width: CompanyProfileFigmaTokens.rowGapMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(width: CompanyProfileFigmaTokens.rowGapSmall),
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
                    Icon(
                      Icons.star_rounded,
                      size: CompanyProfileFigmaTokens.starIconSize,
                      color: AppColors.starYellow,
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
                    if (followersCount != null) ...[
                      SizedBox(width: CompanyProfileFigmaTokens.rowGapMedium),
                      Container(
                        width: 3.r,
                        height: 3.r,
                        decoration: BoxDecoration(
                          color: AppColors.greyText(context),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: CompanyProfileFigmaTokens.rowGapMedium),
                      Text(
                        '$followersCount',
                        style: AppTextStyles.caption(color: greyColor),
                      ),
                    ],
                    if (tripsCount != null) ...[
                      SizedBox(width: CompanyProfileFigmaTokens.rowGapMedium),
                      Container(
                        width: 3.r,
                        height: 3.r,
                        decoration: BoxDecoration(
                          color: AppColors.greyText(context),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: CompanyProfileFigmaTokens.rowGapMedium),
                      Text(
                        '$tripsCount',
                        style: AppTextStyles.caption(color: greyColor),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: CompanyProfileFigmaTokens.rowGapMedium),
          SizedBox(
            width: CompanyProfileFigmaTokens.followButtonWidth,
            height: CompanyProfileFigmaTokens.followButtonHeight,
            child: TextButton(
              onPressed: onFollowToggle,
              style: TextButton.styleFrom(
                backgroundColor: isFollowing
                    ? AppColors.primary
                    : AppColors.transparent,
                side: BorderSide(
                  color: isFollowing ? AppColors.primary : borderColor,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    CompanyProfileFigmaTokens.cardRadius,
                  ),
                ),
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                isFollowing
                    ? context.tr.companyProfileFollowing
                    : context.tr.companyProfileFollow,
                style: AppTextStyles.button(
                  color: isFollowing ? AppColors.white : AppColors.primary,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/app_images.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';
import '../models/trip_card_model.dart';

class CompanyTripCard extends StatelessWidget {
  const CompanyTripCard({
    super.key,
    required this.trip,
    this.onTap,
    this.onFavoriteTap,
  });

  final TripCardModel trip;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  Color _getBadgeColor(String? badgeType) {
    switch (badgeType) {
      case 'Top Rated':
        return AppColors.badgeAmber;
      case 'Recommended':
        return AppColors.searchResultRecommendedOrange;
      case 'Best Price':
        return AppColors.searchResultBestPriceGreen;
      case 'New in TripMarche':
        return AppColors.primary;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final badgeColor = _getBadgeColor(trip.badge);
    final showOldPrice = trip.oldPrice > 0 && trip.oldPrice != trip.newPrice;

    return GestureDetector(
      onTap: onTap ?? trip.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.background(context),
          borderRadius: BorderRadius.circular(CompanyProfileFigmaTokens.tripCardRadius),
          border: Border.all(color: AppColors.cardBorder(context)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: CompanyProfileFigmaTokens.tripCardImageWidth,
              child: AspectRatio(
                aspectRatio: CompanyProfileFigmaTokens.tripCardImageAspectRatio,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(CompanyProfileFigmaTokens.tripCardRadius),
                      child: Container(
                        color: AppColors.greyText(context),
                        child: trip.imageUrl.isNotEmpty
                            ? Image.network(
                          trip.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Image.asset(
                            AppImages.tripPlaceholder,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Image.asset(
                          AppImages.tripPlaceholder,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (trip.badge != null)
                      Positioned(
                        top: 12.h,
                        left: 12.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: badgeColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            trip.badge!,
                            style: AppTextStyles.smallMedium(
                              color: AppColors.white,
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.title,
                      style: AppTextStyles.cardTitle(color: AppColors.tripTitle(context)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: CompanyProfileFigmaTokens.rowGapSmall),
                    Row(
                      children: [
                        Icon(Iconsax.star1, size: CompanyProfileFigmaTokens.starIconSize, color: AppColors.starYellow),
                        SizedBox(width: CompanyProfileFigmaTokens.rowGapSmall),
                        Flexible(
                          child: Text(
                            trip.rating.toStringAsFixed(1),
                            style: AppTextStyles.caption(color: AppColors.ratingValue(context)).copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '(${trip.reviewsCount})',
                            style: AppTextStyles.caption(color: AppColors.ratingValue(context)).copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: CompanyProfileFigmaTokens.rowGapSmall),
                    Row(
                      children: [
                        Icon(Iconsax.location, size: CompanyProfileFigmaTokens.smallIconSize, color: AppColors.iconSlate(context)),
                        SizedBox(width: CompanyProfileFigmaTokens.rowGapSmall),
                        Expanded(
                          child: Text(
                            trip.fromCity,
                            style: AppTextStyles.caption(color: AppColors.metaSlate(context)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: CompanyProfileFigmaTokens.rowGapSmall),
                    Row(
                      children: [
                        Icon(Iconsax.calendar_1, size: CompanyProfileFigmaTokens.smallIconSize, color: AppColors.iconSlate(context)),
                        SizedBox(width: CompanyProfileFigmaTokens.rowGapSmall),
                        Flexible(
                          child: Text(
                            trip.dateFrom,
                            style: AppTextStyles.caption(color: AppColors.metaSlate(context)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: CompanyProfileFigmaTokens.rowGapSmall),
                        Icon(Iconsax.arrow_right_3, size: CompanyProfileFigmaTokens.smallIconSize, color: AppColors.iconSlate(context)),
                        SizedBox(width: CompanyProfileFigmaTokens.rowGapSmall),
                        Flexible(
                          child: Text(
                            trip.dateTo,
                            style: AppTextStyles.caption(color: AppColors.metaSlate(context)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (trip.badge != null) ...[
                      SizedBox(height: CompanyProfileFigmaTokens.rowGapSmall),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          trip.badge!,
                          style: AppTextStyles.smallMedium(color: AppColors.white).copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                    SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
                    Row(
                      children: [
                        if (showOldPrice)
                          Flexible(
                            child: Text(
                              '${trip.currency}${trip.oldPrice}',
                              style: AppTextStyles.bodyMedium(color: AppColors.strikethroughGrey(context)).copyWith(
                                decoration: TextDecoration.lineThrough,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        if (showOldPrice) SizedBox(width: CompanyProfileFigmaTokens.rowGapSmall),
                        Flexible(
                          child: Text(
                            '${trip.currency}${trip.newPrice}',
                            style: AppTextStyles.cardTitle(color: AppColors.tripTitle(context)).copyWith(fontWeight: FontWeight.w700),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: CompanyProfileFigmaTokens.rowGapSmall),
                        Flexible(
                          child: Text(
                            '/${context.tr.companyProfilePricePerPerson}',
                            style: AppTextStyles.caption(color: AppColors.tripTitle(context)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: GestureDetector(
                onTap: trip.onFavoriteTap ?? onFavoriteTap,
                child: Container(
                  width: CompanyProfileFigmaTokens.favoriteButtonSize,
                  height: CompanyProfileFigmaTokens.favoriteButtonSize,
                  decoration: BoxDecoration(
                    color: AppColors.favoriteBg(context),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    trip.isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: CompanyProfileFigmaTokens.largeIconSize,
                    color: AppColors.favoritePink,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}

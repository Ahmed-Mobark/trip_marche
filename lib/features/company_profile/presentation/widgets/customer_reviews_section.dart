import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/app_images.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';

class ReviewImageItem extends StatelessWidget {
  const ReviewImageItem({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(CompanyProfileFigmaTokens.cardRadius),
      child: Container(
        width: 58.w,
        height: 56.h,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.socialBorder),
        ),
        child: Image.network(
          imageUrl,
          width: 58.w,
          height: 56.h,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            width: 58.w,
            height: 56.h,
            color: AppColors.inputBg(context),
          ),
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.review,
  });

  final ReviewData review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CompanyProfileFigmaTokens.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(CompanyProfileFigmaTokens.cardRadius),
        border: Border.all(color: AppColors.surfaceDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(CompanyProfileFigmaTokens.reviewAvatarSize),
                child: Container(
                  width: CompanyProfileFigmaTokens.reviewAvatarSize,
                  height: CompanyProfileFigmaTokens.reviewAvatarSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surfaceDivider),
                  ),
                  child: review.avatarUrl.isNotEmpty
                      ? Image.network(
                          review.avatarUrl,
                          width: CompanyProfileFigmaTokens.reviewAvatarSize,
                          height: CompanyProfileFigmaTokens.reviewAvatarSize,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Image.asset(
                            AppImages.logo,
                            width: CompanyProfileFigmaTokens.reviewAvatarSize,
                            height: CompanyProfileFigmaTokens.reviewAvatarSize,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          AppImages.logo,
                          width: CompanyProfileFigmaTokens.reviewAvatarSize,
                          height: CompanyProfileFigmaTokens.reviewAvatarSize,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(width: CompanyProfileFigmaTokens.rowGapMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: AppTextStyles.bodySmall(color: AppColors.darkText(context)).copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: CompanyProfileFigmaTokens.rowGapSmall),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3.5.r),
                          child: review.countryFlagUrl.isNotEmpty
                              ? Image.network(
                                  review.countryFlagUrl,
                                  width: 18.w,
                                  height: 14.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 18.w,
                                    height: 14.h,
                                    color: AppColors.greyText(context),
                                  ),
                                )
                              : Container(
                                  width: 18.w,
                                  height: 14.h,
                                  color: AppColors.greyText(context),
                                ),
                        ),
                        SizedBox(width: CompanyProfileFigmaTokens.rowGapSmall),
                        Text(
                          review.country,
                          style: AppTextStyles.caption(color: AppColors.countryText),
                        ),
                      ],
                    ),
                    SizedBox(height: CompanyProfileFigmaTokens.rowGapSmall),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < review.rating.floor()
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          size: CompanyProfileFigmaTokens.starIconSize,
                          color: AppColors.starYellow,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
          Text(
            review.comment,
            style: AppTextStyles.bodySmall(color: AppColors.commentGrey).copyWith(height: 1.4),
          ),
          if (review.galleryImages.isNotEmpty) ...[
            SizedBox(height: CompanyProfileFigmaTokens.rowGapLarge),
            SizedBox(
              height: 56.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: review.galleryImages.length,
                separatorBuilder: (_, __) => SizedBox(width: CompanyProfileFigmaTokens.rowGapMedium),
                itemBuilder: (context, index) {
                  return ReviewImageItem(imageUrl: review.galleryImages[index]);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class CustomerReviewsSection extends StatelessWidget {
  const CustomerReviewsSection({super.key, required this.reviews});

  final List<ReviewData> reviews;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: CompanyProfileFigmaTokens.screenPadding),
      decoration: BoxDecoration(
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(CompanyProfileFigmaTokens.cardRadius),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(CompanyProfileFigmaTokens.screenPaddingSmall, CompanyProfileFigmaTokens.cardPadding, CompanyProfileFigmaTokens.screenPaddingSmall, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.tr.companyProfileCustomerReviews,
                  style: AppTextStyles.heading3(
                    color: AppColors.darkText(context),
                  ).copyWith(fontSize: CompanyProfileFigmaTokens.titleFontSize, fontWeight: FontWeight.w700),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    context.tr.companyProfileViewAll,
                    style: AppTextStyles.bodyMedium(
                      color: AppColors.primary,
                    ).copyWith(fontSize: CompanyProfileFigmaTokens.bodyMediumFontSize, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: CompanyProfileFigmaTokens.screenPaddingSmall),
            itemCount: reviews.length,
            separatorBuilder: (_, __) => SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
            itemBuilder: (context, index) {
              final review = reviews[index];
              return ReviewCard(review: review);
            },
          ),
          SizedBox(height: CompanyProfileFigmaTokens.cardPadding),
        ],
      ),
    );
  }
}

class ReviewData {
  const ReviewData({
    required this.name,
    required this.avatarUrl,
    required this.country,
    required this.countryFlagUrl,
    required this.rating,
    required this.comment,
    required this.galleryImages,
  });

  final String name;
  final String avatarUrl;
  final String country;
  final String countryFlagUrl;
  final double rating;
  final String comment;
  final List<String> galleryImages;
}

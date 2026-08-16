import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import '../models/review_model.dart';
import 'profile_avatar.dart';
import 'profile_section_title.dart';

class ReviewImageItem extends StatelessWidget {
  const ReviewImageItem({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(CompanyProfileFigmaTokens.cardRadius),
      child: Container(
        width: 58.w,
        height: 56.h,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.socialBorder(context)),
        ),
        child: AppCachedNetworkImage(
          imageUrl: imageUrl,
          width: 58.w,
          height: 56.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CompanyProfileFigmaTokens.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(
          CompanyProfileFigmaTokens.cardRadius,
        ),
        border: Border.all(color: AppColors.surfaceDivider(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileAvatar(
                imageUrl: review.avatarUrl,
                size: CompanyProfileFigmaTokens.reviewAvatarSize,
                borderRadius: CompanyProfileFigmaTokens.reviewAvatarSize,
              ),
              SizedBox(width: CompanyProfileFigmaTokens.rowGapMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: AppTextStyles.bodySmall(
                        color: AppColors.darkText(context),
                      ).copyWith(fontWeight: FontWeight.w700),
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
                          style: AppTextStyles.caption(
                            color: AppColors.countryText(context),
                          ),
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
            style: AppTextStyles.bodySmall(
              color: AppColors.commentGrey(context),
            ).copyWith(height: 1.4),
          ),
          if (review.galleryImages.isNotEmpty) ...[
            SizedBox(height: CompanyProfileFigmaTokens.rowGapLarge),
            SizedBox(
              height: 56.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: review.galleryImages.length,
                separatorBuilder: (_, __) =>
                    SizedBox(width: CompanyProfileFigmaTokens.rowGapMedium),
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

class CustomerReviewsSection extends StatefulWidget {
  const CustomerReviewsSection({
    super.key,
    required this.reviews,
    this.onViewAll,
  });

  final List<ReviewModel> reviews;
  final VoidCallback? onViewAll;

  @override
  State<CustomerReviewsSection> createState() => _CustomerReviewsSectionState();
}

class _CustomerReviewsSectionState extends State<CustomerReviewsSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final reviews = widget.reviews;
    if (reviews.isEmpty) {
      return const SizedBox.shrink();
    }

    final visibleReviews = _isExpanded ? reviews : reviews.take(3).toList();
    final toggleText = reviews.length > 3
        ? (_isExpanded
            ? context.tr.companyProfileShowLess
            : context.tr.companyProfileViewAll)
        : null;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: CompanyProfileFigmaTokens.screenPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileSectionTitle(
            title: context.tr.companyProfileCustomerReviews,
            actionText: toggleText,
            onActionTap: toggleText != null
                ? () => setState(() => _isExpanded = !_isExpanded)
                : null,
          ),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: visibleReviews
                  .map((review) => ReviewCard(review: review))
                  .toList(),
            ),
          ),
          SizedBox(height: CompanyProfileFigmaTokens.cardPadding),
        ],
      ),
    );
  }
}

import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/widgets/app_cached_network_image.dart';

class MyReviewsView extends StatelessWidget {
  const MyReviewsView({super.key});

  static const _heroImageUrl =
      'https://images.unsplash.com/photo-1528127269322-539801943592?w=900';
  static const _cardImageUrl =
      'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=900';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.darkText,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          context.tr.profileMyReviews,
          style: AppTextStyles.subtitle(color: AppColors.darkText),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(
          start: 18.w,
          end: 18.w,
          top: 12.h,
          bottom: 24.h,
        ),
        child: Column(
          children: [
            _HeroTripCard(
              imageUrl: _heroImageUrl,
              title: context.tr.tripDetailsTitle,
              ratingValue: '4.9',
              ratingCount: '112',
              fromText: context.tr.tripDetailsHeroFromLocation,
              dateRangeText: context.tr.tripDetailsHeroDateRange,
              addReviewText: context.tr.profileAddReview,
              onAddReview: () {},
            ),
            SizedBox(height: 14.h),
            _ReviewTripCard(
              imageUrl: _cardImageUrl,
              title: context.tr.tripDetailsTitle,
              routeText: context.tr.profileMyReviewsRoute,
              dateRangeText: context.tr.tripDetailsHeroDateRange,
              ratingValue: '4.9',
              ratingCount: '112',
              reviewLabel: context.tr.profileReviewLabel,
              productRatingLabel: context.tr.profileProductRatingLabel,
              reviewBody:
                  '“This trip was absolutely amazing! Everything was well-organized, the guide was super friendly, and the locations we visited were breathtaking. Highly recommended!”',
            ),
            SizedBox(height: 14.h),
            _ReviewTripCard(
              imageUrl: _cardImageUrl,
              title: context.tr.tripDetailsTitle,
              routeText: context.tr.profileMyReviewsRoute,
              dateRangeText: context.tr.tripDetailsHeroDateRange,
              ratingValue: '4.9',
              ratingCount: '112',
              reviewLabel: context.tr.profileReviewLabel,
              productRatingLabel: context.tr.profileProductRatingLabel,
              reviewBody:
                  '“This trip was absolutely amazing! Everything was well-organized, the guide was super friendly, and the locations we visited were breathtaking. Highly recommended!”',
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroTripCard extends StatelessWidget {
  const _HeroTripCard({
    required this.imageUrl,
    required this.title,
    required this.ratingValue,
    required this.ratingCount,
    required this.fromText,
    required this.dateRangeText,
    required this.addReviewText,
    required this.onAddReview,
  });

  final String imageUrl;
  final String title;
  final String ratingValue;
  final String ratingCount;
  final String fromText;
  final String dateRangeText;
  final String addReviewText;
  final VoidCallback onAddReview;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageWidth =
            math.min(150.w, math.max(120.w, constraints.maxWidth * 0.44));
        final imageHeight = math.max(150.h, imageWidth * 1.05);

        return Container(
          padding: EdgeInsetsDirectional.all(14.r),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18.r),
                child: AppCachedNetworkImage(
                  imageUrl: imageUrl,
                  width: imageWidth,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium(color: AppColors.darkText)
                          .copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Iconsax.star1,
                          size: 14.sp,
                          color: AppColors.starYellow,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          ratingValue,
                          style: AppTextStyles.bodySmall(color: AppColors.darkText)
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(width: 2.w),
                        Flexible(
                          child: Text(
                            '($ratingCount)',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                AppTextStyles.bodySmall(color: AppColors.greyText),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    _InfoLine(icon: Iconsax.location, text: fromText),
                    SizedBox(height: 8.h),
                    _InfoLine(icon: Iconsax.calendar_1, text: dateRangeText),
                    SizedBox(height: 14.h),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.centerStart,
                      child: OutlinedButton.icon(
                        onPressed: onAddReview,
                        icon: Icon(
                          Iconsax.star1,
                          size: 16.sp,
                          color: AppColors.primary,
                        ),
                        label: Text(
                          addReviewText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyMedium(color: AppColors.primary)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primary),
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ReviewTripCard extends StatelessWidget {
  const _ReviewTripCard({
    required this.imageUrl,
    required this.title,
    required this.routeText,
    required this.dateRangeText,
    required this.ratingValue,
    required this.ratingCount,
    required this.reviewLabel,
    required this.productRatingLabel,
    required this.reviewBody,
  });

  final String imageUrl;
  final String title;
  final String routeText;
  final String dateRangeText;
  final String ratingValue;
  final String ratingCount;
  final String reviewLabel;
  final String productRatingLabel;
  final String reviewBody;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final thumb =
            math.min(78.w, math.max(64.w, constraints.maxWidth * 0.24));

        return Container(
          padding: EdgeInsetsDirectional.all(14.r),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: AppCachedNetworkImage(
                      imageUrl: imageUrl,
                      width: thumb,
                      height: thumb,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyMedium(color: AppColors.darkText)
                              .copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        _InfoLine(icon: Iconsax.location, text: routeText),
                        SizedBox(height: 6.h),
                        _InfoLine(icon: Iconsax.calendar_1, text: dateRangeText),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Text(
                reviewLabel,
                style: AppTextStyles.bodySmall(color: AppColors.darkText)
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      productRatingLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption(color: AppColors.greyText),
                    ),
                  ),
                  Icon(Iconsax.star1, size: 14.sp, color: AppColors.starYellow),
                  SizedBox(width: 6.w),
                  Text(
                    ratingValue,
                    style: AppTextStyles.bodySmall(color: AppColors.darkText)
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 2.w),
                  Flexible(
                    child: Text(
                      '($ratingCount)',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmall(color: AppColors.greyText),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                reviewBody,
                style: AppTextStyles.bodySmall(color: AppColors.secondaryText),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: AppColors.greyText),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall(color: AppColors.greyText),
          ),
        ),
      ],
    );
  }
}

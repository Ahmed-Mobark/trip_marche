import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/extensions/localization.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/methods/covert_datetime_to_string.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../cubit/reviews_cubit.dart';
import '../cubit/reviews_state.dart';
import '../widgets/my_reviews_empty_state.dart';
import 'add_vendor_review_view.dart';

class MyReviewsRoute extends MaterialPageRoute<void> {
  MyReviewsRoute() : super(builder: (context) => const MyReviewsView());
}

class MyReviewsView extends StatelessWidget {
  const MyReviewsView({super.key});

  String _formatDate(String dateStr) {
    if (dateStr.isEmpty) return '';
    try {
      final parsed = DateTime.parse(dateStr);
      return ConvertDateTime.convertDateTimeToDate(date: parsed);
    } catch (_) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ReviewsCubit>()..fetchReviews(),
      child: Scaffold(
        backgroundColor: AppColors.background(context),
        appBar: AppBar(
          backgroundColor: AppColors.background(context),
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.darkText(context),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            context.tr.profileMyReviews,
            style: AppTextStyles.subtitle(color: AppColors.darkText(context)),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<ReviewsCubit, ReviewsState>(
          builder: (context, state) {
            final isLoading = state.status == ReviewsStatus.loading;
            final isError = state.status == ReviewsStatus.failure;
            final reviews = state.reviews;

            if (isLoading && reviews.isEmpty) {
              return const Center(
                child: CustomLoading(size: 36, strokeWidth: 2.5),
              );
            }

            if (isError && reviews.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 60.h,
                    horizontal: 20.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48.r,
                        color: AppColors.greyText(context),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        state.errorMessage ?? 'Something went wrong',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium(
                          color: AppColors.greyText(context),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<ReviewsCubit>().fetchReviews(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Retry',
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.onPrimary(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final heroReview = reviews.isNotEmpty ? reviews.first : null;

            return RefreshIndicator(
              onRefresh: () => context.read<ReviewsCubit>().fetchReviews(),
              color: AppColors.primary,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsetsDirectional.only(
                  start: 18.w,
                  end: 18.w,
                  top: 12.h,
                  bottom: 24.h,
                ),
                child: Column(
                  children: [
                    _HeroTripCard(
                      imageUrl: heroReview != null
                          ? (heroReview.type == 'trip'
                              ? heroReview.trip?.coverImage ?? ''
                              : heroReview.vendor?.avatar ?? '')
                          : '',
                      title: heroReview != null
                          ? (heroReview.type == 'trip'
                              ? heroReview.trip?.title ?? ''
                              : heroReview.vendor?.name ?? '')
                          : '',
                      ratingValue: heroReview != null
                          ? heroReview.rating.toStringAsFixed(1)
                          : '',
                      ratingCount: heroReview != null
                          ? heroReview.rating.toStringAsFixed(0)
                          : '',
                      fromText: heroReview != null
                          ? (heroReview.type == 'trip'
                              ? 'Trip Review'
                              : 'Vendor Review')
                          : '',
                      dateRangeText: heroReview != null
                          ? _formatDate(heroReview.createdAt)
                          : '',
                      addReviewText: context.tr.profileAddReview,
                      onAddReview: () async {
                        if (heroReview == null) return;
                        final result = await Navigator.push<bool>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddVendorReviewView(
                              tripId: heroReview.type == 'trip'
                                  ? heroReview.trip?.id
                                  : null,
                              vendorId: heroReview.type == 'trip'
                                  ? heroReview.trip?.vendorId
                                  : heroReview.vendor?.id,
                              review: heroReview,
                            ),
                          ),
                        );
                        if (result == true && context.mounted) {
                          context.read<ReviewsCubit>().fetchReviews();
                        }
                      },
                    ),
                    SizedBox(height: 14.h),
                    if (reviews.isEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: const MyReviewsEmptyState(),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: reviews.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 14.h),
                        itemBuilder: (context, index) {
                          final review = reviews[index];
                          final imageUrl = review.type == 'trip'
                              ? review.trip?.coverImage ?? ''
                              : review.vendor?.avatar ?? '';
                          final title = review.type == 'trip'
                              ? review.trip?.title ?? ''
                              : review.vendor?.name ?? '';
                          final dateText = _formatDate(review.createdAt);

                          return _ReviewTripCard(
                            imageUrl: imageUrl,
                            title: title,
                            routeText: review.type == 'trip'
                                ? 'Trip Review'
                                : 'Vendor Review',
                            dateRangeText: dateText,
                            ratingValue: review.rating.toStringAsFixed(1),
                            ratingCount: null,
                            reviewLabel: context.tr.profileReviewLabel,
                            productRatingLabel:
                                context.tr.profileProductRatingLabel,
                            reviewBody: review.comment,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddVendorReviewView(
                                    tripId: review.type == 'trip'
                                        ? review.trip?.id
                                        : null,
                                    vendorId: review.type == 'trip'
                                        ? review.trip?.vendorId
                                        : review.vendor?.id,
                                    review: review,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                  ],
                ),
              ),
            );
          },
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
  final String? ratingCount;
  final String fromText;
  final String dateRangeText;
  final String addReviewText;
  final VoidCallback onAddReview;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageWidth = math.min(
          150.w,
          math.max(120.w, constraints.maxWidth * 0.44),
        );
        final imageHeight = math.max(150.h, imageWidth * 1.05);

        return Container(
          padding: EdgeInsetsDirectional.all(14.r),
          decoration: BoxDecoration(
            color: AppColors.cardBg(context),
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
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.darkText(context),
                      ).copyWith(fontWeight: FontWeight.w800, fontSize: 16.sp),
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
                          style: AppTextStyles.bodySmall(
                            color: AppColors.darkText(context),
                          ).copyWith(fontWeight: FontWeight.w700),
                        ),
                        if (ratingCount != null && ratingCount!.isNotEmpty) ...[
                          SizedBox(width: 2.w),
                          Flexible(
                            child: Text(
                              '($ratingCount)',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodySmall(
                                color: AppColors.greyText(context),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (fromText.isNotEmpty) ...[
                      SizedBox(height: 10.h),
                      _InfoLine(icon: Iconsax.location, text: fromText),
                    ],
                    if (dateRangeText.isNotEmpty) ...[
                      if (fromText.isNotEmpty) SizedBox(height: 8.h)
                      else if (ratingValue.isNotEmpty) SizedBox(height: 10.h),
                      _InfoLine(icon: Iconsax.calendar_1, text: dateRangeText),
                    ],
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
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.primary,
                          ).copyWith(fontWeight: FontWeight.w600),
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
    required this.dateRangeText,
    required this.ratingValue,
    this.ratingCount,
    required this.reviewLabel,
    required this.productRatingLabel,
    required this.reviewBody,
    this.routeText,
    this.onTap,
  });

  final String imageUrl;
  final String title;
  final String? routeText;
  final String dateRangeText;
  final String ratingValue;
  final String? ratingCount;
  final String reviewLabel;
  final String productRatingLabel;
  final String reviewBody;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final thumb = math.min(
            78.w,
            math.max(64.w, constraints.maxWidth * 0.24),
          );

          return Container(
            padding: EdgeInsetsDirectional.all(14.r),
            decoration: BoxDecoration(
              color: AppColors.cardBg(context),
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: AppColors.border(context)),
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
                            style:
                                AppTextStyles.bodyMedium(
                                  color: AppColors.darkText(context),
                                ).copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16.sp,
                                ),
                          ),
                          SizedBox(height: 8.h),
                          if (routeText != null && routeText!.isNotEmpty)
                            _InfoLine(icon: Iconsax.location, text: routeText!),
                          if (routeText != null && routeText!.isNotEmpty)
                            SizedBox(height: 6.h),
                          _InfoLine(
                            icon: Iconsax.calendar_1,
                            text: dateRangeText,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                Text(
                  reviewLabel,
                  style: AppTextStyles.bodySmall(
                    color: AppColors.darkText(context),
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        productRatingLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.caption(
                          color: AppColors.greyText(context),
                        ),
                      ),
                    ),
                    Icon(Iconsax.star1, size: 14.sp, color: AppColors.starYellow),
                    SizedBox(width: 6.w),
                    Text(
                      ratingValue,
                      style: AppTextStyles.bodySmall(
                        color: AppColors.darkText(context),
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
                    if (ratingCount != null && ratingCount!.isNotEmpty) ...[
                      SizedBox(width: 2.w),
                      Flexible(
                        child: Text(
                          '($ratingCount)',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.greyText(context),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (reviewBody.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  Text(
                    reviewBody,
                    style: AppTextStyles.bodySmall(
                      color: AppColors.secondaryText(context),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
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
        Icon(icon, size: 14.sp, color: AppColors.greyText(context)),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall(color: AppColors.greyText(context)),
          ),
        ),
      ],
    );
  }
}

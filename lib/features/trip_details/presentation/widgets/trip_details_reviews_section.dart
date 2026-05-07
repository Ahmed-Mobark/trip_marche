import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_details_info_card.dart';

class TripDetailsReviewsSection extends StatelessWidget {
  const TripDetailsReviewsSection({super.key, required this.trip});

  final TripDetails trip;

  @override
  Widget build(BuildContext context) {
    if (trip.reviews.isEmpty) {
      return const SizedBox.shrink();
    }
    final firstReview = trip.reviews.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.tr.tripDetailsReviewsTitle,
                style: AppTextStyles.body(
                  color: AppColors.darkText(context),
                ).copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
            TextButton(
              onPressed: () => _openAllReviewsSheet(context, trip.reviews),
              style: TextButton.styleFrom(
                padding: EdgeInsetsDirectional.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                context.tr.tripDetailsViewAll,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.primary,
                ).copyWith(fontSize: 12.sp),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        TripDetailsReviewCard(review: firstReview),
      ],
    );
  }

  void _openAllReviewsSheet(BuildContext context, List<TripReview> reviews) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: AppColors.cardBg(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.w, 10.h, 16.w, 0),
            child: Column(
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.border(context),
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.tr.tripDetailsReviewsTitle,
                        style: AppTextStyles.heading3(color: AppColors.darkText(context))
                            .copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(ctx),
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        Icons.close_rounded,
                        size: 20.sp,
                        color: AppColors.darkText(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: ListView.separated(
                    itemCount: reviews.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    padding: EdgeInsetsDirectional.only(
                      bottom: 20.h + MediaQuery.paddingOf(ctx).bottom,
                    ),
                    itemBuilder: (_, i) =>
                        TripDetailsReviewCard(review: reviews[i]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TripDetailsReviewCard extends StatelessWidget {
  const TripDetailsReviewCard({super.key, required this.review});

  final TripReview review;

  @override
  Widget build(BuildContext context) {
    final stars = review.rating.clamp(0, 5).round();
    return TripDetailsInfoCard(
      withShadow: false,
      borderRadius: 16.r,
      borderColor: AppColors.border(context).withValues(alpha: 0.75),
      padding: EdgeInsetsDirectional.fromSTEB(14.w, 14.h, 14.w, 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: SizedBox(
                  width: 44.r,
                  height: 44.r,
                  child: AppCachedNetworkImage(
                    imageUrl: review.reviewer.avatar,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewer.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.heading3(
                        color: AppColors.darkText(context),
                      ).copyWith(fontSize: 15.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Text(
                          _countryFlag(review.reviewer.countryCode),
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            review.reviewer.country,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.body(
                              color: AppColors.greyText(context),
                            ).copyWith(fontSize: 12.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: List.generate(
                        5,
                        (i) => Padding(
                          padding: EdgeInsetsDirectional.only(end: 2.w),
                          child: Icon(
                            Iconsax.star1,
                            size: 14.sp,
                            color: i < stars
                                ? AppColors.starYellow
                                : AppColors.border(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            review.comment,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body(
              color: AppColors.greyText(context),
            ).copyWith(fontSize: 13.sp, height: 1.35),
          ),
          if (review.images.isNotEmpty) ...[
            SizedBox(height: 12.h),
            SizedBox(
              height: 56.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: review.images.length > 5 ? 5 : review.images.length,
                separatorBuilder: (_, __) => SizedBox(width: 8.w),
                itemBuilder: (_, i) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: SizedBox(
                      width: 72.w,
                      child: AppCachedNetworkImage(
                        imageUrl: review.images[i],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

String _countryFlag(String code) {
  final clean = code.trim().toUpperCase();
  if (clean.length != 2) {
    return '🏳️';
  }
  final first = clean.codeUnitAt(0) - 0x41 + 0x1F1E6;
  final second = clean.codeUnitAt(1) - 0x41 + 0x1F1E6;
  return String.fromCharCode(first) + String.fromCharCode(second);
}

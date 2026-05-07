import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

enum SearchTripCardBadgeType { newInTripMarche, recommended, bestPrice }

class SearchTripCardData {
  const SearchTripCardData({
    required this.imagePath,
    required this.title,
    required this.rating,
    required this.reviewsCount,
    required this.fromCity,
    required this.dateFrom,
    required this.dateTo,
    required this.oldPrice,
    required this.newPrice,
    required this.priceUnit,
    required this.badgeType,
    required this.badgeLabel,
    this.isFavorite = false,
  });

  final String imagePath;
  final String title;
  final String rating;
  final String reviewsCount;
  final String fromCity;
  final String dateFrom;
  final String dateTo;
  final String oldPrice;
  final String newPrice;
  final String priceUnit;
  final SearchTripCardBadgeType badgeType;
  final String badgeLabel;
  final bool isFavorite;
}

class SearchResultTripCard extends StatelessWidget {
  const SearchResultTripCard({required this.data, super.key});

  final SearchTripCardData data;

  @override
  Widget build(BuildContext context) {
    final badgeColor = switch (data.badgeType) {
      SearchTripCardBadgeType.recommended =>
        AppColors.searchResultRecommendedOrange,
      SearchTripCardBadgeType.bestPrice =>
        AppColors.searchResultBestPriceGreen,
      _ => AppColors.primary,
    };

    return Container(
      padding: EdgeInsetsDirectional.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.06),
            blurRadius: 10.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 132.h),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 112.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(data.imagePath, fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            data.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.heading3(
                              color: AppColors.searchResultCardInk,
                            ).copyWith(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          width: 38.r,
                          height: 38.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.myTripsFavoriteCircleFill,
                          ),
                          child: Icon(
                            data.isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            size: 20.sp,
                            color: AppColors.myTripsCardHeartPink,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 15.sp,
                          color: AppColors.starYellow,
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          data.rating,
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.searchResultCardInk,
                          ).copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '(${data.reviewsCount})',
                          style: AppTextStyles.body(
                            color: AppColors.searchResultMetaSlate,
                          ).copyWith(fontSize: 12.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    _CardMetaRow(
                      icon: Icons.location_on_outlined,
                      label: data.fromCity,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 14.sp,
                          color: AppColors.searchResultMetaSlate,
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          data.dateFrom,
                          style: AppTextStyles.caption(
                            color: AppColors.searchResultMetaSlate,
                          ).copyWith(fontSize: 12.sp),
                        ),
                        SizedBox(width: 6.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 14.sp,
                          color: AppColors.searchResultMetaSlate,
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            data.dateTo,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.caption(
                              color: AppColors.searchResultMetaSlate,
                            ).copyWith(fontSize: 12.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Text(
                        data.badgeLabel,
                        style: AppTextStyles.smallMedium(color: badgeColor)
                            .copyWith(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 2.h,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: [
                        Text(
                          data.oldPrice,
                          style: AppTextStyles.caption(
                            color: AppColors.searchResultMetaSlate,
                          ).copyWith(
                            fontSize: 12.sp,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          data.newPrice,
                          style: AppTextStyles.heading3(
                            color: AppColors.primary,
                          ).copyWith(fontSize: 20.sp, fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(bottom: 2.h),
                          child: Text(
                            data.priceUnit,
                            style: AppTextStyles.caption(
                              color: AppColors.searchResultMetaSlate,
                            ).copyWith(fontSize: 11.sp),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardMetaRow extends StatelessWidget {
  const _CardMetaRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: AppColors.searchResultMetaSlate),
        SizedBox(width: 3.w),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption(
              color: AppColors.searchResultMetaSlate,
            ).copyWith(fontSize: 12.sp),
          ),
        ),
      ],
    );
  }
}

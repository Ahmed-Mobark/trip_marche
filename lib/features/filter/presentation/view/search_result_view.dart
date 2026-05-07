import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_images.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/filter/presentation/widgets/search_result_sections.dart';
import 'package:trip_marche/features/filter/presentation/widgets/search_result_trip_card.dart';

class SearchResultView extends StatelessWidget {
  const SearchResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      SearchTripCardData(
        imagePath: AppImages.searchResultTrip1,
        title: context.tr.tripDetailsTitle,
        rating: context.tr.searchResultRating,
        reviewsCount: '112',
        fromCity: context.tr.searchResultFromCity,
        dateFrom: context.tr.searchResultDateFrom,
        dateTo: context.tr.searchResultDateTo,
        oldPrice: context.tr.searchResultOldPrice,
        newPrice: context.tr.searchResultDiscountPrice,
        priceUnit: context.tr.searchResultPerPerson,
        badgeType: SearchTripCardBadgeType.newInTripMarche,
        badgeLabel: context.tr.searchResultLabelNew,
        isFavorite: true,
      ),
      SearchTripCardData(
        imagePath: AppImages.searchResultTrip2,
        title: context.tr.tripDetailsTitle,
        rating: context.tr.searchResultRating,
        reviewsCount: '112',
        fromCity: context.tr.searchResultFromCity,
        dateFrom: context.tr.searchResultDateFrom,
        dateTo: context.tr.searchResultDateTo,
        oldPrice: context.tr.searchResultOldPrice,
        newPrice: context.tr.searchResultDiscountPrice,
        priceUnit: context.tr.searchResultPerPerson,
        badgeType: SearchTripCardBadgeType.recommended,
        badgeLabel: context.tr.searchResultLabelRecommended,
        isFavorite: true,
      ),
      SearchTripCardData(
        imagePath: AppImages.searchResultTrip3,
        title: context.tr.tripDetailsTitle,
        rating: context.tr.searchResultRating,
        reviewsCount: '112',
        fromCity: context.tr.searchResultFromCity,
        dateFrom: context.tr.searchResultDateFrom,
        dateTo: context.tr.searchResultDateTo,
        oldPrice: context.tr.searchResultOldPrice,
        newPrice: context.tr.searchResultDiscountPrice,
        priceUnit: context.tr.searchResultPerPerson,
        badgeType: SearchTripCardBadgeType.bestPrice,
        badgeLabel: context.tr.searchResultLabelBestPrice,
        isFavorite: true,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(gradient: AppColors.primaryGradient),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SearchResultHeader(),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      16.w,
                      16.h,
                      16.w,
                      0,
                    ),
                    child: Column(
                      children: [
                        const SearchResultSearchBar(),
                        SizedBox(height: 16.h),
                        const SearchResultActionRow(),
                        SizedBox(height: 14.h),
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsetsDirectional.only(
                              bottom:
                                  20.h + MediaQuery.paddingOf(context).bottom,
                            ),
                            itemCount: cards.length,
                            separatorBuilder: (_, __) => SizedBox(height: 12.h),
                            itemBuilder: (context, index) {
                              return SearchResultTripCard(data: cards[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

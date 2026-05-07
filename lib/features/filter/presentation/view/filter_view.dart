import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/filter/presentation/cubit/filter_cubit.dart';
import 'package:trip_marche/features/filter/presentation/cubit/filter_state.dart';
import 'package:trip_marche/features/filter/presentation/view/search_result_view.dart';
import 'package:trip_marche/features/filter/presentation/widgets/filter_view_sections.dart';

class FilterView extends StatelessWidget {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FilterCubit(),
      child: const _FilterBody(),
    );
  }
}

class _FilterBody extends StatelessWidget {
  const _FilterBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        final cubit = context.read<FilterCubit>();
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(112.h),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.w, 18.h, 12.w, 10.h),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.darkText,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    Text(
                      context.tr.wishlistFiltersTitle,
                      style: AppTextStyles.heading2(
                        color: AppColors.darkText,
                      ).copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: cubit.resetFilters,
                        style: TextButton.styleFrom(
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 8.w,
                            vertical: 8.h,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          context.tr.wishlistFiltersClearAll,
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.error,
                          ).copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsetsDirectional.fromSTEB(
              20.w,
              18.h,
              20.w,
              26.h + MediaQuery.paddingOf(context).bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterSection(
                  title: context.tr.wishlistFiltersDestination,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectField(value: context.tr.wishlistFiltersSelectCity),
                      SizedBox(height: 12.h),
                      Wrap(
                        spacing: 12.w,
                        children: [
                          SelectedDestinationChip(
                            label: context.tr.tripDetailsFlightLeg1FromCity,
                          ),
                          SelectedDestinationChip(
                            label: context.tr.tripDetailsDestinationParis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 28.h),
                FilterSection(
                  title: context.tr.wishlistFiltersPriceRange,
                  child: Column(
                    children: [
                      PriceHistogram(range: state.priceRange),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: AppColors.primary,
                          inactiveTrackColor: AppColors.border,
                          thumbColor: AppColors.primary,
                          overlayColor: AppColors.primary.withValues(
                            alpha: 0.12,
                          ),
                          trackHeight: 2.h,
                          rangeThumbShape: RoundRangeSliderThumbShape(
                            enabledThumbRadius: 6.r,
                          ),
                        ),
                        child: RangeSlider(
                          values: state.priceRange,
                          min: 0,
                          max: 10000,
                          divisions: 100,
                          labels: RangeLabels(
                            state.priceRange.start.round().toString(),
                            state.priceRange.end.round().toString(),
                          ),
                          onChanged: cubit.setPriceRange,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: PriceValueField(
                              label: context.tr.wishlistFiltersPriceRange,
                              value: '${state.priceRange.start.round()} EG',
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: PriceValueField(
                              label: context.tr.wishlistFiltersPriceRange,
                              value: '${state.priceRange.end.round()} EG',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 28.h),
                FilterSection(
                  title: context.tr.wishlistFiltersTripType,
                  child: ButtonRow(
                    options: [
                      context.tr.wishlistFiltersDomestic,
                      context.tr.wishlistFiltersInternational,
                    ],
                    isSelected: (value) =>
                        (value == context.tr.wishlistFiltersDomestic &&
                            state.tripType == 'domestic') ||
                        (value == context.tr.wishlistFiltersInternational &&
                            state.tripType == 'international'),
                    onTap: (value) => cubit.setTripType(
                      value == context.tr.wishlistFiltersDomestic
                          ? 'domestic'
                          : 'international',
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.wishlistFiltersDepartureCountry,
                  child: SelectField(
                    value: context.tr.wishlistFiltersSelectCountry,
                  ),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.wishlistFiltersDepartureCity,
                  child: SelectField(
                    value: context.tr.tripDetailsFlightLeg1FromCity,
                  ),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.wishlistFiltersTripMonth,
                  child: SelectField(
                    value: context.tr.wishlistFiltersSelectMonth,
                  ),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.tripDetailsAirlineLabel,
                  child: SelectField(value: context.tr.tripDetailsAirlineName),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.wishlistFiltersTravelAgency,
                  child: SelectField(
                    value: context.tr.wishlistFiltersAgencyNameHint,
                  ),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.wishlistFiltersAgencyRating,
                  child: NumberRow(
                    selected: state.agencyRating,
                    onTap: cubit.setAgencyRating,
                  ),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.wishlistFiltersOtherCountries,
                  child: SelectField(
                    value: context.tr.wishlistFiltersSelectCountries,
                  ),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.wishlistFiltersOtherCities,
                  child: SelectField(
                    value: context.tr.wishlistFiltersSelectCities,
                  ),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.wishlistFiltersNumberOfCities,
                  child: NumberRow(
                    selected: state.citiesCount,
                    onTap: cubit.setCitiesCount,
                  ),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.wishlistFiltersNumberOfCountries,
                  child: NumberRow(
                    selected: state.countriesCount,
                    onTap: cubit.setCountriesCount,
                  ),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.wishlistFiltersDuration,
                  child: ButtonRow(
                    options: const ['1-3 Days', 'Up to 5 Days', '5+ Days'],
                    labelBuilder: (value) {
                      if (value == '1-3 Days') {
                        return context.tr.wishlistFiltersDurationUpTo3;
                      }
                      if (value == 'Up to 5 Days') {
                        return context.tr.wishlistFiltersDurationUpTo7;
                      }
                      return context.tr.wishlistFiltersDuration7Plus;
                    },
                    isSelected: state.selectedDurations.contains,
                    onTap: cubit.toggleDuration,
                  ),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.wishlistFiltersGroupSize,
                  child: ButtonRow(
                    options: const ['5-10', 'Up to 25', '25+'],
                    labelBuilder: (value) {
                      if (value == '5-10') {
                        return context.tr.wishlistFiltersGroupSizeSmall;
                      }
                      if (value == 'Up to 25') {
                        return context.tr.wishlistFiltersGroupSizeUpTo20;
                      }
                      return context.tr.wishlistFiltersGroupSize20Plus;
                    },
                    isSelected: state.selectedGroupSizes.contains,
                    onTap: cubit.toggleGroupSize,
                  ),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.wishlistFiltersTripSeason,
                  child: ButtonRow(
                    options: [
                      context.tr.wishlistFiltersSeasonSpring,
                      context.tr.wishlistFiltersSeasonHajj,
                      context.tr.wishlistFiltersSeasonNewYear,
                    ],
                    isSelected: (value) =>
                        (value == context.tr.wishlistFiltersSeasonSpring &&
                            state.tripSeason == 'spring') ||
                        (value == context.tr.wishlistFiltersSeasonHajj &&
                            state.tripSeason == 'hajj') ||
                        (value == context.tr.wishlistFiltersSeasonNewYear &&
                            state.tripSeason == 'newYear'),
                    onTap: (value) {
                      if (value == context.tr.wishlistFiltersSeasonSpring) {
                        cubit.setTripSeason('spring');
                      } else if (value ==
                          context.tr.wishlistFiltersSeasonHajj) {
                        cubit.setTripSeason('hajj');
                      } else {
                        cubit.setTripSeason('newYear');
                      }
                    },
                  ),
                ),
                SizedBox(height: 24.h),
                TripFeaturesSection(
                  selectedKeys: state.tripFeatures,
                  onChanged: cubit.toggleTripFeature,
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.wishlistFiltersTripRating,
                  child: NumberRow(
                    selected: state.tripRating,
                    onTap: cubit.setTripRating,
                  ),
                ),
                SizedBox(height: 24.h),
                ToggleRow(
                  icon: Iconsax.ticket_discount,
                  label: context.tr.wishlistFiltersDiscountCode,
                  value: state.hasDiscountCode,
                  onChanged: cubit.setHasDiscountCode,
                ),
                SizedBox(height: 24.h),
                ToggleRow(
                  icon: Iconsax.close_circle,
                  label: context.tr.wishlistFiltersFreeCancellation,
                  value: state.freeCancellation,
                  onChanged: cubit.setFreeCancellation,
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            top: false,
            child: Container(
              padding: EdgeInsetsDirectional.fromSTEB(16.w, 10.h, 16.w, 14.h),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                border: Border(
                  top: BorderSide(
                    color: AppColors.border.withValues(alpha: 0.7),
                  ),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 89.w,
                    height: 48.h,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.darkText,
                        side: BorderSide(color: AppColors.secondaryText),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: FilledButton(
                        onPressed: () {
                          sl<AppNavigator>().push(
                            screen: const SearchResultView(),
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.onImage,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                        ),
                        child: Text(
                          context.tr.wishlistFiltersSeeResults,
                          style: AppTextStyles.button(
                            color: AppColors.onImage,
                          ).copyWith(fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

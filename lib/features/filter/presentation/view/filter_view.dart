import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/filter/presentation/cubit/filter_cubit.dart';
import 'package:trip_marche/features/filter/presentation/cubit/filter_state.dart';
import 'package:trip_marche/features/filter/presentation/view/search_result_view.dart';
import 'package:trip_marche/features/filter/presentation/widgets/filter_view_sections.dart';
import 'package:trip_marche/features/my_trips/domain/entities/trips_catalog_filters.dart';

class FilterView extends StatelessWidget {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FilterCubit>()..loadInitialData(),
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
        final ctaLabel = _seeResultsLabel(context, state);
        final sliderMin = state.metadata?.price.min ?? 0;
        final sliderMaxCandidate = state.metadata?.price.max ?? 10000;
        final sliderMax = sliderMaxCandidate <= sliderMin
            ? sliderMin + 1
            : sliderMaxCandidate;
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
                      SelectField(
                        value: _destinationSelectText(context, state),
                        isLoading:
                            state.destinationsStatus ==
                            FilterDestinationsStatus.loading,
                        onTap: () => _showDestinationsBottomSheet(context),
                      ),
                      SizedBox(height: 12.h),
                      _buildSelectedDestinationChips(context, state),
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
                          min: sliderMin,
                          max: sliderMax,
                          divisions: sliderMax > sliderMin ? 100 : null,
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
                              value:
                                  '${state.priceRange.start.round()} ${state.currencyCode}',
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: PriceValueField(
                              label: context.tr.wishlistFiltersPriceRange,
                              value:
                                  '${state.priceRange.end.round()} ${state.currencyCode}',
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
                    value: state.departureCountry.isEmpty
                        ? context.tr.wishlistFiltersSelectCountry
                        : state.departureCountry,
                    onTap: () => _showSingleSelectBottomSheet(
                      context: context,
                      title: context.tr.wishlistFiltersDepartureCountry,
                      options: const ['Egypt', 'Saudi Arabia', 'UAE', 'Qatar'],
                      selectedValue: state.departureCountry,
                      onSelected: cubit.setDepartureCountry,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.wishlistFiltersDepartureCity,
                  child: SelectField(
                    value: state.departureCity.isEmpty
                        ? context.tr.wishlistFiltersSelectCity
                        : state.departureCity,
                    onTap: () => _showSingleSelectBottomSheet(
                      context: context,
                      title: context.tr.wishlistFiltersDepartureCity,
                      options: const ['Cairo', 'Alexandria', 'Giza', 'Mansoura'],
                      selectedValue: state.departureCity,
                      onSelected: cubit.setDepartureCity,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.wishlistFiltersTripMonth,
                  child: SelectField(
                    value: state.tripMonth.isEmpty
                        ? context.tr.wishlistFiltersSelectMonth
                        : state.tripMonth,
                    onTap: () => _showSingleSelectBottomSheet(
                      context: context,
                      title: context.tr.wishlistFiltersTripMonth,
                      options: const [
                        'January',
                        'February',
                        'March',
                        'April',
                        'May',
                        'June',
                        'July',
                        'August',
                        'September',
                        'October',
                        'November',
                        'December',
                      ],
                      selectedValue: state.tripMonth,
                      onSelected: cubit.setTripMonth,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.tripDetailsAirlineLabel,
                  child: SelectField(
                    value: state.airline.isEmpty
                        ? context.tr.tripDetailsAirlineName
                        : state.airline,
                    onTap: () => _showSingleSelectBottomSheet(
                      context: context,
                      title: context.tr.tripDetailsAirlineLabel,
                      options: const ['Egyptair', 'Emirates', 'Qatar Airways'],
                      selectedValue: state.airline,
                      onSelected: cubit.setAirline,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.wishlistFiltersTravelAgency,
                  child: SelectField(
                    value: state.travelAgency.isEmpty
                        ? context.tr.wishlistFiltersAgencyNameHint
                        : state.travelAgency,
                    onTap: () => _showSingleSelectBottomSheet(
                      context: context,
                      title: context.tr.wishlistFiltersTravelAgency,
                      options: const [
                        'Travel Egypt Co.',
                        'Blue Sky Travel',
                        'Trip Marche Partner',
                      ],
                      selectedValue: state.travelAgency,
                      onSelected: cubit.setTravelAgency,
                    ),
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
                    value: state.otherCountries.isEmpty
                        ? context.tr.wishlistFiltersSelectCountries
                        : state.otherCountries.join(', '),
                    onTap: () => _showMultiSelectBottomSheet(
                      context: context,
                      title: context.tr.wishlistFiltersOtherCountries,
                      options: const ['Turkey', 'Jordan', 'Italy', 'Spain'],
                      selectedValues: state.otherCountries,
                      onToggle: cubit.toggleOtherCountry,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                FilterSection(
                  title: context.tr.wishlistFiltersOtherCities,
                  child: SelectField(
                    value: state.otherCities.isEmpty
                        ? context.tr.wishlistFiltersSelectCities
                        : state.otherCities.join(', '),
                    onTap: () => _showMultiSelectBottomSheet(
                      context: context,
                      title: context.tr.wishlistFiltersOtherCities,
                      options: const ['Istanbul', 'Rome', 'Madrid', 'Amman'],
                      selectedValues: state.otherCities,
                      onToggle: cubit.toggleOtherCity,
                    ),
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
                          final filters = _toTripsCatalogFilters(state);
                          sl<AppNavigator>().push(
                            screen: SearchResultView(filters: filters),
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.onImage,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 180),
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          transitionBuilder: (child, animation) =>
                              FadeTransition(opacity: animation, child: child),
                          child: Text(
                            ctaLabel,
                            key: ValueKey(ctaLabel),
                            style: AppTextStyles.button(
                              color: AppColors.onImage,
                            ).copyWith(fontSize: 16.sp),
                          ),
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

  String _seeResultsLabel(BuildContext context, FilterState state) {
    final count = state.activeFilterSectionsCount;
    if (count <= 0) {
      return context.tr.filterSeeResults;
    }
    final suffix = count == 1 ? 'Filter' : 'Filters';
    return '${context.tr.filterSeeResults} • $count $suffix';
  }

  String _destinationSelectText(BuildContext context, FilterState state) {
    if (state.destinationsStatus == FilterDestinationsStatus.failure) {
      return state.destinationsErrorMessage ??
          context.tr.tripDetailsFailedToLoad;
    }
    if (state.selectedDestinationIds.isEmpty) {
      return context.tr.wishlistFiltersSelectCity;
    }
    final selected = state.availableDestinations
        .where((d) => state.selectedDestinationIds.contains(d.id))
        .map((e) => e.name)
        .toList();
    return selected.isEmpty
        ? context.tr.wishlistFiltersSelectCity
        : selected.join(', ');
  }

  Widget _buildSelectedDestinationChips(
    BuildContext context,
    FilterState state,
  ) {
    final selected = state.availableDestinations
        .where((d) => state.selectedDestinationIds.contains(d.id))
        .toList();
    if (selected.isEmpty) {
      return const SizedBox.shrink();
    }
    final cubit = context.read<FilterCubit>();
    return Wrap(
      spacing: 12.w,
      runSpacing: 8.h,
      children: selected.map((destination) {
        return GestureDetector(
          onTap: () => cubit.toggleDestinationSelection(destination.id),
          child: SelectedDestinationChip(label: destination.name),
        );
      }).toList(),
    );
  }

  void _showDestinationsBottomSheet(BuildContext context) {
    final cubit = context.read<FilterCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return BlocProvider.value(
          value: cubit,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 12.h),
              child: BlocBuilder<FilterCubit, FilterState>(
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(999.r),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              context.tr.wishlistFiltersDestination,
                              style: AppTextStyles.heading3(
                                color: AppColors.darkText,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(ctx),
                            icon: Icon(
                              Icons.close_rounded,
                              size: 20.sp,
                              color: AppColors.darkText,
                            ),
                          ),
                        ],
                      ),
                      if (state.destinationsStatus ==
                          FilterDestinationsStatus.loading)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            top: 24.h,
                            bottom: 24.h,
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else
                        Flexible(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.availableDestinations.length,
                            separatorBuilder: (_, __) => Divider(
                              color: AppColors.border.withValues(alpha: 0.6),
                            ),
                            itemBuilder: (context, index) {
                              final destination =
                                  state.availableDestinations[index];
                              final selected = state.selectedDestinationIds
                                  .contains(destination.id);
                              return CheckboxListTile(
                                value: selected,
                                onChanged: (_) => cubit
                                    .toggleDestinationSelection(destination.id),
                                activeColor: AppColors.primary,
                                dense: true,
                                contentPadding: EdgeInsetsDirectional.zero,
                                title: Text(
                                  destination.name,
                                  style: AppTextStyles.bodyMedium(
                                    color: AppColors.darkText,
                                  ),
                                ),
                                subtitle: destination.country.isEmpty
                                    ? null
                                    : Text(
                                        destination.country,
                                        style: AppTextStyles.caption(
                                          color: AppColors.secondaryText,
                                        ),
                                      ),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                              );
                            },
                          ),
                        ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: FilledButton(
                          onPressed: () => Navigator.pop(ctx),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.onImage,
                          ),
                          child: Text(
                            context.tr.commonCancel,
                            style: TextStyles.textViewSemiBold16.copyWith(
                              color: AppColors.onImage,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSingleSelectBottomSheet({
    required BuildContext context,
    required String title,
    required List<String> options,
    required String selectedValue,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 12.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.heading3(color: AppColors.darkText),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(ctx),
                      icon: Icon(
                        Icons.close_rounded,
                        size: 20.sp,
                        color: AppColors.darkText,
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: options.length + 1,
                    separatorBuilder: (_, __) => Divider(
                      color: AppColors.border.withValues(alpha: 0.6),
                    ),
                    itemBuilder: (_, index) {
                      if (index == 0) {
                        return ListTile(
                          title: Text(
                            context.tr.wishlistFiltersClearAll,
                            style: AppTextStyles.bodyMedium(
                              color: AppColors.error,
                            ),
                          ),
                          onTap: () {
                            onSelected('');
                            Navigator.pop(ctx);
                          },
                        );
                      }
                      final option = options[index - 1];
                      return RadioListTile<String>(
                        value: option,
                        groupValue: selectedValue,
                        activeColor: AppColors.primary,
                        title: Text(
                          option,
                          style: AppTextStyles.bodyMedium(color: AppColors.darkText),
                        ),
                        onChanged: (value) {
                          onSelected(value ?? '');
                          Navigator.pop(ctx);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMultiSelectBottomSheet({
    required BuildContext context,
    required String title,
    required List<String> options,
    required Set<String> selectedValues,
    required ValueChanged<String> onToggle,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 12.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.heading3(color: AppColors.darkText),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        for (final value in selectedValues.toList()) {
                          onToggle(value);
                        }
                      },
                      child: Text(
                        context.tr.wishlistFiltersClearAll,
                        style: AppTextStyles.bodyMedium(color: AppColors.error),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(ctx),
                      icon: Icon(
                        Icons.close_rounded,
                        size: 20.sp,
                        color: AppColors.darkText,
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: options.length,
                    separatorBuilder: (_, __) => Divider(
                      color: AppColors.border.withValues(alpha: 0.6),
                    ),
                    itemBuilder: (_, index) {
                      final option = options[index];
                      return CheckboxListTile(
                        value: selectedValues.contains(option),
                        activeColor: AppColors.primary,
                        title: Text(
                          option,
                          style: AppTextStyles.bodyMedium(color: AppColors.darkText),
                        ),
                        onChanged: (_) => onToggle(option),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  TripsCatalogFilters _toTripsCatalogFilters(FilterState state) {
    int? month;
    if (state.tripMonth.isNotEmpty) {
      final months = {
        'january': 1,
        'february': 2,
        'march': 3,
        'april': 4,
        'may': 5,
        'june': 6,
        'july': 7,
        'august': 8,
        'september': 9,
        'october': 10,
        'november': 11,
        'december': 12,
      };
      month = months[state.tripMonth.toLowerCase()];
    }

    String? duration;
    if (state.selectedDurations.contains('1-3 Days')) {
      duration = '1_3';
    } else if (state.selectedDurations.contains('Up to 5 Days')) {
      duration = 'up_to_5';
    } else if (state.selectedDurations.contains('5+ Days')) {
      duration = '5_plus';
    }

    String? groupSize;
    if (state.selectedGroupSizes.contains('5-10')) {
      groupSize = '5_10';
    } else if (state.selectedGroupSizes.contains('Up to 25')) {
      groupSize = 'up_to_25';
    } else if (state.selectedGroupSizes.contains('25+')) {
      groupSize = '25_plus';
    }

    String? visaType;
    if (state.tripFeatures.contains('visaOnArrival')) {
      visaType = 'on_arrival';
    } else if (state.tripFeatures.contains('noVisa')) {
      visaType = 'none';
    }

    return TripsCatalogFilters(
      type: state.tripType.isEmpty ? null : state.tripType,
      departureCountry: state.departureCountry.isEmpty
          ? null
          : state.departureCountry,
      departureCity: state.departureCity.isEmpty ? null : state.departureCity,
      destinations: state.selectedDestinationIds.isEmpty
          ? null
          : state.selectedDestinationIds.toList(),
      minPrice: state.priceRange.start,
      maxPrice: state.priceRange.end,
      minVendorRating: state.agencyRating > 0 ? state.agencyRating : null,
      minRating: state.tripRating > 0 ? state.tripRating.toDouble() : null,
      duration: duration,
      groupSize: groupSize,
      citiesCount: state.citiesCount > 0 ? state.citiesCount : null,
      countriesCount: state.countriesCount > 0 ? state.countriesCount : null,
      season: state.tripSeason == 'newYear'
          ? 'new_year'
          : (state.tripSeason.isEmpty ? null : state.tripSeason),
      tripMonth: month,
      visaType: visaType,
      includeFlight: state.tripFeatures.contains('includeFlight') ? 1 : null,
      hotelsOnly: state.tripFeatures.contains('includeHotel') ? 1 : null,
      acceptsCoupons: state.hasDiscountCode ? 1 : null,
      freeCancellation: state.freeCancellation ? 1 : null,
      country: state.otherCountries.isEmpty ? null : state.otherCountries.join(','),
      search: null,
      sort: null,
    );
  }
}

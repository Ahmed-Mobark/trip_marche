import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../cubit/wishlist_filter_cubit.dart';
import '../cubit/wishlist_filter_state.dart';
import '../widgets/wishlist_filter_widgets.dart';

class WishlistFilterView extends StatelessWidget {
  const WishlistFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WishlistFilterCubit(),
      child: const _WishlistFilterBody(),
    );
  }
}

class _WishlistFilterBody extends StatelessWidget {
  const _WishlistFilterBody();

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 16.w;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocBuilder<WishlistFilterCubit, WishlistFilterState>(
          builder: (context, state) {
            final cubit = context.read<WishlistFilterCubit>();

            return Column(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: horizontalPadding,
                    end: horizontalPadding,
                    top: 10.h,
                    bottom: 10.h,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          context.tr.wishlistFiltersTitle,
                          style: AppTextStyles.heading3(color: AppColors.darkText),
                        ),
                      ),
                      TextButton(
                        onPressed: cubit.reset,
                        child: Text(
                          context.tr.wishlistFiltersClearAll,
                          style: AppTextStyles.bodyMedium(color: AppColors.error)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Iconsax.close_circle, size: 22.sp),
                        color: AppColors.greyText,
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsetsDirectional.only(
                      start: horizontalPadding,
                      end: horizontalPadding,
                      bottom: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12.h),
                        WishlistFilterSectionTitle(title: context.tr.wishlistFiltersDestination),
                        SizedBox(height: 10.h),
                        WishlistFilterSelectField(
                          value: state.destination,
                          hint: context.tr.wishlistFiltersSelectDestination,
                          onTap: () async {
                            final selected = await _pickOne(
                              context: context,
                              title: context.tr.wishlistFiltersDestination,
                              options: const ['Paris', 'Dubai', 'Cairo', 'Riyadh'],
                              selected: state.destination,
                            );
                            if (selected != null) cubit.setDestination(selected);
                          },
                        ),
                        SizedBox(height: 16.h),
                        WishlistFilterSectionTitle(title: context.tr.wishlistFiltersPriceRange),
                        SizedBox(height: 10.h),
                        const WishlistFilterPriceHistogram(),
                        RangeSlider(
                          values: state.priceRange,
                          min: 0,
                          max: 10000,
                          divisions: 100,
                          activeColor: AppColors.purpleColor,
                          inactiveColor: AppColors.border,
                          labels: RangeLabels(
                            '${state.priceRange.start.round()}',
                            '${state.priceRange.end.round()}',
                          ),
                          onChanged: cubit.setPriceRange,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WishlistFilterPricePill(
                              value: state.priceRange.start.round().toString(),
                            ),
                            WishlistFilterPricePill(
                              value: state.priceRange.end.round().toString(),
                            ),
                          ],
                        ),
                        SizedBox(height: 18.h),
                        WishlistFilterSectionTitle(title: context.tr.wishlistFiltersTripType),
                        SizedBox(height: 10.h),
                        WishlistFilterSegmented(
                          leftLabel: context.tr.wishlistFiltersDomestic,
                          rightLabel: context.tr.wishlistFiltersInternational,
                          value: state.tripType,
                          onChanged: cubit.setTripType,
                        ),
                        SizedBox(height: 18.h),
                        WishlistFilterSectionTitle(
                          title: context.tr.wishlistFiltersDepartureCountry,
                        ),
                        SizedBox(height: 10.h),
                        WishlistFilterSelectField(
                          value: state.departureCountry,
                          hint: context.tr.wishlistFiltersSelectCountry,
                          onTap: () async {
                            final selected = await _pickOne(
                              context: context,
                              title: context.tr.wishlistFiltersDepartureCountry,
                              options: const ['Egypt', 'UAE', 'Saudi Arabia'],
                              selected: state.departureCountry,
                            );
                            if (selected != null) cubit.setDepartureCountry(selected);
                          },
                        ),
                        SizedBox(height: 14.h),
                        WishlistFilterSectionTitle(title: context.tr.wishlistFiltersDepartureCity),
                        SizedBox(height: 10.h),
                        WishlistFilterSelectField(
                          value: state.departureCity,
                          hint: context.tr.wishlistFiltersSelectCity,
                          onTap: () async {
                            final selected = await _pickOne(
                              context: context,
                              title: context.tr.wishlistFiltersDepartureCity,
                              options: const ['Cairo', 'Giza', 'Alexandria'],
                              selected: state.departureCity,
                            );
                            if (selected != null) cubit.setDepartureCity(selected);
                          },
                        ),
                        SizedBox(height: 14.h),
                        WishlistFilterSectionTitle(title: context.tr.wishlistFiltersTripMonth),
                        SizedBox(height: 10.h),
                        WishlistFilterSelectField(
                          value: state.tripMonth,
                          hint: context.tr.wishlistFiltersSelectMonth,
                          onTap: () async {
                            final selected = await _pickOne(
                              context: context,
                              title: context.tr.wishlistFiltersTripMonth,
                              options: const ['May', 'June', 'July', 'August'],
                              selected: state.tripMonth,
                            );
                            if (selected != null) cubit.setTripMonth(selected);
                          },
                        ),
                        SizedBox(height: 14.h),
                        WishlistFilterSectionTitle(title: context.tr.wishlistFiltersActions),
                        SizedBox(height: 10.h),
                        WishlistFilterSelectField(
                          value: state.actions,
                          hint: context.tr.wishlistFiltersSelectAction,
                          onTap: () async {
                            final selected = await _pickOne(
                              context: context,
                              title: context.tr.wishlistFiltersActions,
                              options: const ['City tour', 'Adventure', 'Museum'],
                              selected: state.actions,
                            );
                            if (selected != null) cubit.setActions(selected);
                          },
                        ),
                        SizedBox(height: 14.h),
                        WishlistFilterSectionTitle(title: context.tr.wishlistFiltersTravelAgency),
                        SizedBox(height: 10.h),
                        WishlistFilterSelectField(
                          value: state.agency,
                          hint: context.tr.wishlistFiltersAgencyNameHint,
                          onTap: () async {
                            final selected = await _pickOne(
                              context: context,
                              title: context.tr.wishlistFiltersTravelAgency,
                              options: const ['Trip Marche', 'Sky Travel', 'Go Trips'],
                              selected: state.agency,
                            );
                            if (selected != null) cubit.setAgency(selected);
                          },
                        ),
                        SizedBox(height: 14.h),
                        WishlistFilterSectionTitle(title: context.tr.wishlistFiltersAgencyRating),
                        SizedBox(height: 10.h),
                        WishlistFilterRatingChips(
                          value: state.agencyRating,
                          onChanged: cubit.setAgencyRating,
                        ),
                        SizedBox(height: 18.h),
                        WishlistFilterSectionTitle(title: context.tr.wishlistFiltersOtherCountries),
                        SizedBox(height: 10.h),
                        WishlistFilterSelectField(
                          value: state.otherCountries,
                          hint: context.tr.wishlistFiltersSelectCountries,
                          onTap: () async {
                            final selected = await _pickOne(
                              context: context,
                              title: context.tr.wishlistFiltersOtherCountries,
                              options: const ['France', 'Spain', 'Italy'],
                              selected: state.otherCountries,
                            );
                            if (selected != null) cubit.setOtherCountries(selected);
                          },
                        ),
                        SizedBox(height: 14.h),
                        WishlistFilterSectionTitle(title: context.tr.wishlistFiltersOtherCities),
                        SizedBox(height: 10.h),
                        WishlistFilterSelectField(
                          value: state.otherCities,
                          hint: context.tr.wishlistFiltersSelectCities,
                          onTap: () async {
                            final selected = await _pickOne(
                              context: context,
                              title: context.tr.wishlistFiltersOtherCities,
                              options: const ['Nice', 'Barcelona', 'Rome'],
                              selected: state.otherCities,
                            );
                            if (selected != null) cubit.setOtherCities(selected);
                          },
                        ),
                        SizedBox(height: 18.h),
                        WishlistFilterSectionTitle(
                          title: context.tr.wishlistFiltersNumberOfCities,
                        ),
                        SizedBox(height: 10.h),
                        WishlistFilterNumberChips(
                          value: state.numberOfCities,
                          onChanged: cubit.setNumberOfCities,
                        ),
                        SizedBox(height: 16.h),
                        WishlistFilterSectionTitle(
                          title: context.tr.wishlistFiltersNumberOfCountries,
                        ),
                        SizedBox(height: 10.h),
                        WishlistFilterNumberChips(
                          value: state.numberOfCountries,
                          onChanged: cubit.setNumberOfCountries,
                        ),
                        SizedBox(height: 18.h),
                        WishlistFilterSectionTitle(title: context.tr.wishlistFiltersDuration),
                        SizedBox(height: 10.h),
                        WishlistFilterChoiceChips(
                          value: state.duration,
                          options: [
                            context.tr.wishlistFiltersDurationUpTo3,
                            context.tr.wishlistFiltersDurationUpTo7,
                            context.tr.wishlistFiltersDuration7Plus,
                          ],
                          onChanged: cubit.setDuration,
                        ),
                        SizedBox(height: 18.h),
                        WishlistFilterSectionTitle(title: context.tr.wishlistFiltersGroupSize),
                        SizedBox(height: 10.h),
                        WishlistFilterChoiceChips(
                          value: state.groupSize,
                          options: [
                            context.tr.wishlistFiltersGroupSizeSmall,
                            context.tr.wishlistFiltersGroupSizeUpTo20,
                            context.tr.wishlistFiltersGroupSize20Plus,
                          ],
                          onChanged: cubit.setGroupSize,
                        ),
                        SizedBox(height: 18.h),
                        WishlistFilterSectionTitle(title: context.tr.wishlistFiltersTripSeason),
                        SizedBox(height: 10.h),
                        WishlistFilterChoiceChips(
                          value: state.tripSeason,
                          options: [
                            context.tr.wishlistFiltersSeasonSpring,
                            context.tr.wishlistFiltersSeasonHajj,
                            context.tr.wishlistFiltersSeasonNewYear,
                          ],
                          onChanged: cubit.setTripSeason,
                        ),
                        SizedBox(height: 18.h),
                        WishlistFilterTripFeatures(
                          title: context.tr.wishlistFiltersTripFeatures,
                          items: [
                            ('includeFlight', context.tr.wishlistFiltersFeatureIncludeFlight),
                            ('includeHotel', context.tr.wishlistFiltersFeatureIncludeHotel),
                            ('freeMeal', context.tr.wishlistFiltersFeatureFreeMeal),
                            ('visaOnArrival', context.tr.wishlistFiltersFeatureVisaOnArrival),
                          ],
                          selectedKeys: state.tripFeatures,
                          onChanged: cubit.toggleTripFeature,
                        ),
                        SizedBox(height: 18.h),
                        WishlistFilterSectionTitle(title: context.tr.wishlistFiltersTripRating),
                        SizedBox(height: 10.h),
                        WishlistFilterRatingChips(
                          value: state.tripRating,
                          onChanged: cubit.setTripRating,
                        ),
                        SizedBox(height: 18.h),
                        WishlistFilterToggleRow(
                          label: context.tr.wishlistFiltersDiscountCode,
                          value: state.hasDiscountCode,
                          onChanged: cubit.setHasDiscountCode,
                        ),
                        SizedBox(height: 12.h),
                        WishlistFilterToggleRow(
                          label: context.tr.wishlistFiltersFreeCancellation,
                          value: state.freeCancellation,
                          onChanged: cubit.setFreeCancellation,
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    horizontalPadding,
                    0,
                    horizontalPadding,
                    14.h,
                  ),
                  child: AppButton(
                    heigh: 56.h,
                    radius: 14.r,
                    gradient: AppColors.primaryGradient,
                    onTap: () => Navigator.pop(context),
                    text: context.tr.wishlistFiltersSeeResults,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<String?> _pickOne({
    required BuildContext context,
    required String title,
    required List<String> options,
    required String selected,
  }) async {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: 16.w,
              end: 16.w,
              top: 12.h,
              bottom: 12.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.heading3(color: AppColors.darkText),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Iconsax.close_circle, size: 22.sp),
                      color: AppColors.greyText,
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                ...options.map(
                  (o) => ListTile(
                    contentPadding: EdgeInsetsDirectional.zero,
                    title: Text(
                      o,
                      style: AppTextStyles.bodyMedium(color: AppColors.darkText),
                    ),
                    trailing: selected == o
                        ? Icon(
                            Icons.check_circle,
                            color: AppColors.purpleColor,
                            size: 20.sp,
                          )
                        : null,
                    onTap: () => Navigator.pop(context, o),
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


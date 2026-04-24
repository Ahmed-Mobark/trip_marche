import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import 'package:trip_marche/features/trip_details/presentation/cubit/trip_details_cubit.dart';
import 'package:trip_marche/features/trip_details/presentation/cubit/trip_details_state.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/review_item_display.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_details_info_card.dart';

const _kGalleryImageUrls = <String>[
  'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400',
  'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
  'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=400',
];

const _kDestinationImageUrls = <String>[
  'https://images.unsplash.com/photo-1539635278303-d4002c07eae3?w=400',
  'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=400',
];

/// Scrollable sections below the stats grid on Trip Details (design reference).
class TripDetailsScrollSections extends StatelessWidget {
  const TripDetailsScrollSections({super.key});

  @override
  Widget build(BuildContext context) {
    final gap = 20.h;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const _OutInSummary(),
        SizedBox(height: gap),
        _SectionTitle(text: context.tr.tripDetailsTripDescriptionTitle),
        SizedBox(height: 8.h),
        Text(
          context.tr.tripDetailsDescriptionBody,
          style: AppTextStyles.body(color: AppColors.secondaryText),
        ),
        SizedBox(height: gap),
        _SectionTitle(text: context.tr.tripDetailsAmenitiesTitle),
        SizedBox(height: 12.h),
        const _AmenitiesGrid(),
        SizedBox(height: gap),
        _SectionTitle(text: context.tr.tripDetailsAccommodationTitle),
        SizedBox(height: 12.h),
        const _AccommodationCard(),
        SizedBox(height: gap),
        _SectionRow(
          title: context.tr.tripDetailsItineraryTitle,
          actionText: context.tr.tripDetailsViewFullItinerary,
          onAction: () {},
        ),
        SizedBox(height: 12.h),
        _ItineraryDayCard(
          location: context.tr.tripDetailsItineraryLoc1,
          activities: context.tr.tripDetailsItineraryActs1,
          dayIndex: 0,
        ),
        SizedBox(height: 10.h),
        _ItineraryDayCard(
          location: context.tr.tripDetailsItineraryLoc2,
          activities: context.tr.tripDetailsItineraryActs2,
          dayIndex: 1,
        ),
        SizedBox(height: gap),
        _SectionTitle(text: context.tr.tripDetailsFlightDetailsTitle),
        SizedBox(height: 10.h),
        _TransportLegCard(
          icon: Iconsax.airplane,
          summary: context.tr.tripDetailsFlightLegSummary,
        ),
        SizedBox(height: 12.h),
        _SectionTitle(text: context.tr.tripDetailsTransportationTitle),
        SizedBox(height: 10.h),
        _TransportLegCard(
          icon: Iconsax.bus,
          summary: context.tr.tripDetailsTrainLegSummary,
        ),
        SizedBox(height: gap),
        _SectionTitle(text: context.tr.tripDetailsDestinationsTitle),
        SizedBox(height: 12.h),
        const _DestinationsRow(),
        SizedBox(height: gap),
        _SectionTitle(text: context.tr.tripDetailsIncludesExcludesTitle),
        SizedBox(height: 12.h),
        const _IncludesExcludes(),
        SizedBox(height: gap),
        _SectionRow(
          title: context.tr.tripDetailsImagesTitle,
          actionText: context.tr.tripDetailsSeeAllPhotos,
          onAction: () {},
        ),
        SizedBox(height: 12.h),
        const _HorizontalImageRow(urls: _kGalleryImageUrls),
        SizedBox(height: gap),
        _SectionRow(
          title: context.tr.tripDetailsActivityPlansTitle,
          actionText: context.tr.tripDetailsViewAllActivities,
          onAction: () {},
        ),
        SizedBox(height: 12.h),
        const _ActivityRows(),
        SizedBox(height: gap),
        const _PolicyList(),
        SizedBox(height: gap),
        _SectionRow(
          title: context.tr.tripDetailsReviewsTitle,
          actionText: context.tr.tripDetailsSeeAllReviews,
          onAction: () {},
        ),
        SizedBox(height: 12.h),
        ReviewItemDisplay(
          name: context.tr.tripDetailsReviewSampleName,
          rating: 5,
          date: context.tr.tripDetailsReviewSampleDate,
          comment: context.tr.tripDetailsReviewSampleBody,
        ),
        SizedBox(height: gap),
        _SectionTitle(text: context.tr.tripDetailsOrganizerTitle),
        SizedBox(height: 10.h),
        const _OrganizerCard(),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyles.subtitle(color: AppColors.darkText));
  }
}

class _SectionRow extends StatelessWidget {
  const _SectionRow({
    required this.title,
    required this.actionText,
    required this.onAction,
  });

  final String title;
  final String actionText;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.subtitle(color: AppColors.darkText),
          ),
        ),
        TextButton(
          onPressed: onAction,
          child: Text(
            actionText,
            style: AppTextStyles.bodyMedium(
              color: AppColors.primary,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _AmenitiesGrid extends StatelessWidget {
  const _AmenitiesGrid();

  @override
  Widget build(BuildContext context) {
    final items = [
      (Iconsax.building_4, context.tr.tripDetailsAmenityHotelStars),
      (Iconsax.coffee, context.tr.tripDetailsAmenityFoodBar),
      (Iconsax.bus, context.tr.tripDetailsAmenityBusTrip),
      (Iconsax.user, context.tr.tripDetailsAmenityTourGuide),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 10.w,
      childAspectRatio: 3.2,
      children: items
          .map(
            (e) => Row(
              children: [
                Icon(e.$1, color: AppColors.primary, size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    e.$2,
                    style: AppTextStyles.bodySmall(color: AppColors.darkText),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class _AccommodationCard extends StatelessWidget {
  const _AccommodationCard();

  @override
  Widget build(BuildContext context) {
    return TripDetailsInfoCard(
      padding: EdgeInsetsDirectional.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr.tripDetailsHotelName,
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.darkText,
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Iconsax.star1,
                          color: AppColors.starYellow,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          context.tr.tripDetailsHotelRatingStars,
                          style: AppTextStyles.caption(
                            color: AppColors.darkText,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      context.tr.tripDetailsHotelAddress,
                      style: AppTextStyles.bodySmall(color: AppColors.greyText),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      context.tr.tripDetailsCheckInOut,
                      style: AppTextStyles.caption(color: AppColors.greyText),
                    ),
                  ],
                ),
              ),
              Material(
                color: AppColors.lightBg,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Icon(
                      Iconsax.location,
                      color: AppColors.success,
                      size: 20.sp,
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

class _ItineraryDayCard extends StatelessWidget {
  const _ItineraryDayCard({
    required this.location,
    required this.activities,
    required this.dayIndex,
  });

  final String location;
  final String activities;
  final int dayIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripDetailsCubit, TripDetailsState>(
      builder: (context, state) {
        final expanded = state.expandedDayIndex == dayIndex;
        return Material(
          color: AppColors.lightBg,
          borderRadius: BorderRadius.circular(14.r),
          child: InkWell(
            onTap: () =>
                context.read<TripDetailsCubit>().toggleExpandedDay(dayIndex),
            borderRadius: BorderRadius.circular(14.r),
            child: Container(
              width: double.infinity,
              padding: EdgeInsetsDirectional.all(14.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          location,
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.darkText,
                          ).copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsetsDirectional.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          context.tr.tripDetailsViewMap,
                          style: AppTextStyles.caption(
                            color: AppColors.primary,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  if (expanded) ...[
                    SizedBox(height: 10.h),
                    Text(
                      activities,
                      style: AppTextStyles.bodySmall(
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ] else
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: 6.h),
                      child: Icon(
                        Iconsax.arrow_down_1,
                        size: 18.sp,
                        color: AppColors.greyText,
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

class _TransportLegCard extends StatelessWidget {
  const _TransportLegCard({required this.icon, required this.summary});

  final IconData icon;
  final String summary;

  @override
  Widget build(BuildContext context) {
    return TripDetailsInfoCard(
      borderRadius: 14.r,
      withShadow: false,
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              summary,
              style: AppTextStyles.bodySmall(color: AppColors.darkText),
            ),
          ),
        ],
      ),
    );
  }
}

class _DestinationsRow extends StatelessWidget {
  const _DestinationsRow();

  @override
  Widget build(BuildContext context) {
    final labels = [
      context.tr.tripDetailsDestinationDahab,
      context.tr.tripDetailsDestinationNuweiba,
    ];
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _kDestinationImageUrls.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, i) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AppCachedNetworkImage(
                  imageUrl: _kDestinationImageUrls[i],
                  width: 160.w,
                  height: 120.h,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 160.w,
                  padding: EdgeInsetsDirectional.symmetric(vertical: 8.h),
                  color: Colors.black.withValues(alpha: 0.45),
                  child: Text(
                    labels[i],
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySmall(
                      color: Colors.white,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _IncludesExcludes extends StatelessWidget {
  const _IncludesExcludes();

  @override
  Widget build(BuildContext context) {
    final inc = [
      context.tr.tripDetailsAmenityHotelStars,
      context.tr.tripDetailsAmenityFoodBar,
      context.tr.tripDetailsAmenityBusTrip,
      context.tr.tripDetailsAmenityTourGuide,
    ];
    final exc = [
      context.tr.tripDetailsExcludeVisa,
      context.tr.tripDetailsExcludeAlcohol,
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.tripDetailsIncludesTitle,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.darkText,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.h),
              ...inc.map(
                (t) => Padding(
                  padding: EdgeInsetsDirectional.only(bottom: 8.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Iconsax.tick_circle,
                        color: AppColors.primary,
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          t,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.darkText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.tripDetailsExcludesTitle,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.darkText,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.h),
              ...exc.map(
                (t) => Padding(
                  padding: EdgeInsetsDirectional.only(bottom: 8.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Iconsax.close_circle,
                        color: AppColors.error,
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          t,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.darkText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HorizontalImageRow extends StatelessWidget {
  const _HorizontalImageRow({required this.urls});
  final List<String> urls;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: urls.length,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (_, i) => ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: AppCachedNetworkImage(
            imageUrl: urls[i],
            width: 120.w,
            height: 88.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _ActivityRows extends StatelessWidget {
  const _ActivityRows();

  @override
  Widget build(BuildContext context) {
    final rows = [
      (
        'snorkel',
        context.tr.tripDetailsActivitySnorkel,
        context.tr.tripDetailsActivitySnorkelPrice,
      ),
      (
        'safari',
        context.tr.tripDetailsActivitySafari,
        context.tr.tripDetailsActivitySafariPrice,
      ),
      (
        'dive',
        context.tr.tripDetailsActivityDiving,
        context.tr.tripDetailsActivityDivingPrice,
      ),
    ];
    return Column(
      children: rows
          .map(
            (r) => Padding(
              padding: EdgeInsetsDirectional.only(bottom: 10.h),
              child: BlocBuilder<TripDetailsCubit, TripDetailsState>(
                builder: (context, state) {
                  final added = state.addedActivityIds.contains(r.$1);
                  return TripDetailsInfoCard(
                    withShadow: false,
                    borderRadius: 12.r,
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.activity,
                          color: AppColors.primary,
                          size: 20.sp,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            r.$2,
                            style: AppTextStyles.bodyMedium(
                              color: AppColors.darkText,
                            ),
                          ),
                        ),
                        Text(
                          r.$3,
                          style: AppTextStyles.caption(
                            color: AppColors.darkText,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 10.w),
                        TextButton(
                          onPressed: () => context
                              .read<TripDetailsCubit>()
                              .toggleActivity(r.$1),
                          style: TextButton.styleFrom(
                            backgroundColor: added
                                ? AppColors.lightBg
                                : AppColors.primary,
                            padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            added
                                ? context.tr.tripDetailsAdded
                                : context.tr.tripDetailsAdd,
                            style: AppTextStyles.caption(
                              color: added
                                  ? AppColors.greyText
                                  : AppColors.white,
                            ).copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
          .toList(),
    );
  }
}

class _PolicyList extends StatelessWidget {
  const _PolicyList();

  @override
  Widget build(BuildContext context) {
    final items = [
      (Iconsax.clipboard_text, context.tr.tripDetailsPolicyCancellation),
      (Iconsax.shield_tick, context.tr.tripDetailsPolicyInsurance),
      (Iconsax.document_text, context.tr.tripDetailsPolicyTerms),
      (Iconsax.message_question, context.tr.tripDetailsPolicyFaqs),
    ];
    return Column(
      children: items
          .map(
            (e) => Material(
              color: AppColors.white,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 12.h),
                  child: Row(
                    children: [
                      Icon(e.$1, color: AppColors.primary, size: 20.sp),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          e.$2,
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.darkText,
                          ),
                        ),
                      ),
                      Icon(
                        Iconsax.arrow_right_3,
                        size: 16.sp,
                        color: AppColors.greyText,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _OrganizerCard extends StatelessWidget {
  const _OrganizerCard();

  @override
  Widget build(BuildContext context) {
    return TripDetailsInfoCard(
      borderRadius: 14.r,
      withShadow: false,
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: AppColors.lightBg,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(
              Iconsax.building,
              color: AppColors.primary,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.tripDetailsCompanyName,
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.darkText,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  context.tr.tripDetailsOrganizerSubtitle,
                  style: AppTextStyles.caption(color: AppColors.greyText),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999.r),
              ),
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 14.w,
                vertical: 8.h,
              ),
            ),
            child: Text(
              context.tr.tripDetailsFollow,
              style: AppTextStyles.caption(
                color: AppColors.primary,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

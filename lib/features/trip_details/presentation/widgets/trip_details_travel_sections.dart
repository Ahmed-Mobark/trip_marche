import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'trip_details_accommodation_section.dart';
import 'trip_details_destination_details_section.dart';
import 'trip_details_flight_details_section.dart';
import 'trip_details_post_stats_sections.dart';
import 'trip_details_reviews_section.dart';
import 'trip_details_transportation_section.dart';

class TripDetailsTravelSections extends StatelessWidget {
  const TripDetailsTravelSections({super.key, required this.trip});

  final TripDetails trip;

  void _openDetailPage(BuildContext context, String title, String? body) {
    final text = body?.trim();
    if (text == null || text.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _FullTextPage(title: title, body: text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accommodations = trip.accommodations;

    return Padding(
      padding: EdgeInsetsDirectional.only(top: 0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Where you'll stay (Accommodation)
          if (accommodations.isNotEmpty) ...[
            TripDetailsAccommodationSection(trip: trip),
            SizedBox(height: 12.h),
          ],

          // 2. Flight details
          TripDetailsFlightDetailsSection(trip: trip),
          SizedBox(height: 12.h),
          Divider(color: AppColors.border(context), height: 1),
          SizedBox(height: 12.h),

          // 4. Transportation
          TripDetailsTransportationSection(trip: trip),
          SizedBox(height: 12.h),

          // 5. Departure details
          TripDetailsDepartureDetailsCard(trip: trip),
          SizedBox(height: 12.h),

          // 6. Destination details (grid)
          const TripDetailsDestinationDetailsGridCard(),
          SizedBox(height: 12.h),

          // 7. User reviews
          TripDetailsReviewsSection(trip: trip),
          SizedBox(height: 12.h),

          // 9. Quick links (visa, instructions, safety, etc.)
          TripDetailsQuickLinks(
            onVisa: () => _openDetailPage(
              context,
              context.tr.tripDetailsVisaDetailsTitle,
              trip.visaDetails,
            ),
            onInstructions: () => _openDetailPage(
              context,
              context.tr.tripDetailsTripInstructionsTitle,
              trip.tripInstructions,
            ),
            onSafety: () => _openDetailPage(
              context,
              context.tr.tripDetailsSafetyProceduresTitle,
              trip.safetyProcedures,
            ),
            onTerms: () => _openDetailPage(
              context,
              context.tr.tripDetailsPolicyTerms,
              trip.termsConditions,
            ),
            onCancellation: () => _openDetailPage(
              context,
              context.tr.tripDetailsPolicyCancellation,
              trip.cancellationPolicy,
            ),
          ),
          SizedBox(height: 12.h),

          // 10. Travel Partner (Company)
          Text(
            context.tr.tripDetailsCompanySectionTitle,
            style: TextStyles.textViewBold14.copyWith(
              color: AppColors.darkText(context),
            ),
          ),
          SizedBox(height: 12.h),
          TripDetailsCompanyCard(
            companyName: trip.vendor.name,
            ratingValue: trip.rating.toStringAsFixed(2),
            ratingCount: context.tr.tripDetailsReviewsCount(trip.reviewsCount),
            avatarUrl: trip.vendor.avatar,
            onFollow: () {},
          ),

          SizedBox(height: 70.h),
        ],
      ),
    );
  }
}

class _FullTextPage extends StatelessWidget {
  const _FullTextPage({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBg(context),
      appBar: AppBar(
        title: Text(
          title,
          style: AppTextStyles.heading3(color: AppColors.darkText(context)),
        ),
        backgroundColor: AppColors.cardBg(context),
        elevation: 0,
        scrolledUnderElevation: 0.5,
        iconTheme: IconThemeData(color: AppColors.darkText(context)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(
          start: 20.w,
          end: 20.w,
          top: 16.h,
          bottom: MediaQuery.paddingOf(context).bottom + 24.h,
        ),
        child: SelectableText(
          body,
          style: AppTextStyles.body(
            color: AppColors.greyText(context),
          ).copyWith(height: 1.6),
        ),
      ),
    );
  }
}

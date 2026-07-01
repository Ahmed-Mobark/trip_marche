import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/review_figma_tokens.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_review_data.dart';
import 'expandable_description.dart';
import 'included_features_section.dart';

class ReviewTripCard extends StatefulWidget {
  const ReviewTripCard({
    super.key,
    required this.trip,
    required this.includedTitle,
  });

  final BookingReviewTrip trip;
  final String includedTitle;

  @override
  State<ReviewTripCard> createState() => _ReviewTripCardState();
}

class _ReviewTripCardState extends State<ReviewTripCard> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final trip = widget.trip;
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.all(ReviewFigmaTokens.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ReviewFigmaTokens.cardRadius),
        border: Border.all(color: ReviewFigmaTokens.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExpandableDescriptionHeader(
            title: trip.name,
            isExpanded: _expanded,
            onToggle: () => setState(() => _expanded = !_expanded),
          ),
          if (_expanded) ...[
            Text(
              trip.description,
              style: AppTextStyles.bodyMedium(
                color: ReviewFigmaTokens.descriptionGrey,
              ).copyWith(
                fontSize: ReviewFigmaTokens.bodySize,
                fontWeight: FontWeight.w400,
                height: 1.45,
              ),
            ),
            SizedBox(height: ReviewFigmaTokens.rowGap),
            _DetailRow(
              icon: Iconsax.calendar_1,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      trip.dateRange,
                      style: _detailTextStyle(context),
                    ),
                  ),
                  Text(
                    trip.duration,
                    style: _detailMutedStyle(context),
                  ),
                ],
              ),
            ),
            _DetailRow(
              icon: Iconsax.people,
              child: Text(trip.participantsSummary, style: _detailTextStyle(context)),
            ),
            _DetailRow(
              icon: Iconsax.location,
              child: RichText(
                text: TextSpan(
                  style: _detailTextStyle(context),
                  children: [
                    TextSpan(text: trip.routeLabel),
                    TextSpan(
                      text: trip.routeHighlight,
                      style: _detailTextStyle(context).copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _DetailRow(
              icon: Iconsax.clock,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(trip.meetingTime, style: _detailTextStyle(context)),
                  SizedBox(height: 2.h),
                  Text(trip.startingTime, style: _detailTextStyle(context)),
                ],
              ),
            ),
            _DetailRow(
              icon: Iconsax.profile_2user,
              child: Text(trip.groupSize, style: _detailTextStyle(context)),
            ),
            _DetailRow(
              icon: Iconsax.location,
              iconColor: AppColors.primary,
              child: Text(
                trip.location,
                style: _detailTextStyle(context).copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            IncludedFeaturesSection(
              title: widget.includedTitle,
              features: trip.includedFeatures,
            ),
          ],
        ],
      ),
    );
  }

  TextStyle _detailTextStyle(BuildContext context) {
    return AppTextStyles.bodyMedium(
      color: AppColors.tripDetailsFigmaBlack,
    ).copyWith(
      fontSize: ReviewFigmaTokens.bodySize,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle _detailMutedStyle(BuildContext context) {
    return AppTextStyles.bodyMedium(
      color: ReviewFigmaTokens.metaGrey,
    ).copyWith(
      fontSize: ReviewFigmaTokens.bodySize,
      fontWeight: FontWeight.w400,
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.child,
    this.iconColor,
  });

  final IconData icon;
  final Widget child;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: ReviewFigmaTokens.rowGap),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18.sp,
            color: iconColor ?? ReviewFigmaTokens.metaGrey,
          ),
          SizedBox(width: 10.w),
          Expanded(child: child),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';
import '../models/trip_card_model.dart';
import 'company_trip_card.dart';
import 'profile_section_title.dart';

class AvailableTripsSection extends StatefulWidget {
  const AvailableTripsSection({
    super.key,
    required this.trips,
    this.onFavoriteTap,
    this.onTripTap,
  });

  final List<TripCardModel> trips;
  final void Function(int tripId)? onFavoriteTap;
  final void Function(int tripId)? onTripTap;

  @override
  State<AvailableTripsSection> createState() => _AvailableTripsSectionState();
}

class _AvailableTripsSectionState extends State<AvailableTripsSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final trips = widget.trips;
    if (trips.isEmpty) {
      return const SizedBox.shrink();
    }

    final visibleTrips = _isExpanded ? trips : trips.take(1).toList();
    final toggleText = trips.length > 1
        ? (_isExpanded
            ? context.tr.companyProfileShowLess
            : context.tr.companyProfileSeeAllTrips)
        : null;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: CompanyProfileFigmaTokens.screenPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileSectionTitle(title: context.tr.companyProfileAvailableTrips),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: visibleTrips
                  .map(
                    (trip) => CompanyTripCard(
                      trip: trip,
                      onFavoriteTap: widget.onFavoriteTap != null
                          ? () => widget.onFavoriteTap!(trip.id)
                          : null,
                      onTap: widget.onTripTap != null
                          ? () => widget.onTripTap!(trip.id)
                          : null,
                    ),
                  )
                  .toList(),
            ),
          ),
          if (toggleText != null) ...[
            SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => setState(() => _isExpanded = !_isExpanded),
                child: Text(
                  toggleText,
                  style: AppTextStyles.bodyMedium(color: AppColors.primary)
                      .copyWith(
                        fontSize: CompanyProfileFigmaTokens.bodyMediumFontSize,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
            SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
          ],
        ],
      ),
    );
  }
}

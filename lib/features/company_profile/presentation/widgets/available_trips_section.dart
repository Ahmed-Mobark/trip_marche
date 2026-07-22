import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';
import '../models/trip_card_model.dart';
import 'company_trip_card.dart';
import 'profile_section_title.dart';

class AvailableTripsSection extends StatelessWidget {
  const AvailableTripsSection({super.key, required this.trips});

  final List<TripCardModel> trips;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: CompanyProfileFigmaTokens.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileSectionTitle(title: context.tr.companyProfileAvailableTrips),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
          ...trips.map((trip) => CompanyTripCard(trip: trip)),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {},
              child: Text(
                context.tr.companyProfileSeeAllTrips,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.primary,
                ).copyWith(fontSize: CompanyProfileFigmaTokens.bodyMediumFontSize, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';
import 'company_trip_card.dart';

class AvailableTripsSection extends StatelessWidget {
  const AvailableTripsSection({super.key, required this.trips});

  final List<CompanyTripCardData> trips;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: CompanyProfileFigmaTokens.screenPadding),
      decoration: BoxDecoration(
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(CompanyProfileFigmaTokens.cardRadius),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(CompanyProfileFigmaTokens.screenPaddingSmall, CompanyProfileFigmaTokens.cardPadding, CompanyProfileFigmaTokens.screenPaddingSmall, 0),
            child: Text(
              context.tr.companyProfileAvailableTrips,
              style: AppTextStyles.heading3(
                color: AppColors.darkText(context),
              ).copyWith(fontSize: CompanyProfileFigmaTokens.titleFontSize, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: trips.length,
            separatorBuilder: (_, __) => SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
            itemBuilder: (context, index) {
              final trip = trips[index];
              return CompanyTripCard(trip: trip);
            },
          ),
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

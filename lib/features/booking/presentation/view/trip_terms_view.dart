import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';

class TripTermsView extends StatelessWidget {
  const TripTermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          context.tr.bookingTripTermsTitle,
          style: AppTextStyles.subtitle(color: AppColors.darkText),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.tr.bookingTripTermsHeader, style: AppTextStyles.heading3()),
            const SizedBox(height: 8),
            Text(
              context.tr.bookingTripTermsLastUpdated('January 2026'),
              style: AppTextStyles.bodySmall(color: AppColors.greyText),
            ),
            const SizedBox(height: 20),
            _buildSection(
              context.tr.bookingTripTermsSection1Title,
              context.tr.bookingTripTermsSection1Body,
            ),
            _buildSection(
              context.tr.bookingTripTermsSection2Title,
              context.tr.bookingTripTermsSection2Body,
            ),
            _buildSection(
              context.tr.bookingTripTermsSection3Title,
              context.tr.bookingTripTermsSection3Body,
            ),
            _buildSection(
              context.tr.bookingTripTermsSection4Title,
              context.tr.bookingTripTermsSection4Body,
            ),
            _buildSection(
              context.tr.bookingTripTermsSection5Title,
              context.tr.bookingTripTermsSection5Body,
            ),
            _buildSection(
              context.tr.bookingTripTermsSection6Title,
              context.tr.bookingTripTermsSection6Body,
            ),
            _buildSection(
              context.tr.bookingTripTermsSection7Title,
              context.tr.bookingTripTermsSection7Body,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.subtitle(color: AppColors.darkText)),
          const SizedBox(height: 8),
          Text(content, style: AppTextStyles.body()),
        ],
      ),
    );
  }
}

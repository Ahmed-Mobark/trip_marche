import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';

class TripSafetyView extends StatelessWidget {
  const TripSafetyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          context.tr.bookingTripSafetyTitle,
          style: AppTextStyles.subtitle(color: AppColors.darkText),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.error.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Iconsax.shield_tick,
                    color: AppColors.error,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      context.tr.bookingTripSafetyBanner,
                      style: AppTextStyles.bodySmall(
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              context.tr.bookingTripSafetyHeader,
              style: AppTextStyles.heading3(),
            ),
            const SizedBox(height: 12),
            Text(
              context.tr.bookingTripSafetyIntro,
              style: AppTextStyles.body(),
            ),
            const SizedBox(height: 24),
            _buildSafetySection(
              title: context.tr.bookingTripSafetyWaterTitle,
              content:
                  'All water activities are supervised by certified instructors and lifeguards. Life jackets are mandatory for all boat trips and snorkeling excursions. '
                  'Participants must follow the buddy system at all times during water activities. '
                  'Anyone with pre-existing medical conditions must inform the instructor before participating.',
            ),
            const SizedBox(height: 16),
            _buildSafetySection(
              title: context.tr.bookingTripSafetyDesertTitle,
              content:
                  'Desert excursions are conducted with experienced local guides who know the terrain. All vehicles are equipped with GPS, '
                  'first aid kits, and sufficient water supply. Travelers must carry at least 2 liters of water per person. '
                  'Sun protection is essential; hats, sunglasses, and sunscreen are mandatory.',
            ),
            const SizedBox(height: 16),
            _buildSafetySection(
              title: context.tr.bookingTripSafetyHealthTitle,
              content:
                  'A first aid kit is available at all times during the trip. Our guides are trained in basic first aid and CPR. '
                  'The nearest hospital is approximately 20 minutes from the hotel. Travel insurance with medical evacuation coverage is strongly recommended. '
                  'Please inform us of any allergies, medications, or medical conditions before the trip.',
            ),
            const SizedBox(height: 16),
            _buildSafetySection(
              title: context.tr.bookingTripSafetyEmergencyTitle,
              content:
                  'Trip Coordinator: +20 100 123 4567 (available 24/7)\n'
                  'Local Emergency Services: 123\n'
                  'Tourist Police: 126\n'
                  'Nearest Hospital: Dahab General Hospital - +20 69 364 0301\n\n'
                  'In case of emergency, contact your trip coordinator immediately. '
                  'All emergency numbers are also provided in the welcome pack you receive on Day 1.',
            ),
            const SizedBox(height: 16),
            _buildSafetySection(
              title: context.tr.bookingTripSafetyGeneralTipsTitle,
              content:
                  'Always stay with the group during organized activities. Do not wander off alone, especially at night. '
                  'Keep your personal belongings secure and use the hotel safe for valuables. '
                  'Drink only bottled water and be cautious with street food. '
                  'Respect local laws and customs to avoid any issues during your stay.',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetySection({required String title, required String content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.subtitle(color: AppColors.darkText)),
          const SizedBox(height: 10),
          Text(content, style: AppTextStyles.body()),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/instruction_section.dart';
import '../../../../core/extensions/localization.dart';

class TripInstructionsView extends StatelessWidget {
  const TripInstructionsView({super.key});

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
          context.tr.bookingTripInstructionsTitle,
          style: AppTextStyles.subtitle(color: AppColors.darkText),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.tr.bookingTripInstructionsHeader, style: AppTextStyles.heading3()),
            const SizedBox(height: 12),
            Text(
              context.tr.bookingTripInstructionsIntro,
              style: AppTextStyles.body(),
            ),
            const SizedBox(height: 24),
            const InstructionSection(
              icon: Iconsax.bag_2,
              title: 'What to Pack',
              items: [
                'Lightweight, breathable clothing suitable for warm weather',
                'Comfortable walking shoes and sandals',
                'Swimwear and beach towel',
                'Sunscreen with high SPF, sunglasses, and a hat',
                'Light jacket or sweater for cooler evenings',
                'Personal medications and basic first aid kit',
                'Reusable water bottle to stay hydrated',
              ],
            ),
            const SizedBox(height: 20),
            const InstructionSection(
              icon: Iconsax.clock,
              title: 'Meeting Point & Time',
              items: [
                'Meeting point: Cairo International Airport, Terminal 2, Gate B',
                'Meeting time: 6:00 AM on Day 1 of the trip',
                'Please arrive at least 30 minutes before the scheduled departure',
                'Look for our staff member holding a Trip Marche sign',
                'Contact our trip coordinator if you are running late',
              ],
            ),
            const SizedBox(height: 20),
            const InstructionSection(
              icon: Iconsax.document,
              title: 'Documents to Bring',
              items: [
                'Valid passport or national ID card',
                'Printed or digital copy of your booking confirmation',
                'Travel insurance documents',
                'Emergency contact information',
                'Any required medical prescriptions',
              ],
            ),
            const SizedBox(height: 20),
            const InstructionSection(
              icon: Iconsax.warning_2,
              title: 'Important Reminders',
              items: [
                'Inform us of any dietary restrictions or allergies at least 48 hours before departure',
                'Keep your valuables secure and do not leave them unattended',
                'Respect local customs and dress modestly when visiting religious sites',
                'Stay hydrated and apply sunscreen regularly',
                'Follow the instructions of your tour guide at all times',
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

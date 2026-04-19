import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

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
        title: Text('Terms & Conditions', style: AppTextStyles.subtitle(color: AppColors.darkText)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trip Terms & Conditions', style: AppTextStyles.heading3()),
            const SizedBox(height: 8),
            Text(
              'Last updated: January 2026',
              style: AppTextStyles.bodySmall(color: AppColors.greyText),
            ),
            const SizedBox(height: 20),
            _buildSection(
              '1. Booking & Payment',
              'By booking a trip through Trip Marche, you agree to the following terms. A deposit of 30% is required at the time of booking to secure your place. '
              'The remaining balance must be paid at least 14 days before the trip departure date. '
              'Failure to pay the remaining balance by the due date may result in cancellation of your booking. '
              'All payments are processed securely through our payment partners.',
            ),
            _buildSection(
              '2. Eligibility',
              'Participants must be at least 18 years of age to book independently. Travelers under 18 must be accompanied by a parent or legal guardian. '
              'Certain activities may have additional age or health requirements. '
              'It is the responsibility of the traveler to ensure they meet all eligibility criteria and have the necessary travel documents.',
            ),
            _buildSection(
              '3. Trip Modifications',
              'Trip Marche reserves the right to modify the trip itinerary due to weather conditions, safety concerns, or other unforeseen circumstances. '
              'We will make every effort to provide equivalent alternatives. '
              'In the event of significant changes, travelers will be notified as soon as possible and may be offered a partial refund or credit.',
            ),
            _buildSection(
              '4. Traveler Responsibilities',
              'Travelers are responsible for ensuring they have valid travel documents, appropriate travel insurance, and any required vaccinations. '
              'Travelers must follow the instructions of trip guides and respect local laws and customs. '
              'Trip Marche is not liable for any consequences resulting from a traveler\'s failure to comply with entry requirements.',
            ),
            _buildSection(
              '5. Liability',
              'Trip Marche acts as an organizer and intermediary. While we take every precaution to ensure safety, '
              'we are not liable for any loss, injury, or damage arising from activities during the trip, acts of nature, '
              'or the actions of third-party service providers. Travelers participate in all activities at their own risk. '
              'We strongly recommend purchasing comprehensive travel insurance.',
            ),
            _buildSection(
              '6. Privacy',
              'Personal information collected during the booking process is used solely for trip organization and communication purposes. '
              'We do not share your information with third parties except as necessary to fulfill your booking. '
              'For more details, please refer to our Privacy Policy.',
            ),
            _buildSection(
              '7. Dispute Resolution',
              'Any disputes arising from these terms shall be resolved through amicable negotiation. '
              'If a resolution cannot be reached, disputes shall be submitted to the competent courts. '
              'These terms are governed by the laws of the Arab Republic of Egypt.',
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

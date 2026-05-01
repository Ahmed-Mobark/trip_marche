import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/policy_card.dart';

class TripCancellationView extends StatelessWidget {
  const TripCancellationView({super.key});

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
          'Cancellation Policy',
          style: AppTextStyles.subtitle(color: AppColors.darkText),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cancellation Policy', style: AppTextStyles.heading3()),
            const SizedBox(height: 12),
            Text(
              'We understand that plans can change. Please review our cancellation policy below to understand the terms '
              'and any applicable fees for cancelling your trip booking.',
              style: AppTextStyles.body(),
            ),
            const SizedBox(height: 24),
            const PolicyCard(
              title: 'Free Cancellation',
              subtitle: 'More than 30 days before departure',
              description:
                  'Full refund of the total amount paid, including the deposit. '
                  'The refund will be processed within 5-7 business days to the original payment method.',
              color: AppColors.success,
              icon: Iconsax.tick_circle,
            ),
            const SizedBox(height: 12),
            PolicyCard(
              title: '50% Refund',
              subtitle: '15 to 30 days before departure',
              description:
                  '50% of the total booking amount will be refunded. '
                  'The remaining 50% will be retained as a cancellation fee to cover pre-arranged services.',
              color: AppColors.accent,
              icon: Iconsax.warning_2,
            ),
            const SizedBox(height: 12),
            const PolicyCard(
              title: '25% Refund',
              subtitle: '7 to 14 days before departure',
              description:
                  '25% of the total booking amount will be refunded. '
                  'This reduced refund accounts for non-recoverable costs already committed for your trip.',
              color: AppColors.warning,
              icon: Iconsax.info_circle,
            ),
            const SizedBox(height: 12),
            PolicyCard(
              title: 'No Refund',
              subtitle: 'Less than 7 days before departure',
              description:
                  'No refund will be issued for cancellations made less than 7 days before the departure date. '
                  'At this point, all arrangements have been finalized and costs are non-recoverable.',
              color: AppColors.error,
              icon: Iconsax.close_circle,
            ),
            const SizedBox(height: 24),
            Text(
              'Additional Information',
              style: AppTextStyles.subtitle(color: AppColors.darkText),
            ),
            const SizedBox(height: 12),
            Text(
              'All cancellation requests must be submitted in writing through the Trip Marche app or by emailing support@tripmarche.com. '
              'The cancellation date is determined by the date we receive your written request.\n\n'
              'In case of trip cancellation by Trip Marche due to insufficient participants or unforeseen circumstances, '
              'a full refund will be issued or travelers may choose to reschedule to an alternative date at no extra cost.\n\n'
              'We strongly recommend purchasing travel insurance that covers trip cancellation to protect your investment. '
              'Trip Marche is not responsible for any additional costs incurred due to cancellation, '
              'including but not limited to flight tickets, other accommodations, or visa fees.',
              style: AppTextStyles.body(),
            ),
            const SizedBox(height: 24),
            Text(
              'How to Cancel',
              style: AppTextStyles.subtitle(color: AppColors.darkText),
            ),
            const SizedBox(height: 12),
            _buildStep('1', 'Go to "My Bookings" in the app'),
            _buildStep('2', 'Select the trip you wish to cancel'),
            _buildStep('3', 'Tap "Cancel Booking" and confirm'),
            _buildStep(
              '4',
              'You will receive a confirmation email with refund details',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: AppTextStyles.bodyMedium(color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: AppTextStyles.body())),
        ],
      ),
    );
  }
}

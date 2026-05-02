import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CancellationPolicyView extends StatelessWidget {
  const CancellationPolicyView({super.key});

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
        title: Text('Cancellation Policy', style: AppTextStyles.subtitle()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              'Cancellation Policy',
              'We understand that plans can change. Below is our cancellation policy to help you understand the process and any applicable fees.',
            ),
            _buildSection(
              context,
              'Free Cancellation',
              'Cancellations made more than 7 days before the trip departure date are eligible for a full refund. No cancellation fee will be charged.',
            ),
            _buildSection(
              context,
              'Partial Refund',
              'Cancellations made between 3 to 7 days before the trip departure date will receive a 50% refund of the total booking amount.',
            ),
            _buildSection(
              context,
              'No Refund',
              'Cancellations made less than 3 days before the trip departure date are not eligible for a refund. The full booking amount will be retained.',
            ),
            _buildSection(
              context,
              'How to Cancel',
              'To cancel your booking, go to My Trips, select the trip you wish to cancel, and tap "Cancel Booking." You will receive a confirmation email once the cancellation is processed.',
            ),
            _buildSection(
              context,
              'Refund Processing',
              'Refunds are processed within 5-10 business days after the cancellation is confirmed. The refund will be credited to the original payment method used during booking.',
            ),
            _buildSection(
              context,
              'Exceptions',
              'In case of extraordinary circumstances such as natural disasters, severe weather, or government travel restrictions, Trip Marche may offer full refunds or trip credits at its discretion.',
            ),
            _buildSection(
              context,
              'Trip Provider Cancellations',
              'If a trip is cancelled by the provider, you will receive a full refund or the option to rebook a similar trip at no additional cost.',
            ),
            const SizedBox(height: 16),
            Text(
              'Last updated: April 2026',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.greyText,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.secondaryText,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

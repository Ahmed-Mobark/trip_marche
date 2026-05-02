import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class VisaDetailsView extends StatelessWidget {
  const VisaDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Visa Details',
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
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Iconsax.info_circle,
                    color: AppColors.accent,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Please ensure your travel documents are up to date before the trip.',
                      style: AppTextStyles.bodySmall(
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('Visa Requirements', style: AppTextStyles.heading3()),
            const SizedBox(height: 12),
            Text(
              'For travel to the Sinai Peninsula, including Dahab, most nationalities can obtain a visa on arrival at the Egyptian border. '
              'The Sinai-only visa is free of charge and valid for 15 days, restricting travel to the Sinai Peninsula area only.',
              style: AppTextStyles.body(),
            ),
            const SizedBox(height: 20),
            Text(
              'Required Documents',
              style: AppTextStyles.subtitle(color: AppColors.darkText),
            ),
            const SizedBox(height: 12),
            _buildRequirement(
              'Valid passport with at least 6 months validity from the date of entry',
            ),
            _buildRequirement(
              'Two recent passport-sized photographs with white background',
            ),
            _buildRequirement('Return flight ticket or proof of onward travel'),
            _buildRequirement(
              'Hotel reservation confirmation or proof of accommodation',
            ),
            _buildRequirement(
              'Proof of sufficient funds for the duration of your stay',
            ),
            const SizedBox(height: 20),
            Text(
              'Important Notes',
              style: AppTextStyles.subtitle(color: AppColors.darkText),
            ),
            const SizedBox(height: 12),
            Text(
              'If you plan to travel beyond the Sinai Peninsula to other parts of Egypt such as Cairo or Luxor, '
              'you will need a full Egyptian tourist visa. This can be obtained on arrival at the airport for a fee of approximately 25 USD. '
              'Some nationalities may require a pre-arranged visa from the Egyptian embassy in their home country.\n\n'
              'We recommend checking with your local Egyptian embassy or consulate for the most up-to-date visa requirements '
              'specific to your nationality. Our travel team is also available to assist you with any visa-related queries.',
              style: AppTextStyles.body(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: AppTextStyles.body())),
        ],
      ),
    );
  }
}

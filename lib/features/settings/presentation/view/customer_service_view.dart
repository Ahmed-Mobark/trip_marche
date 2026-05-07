import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CustomerServiceView extends StatelessWidget {
  const CustomerServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        backgroundColor: AppColors.background(context),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.darkText(context)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Customer Service', style: AppTextStyles.subtitle()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            _buildContactOption(
              context,
              icon: Iconsax.call,
              title: 'Phone',
              subtitle: '+20 123 456 7890',
              actionText: 'Call',
              onAction: () {
                // Launch phone dialer
              },
            ),
            const SizedBox(height: 12),
            _buildContactOption(
              context,
              icon: Iconsax.sms,
              title: 'Email',
              subtitle: 'support@tripmarche.com',
              actionText: 'Send',
              onAction: () {
                // Launch email client
              },
            ),
            const SizedBox(height: 12),
            _buildContactOption(
              context,
              icon: Iconsax.message,
              title: 'WhatsApp',
              subtitle: '+20 123 456 7890',
              actionText: 'Chat',
              onAction: () {
                // Launch WhatsApp
              },
            ),
            const SizedBox(height: 12),
            _buildContactOption(
              context,
              icon: Iconsax.messages_1,
              title: 'Live Chat',
              subtitle: 'Available 24/7',
              actionText: 'Start',
              onAction: () {
                // Open live chat
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionText,
    required VoidCallback onAction,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText(context),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyText(context),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onAction,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                actionText,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onImage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

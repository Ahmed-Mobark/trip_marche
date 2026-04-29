import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

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
          'Terms and condition',
          style: AppTextStyles.subtitle(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Terms of Service',
              'Welcome to Trip Marche. By accessing or using our application, you agree to be bound by these Terms of Service. Please read them carefully before using the app.',
            ),
            _buildSection(
              '1. Acceptance of Terms',
              'By creating an account or using any part of the Trip Marche application, you acknowledge that you have read, understood, and agree to be bound by these terms. If you do not agree to these terms, please do not use the application.',
            ),
            _buildSection(
              '2. User Accounts',
              'You must create an account to use certain features of the app. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You must be at least 18 years old to create an account.',
            ),
            _buildSection(
              '3. Booking and Payments',
              'All bookings are subject to availability and confirmation. Prices displayed are per person unless otherwise stated. Payment must be completed at the time of booking. We reserve the right to cancel any booking if payment cannot be processed.',
            ),
            _buildSection(
              '4. Cancellation Policy',
              'Cancellation policies vary by trip and are clearly stated on each trip listing. Refunds will be processed according to the applicable cancellation policy. Processing times for refunds may vary depending on your payment method.',
            ),
            _buildSection(
              '5. User Conduct',
              'You agree to use the application in a lawful manner and not to engage in any activity that could harm the application, other users, or third parties. Abusive, harassing, or fraudulent behavior will result in account termination.',
            ),
            _buildSection(
              '6. Privacy',
              'Your privacy is important to us. Our Privacy Policy explains how we collect, use, and protect your personal information. By using the app, you consent to our data practices as described in the Privacy Policy.',
            ),
            _buildSection(
              '7. Limitation of Liability',
              'Trip Marche acts as an intermediary between travelers and trip providers. We are not liable for any injuries, losses, or damages that occur during trips. Travel insurance is recommended for all bookings.',
            ),
            _buildSection(
              '8. Changes to Terms',
              'We reserve the right to modify these terms at any time. Changes will be effective immediately upon posting. Your continued use of the application after changes constitutes acceptance of the new terms.',
            ),
            const SizedBox(height: 16),
            Text(
              'Last updated: April 2026',
              style: GoogleFonts.inter(
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

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.inter(
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

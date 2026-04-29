import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class FaqsView extends StatelessWidget {
  const FaqsView({super.key});

  static const List<Map<String, String>> _faqs = [
    {
      'question': 'How do I book a trip?',
      'answer':
          'To book a trip, browse our available trips, select the one you like, choose your preferred date and number of travelers, then proceed to payment. You will receive a confirmation email once your booking is complete.',
    },
    {
      'question': 'Can I cancel my booking?',
      'answer':
          'Yes, you can cancel your booking. Cancellation policies vary depending on the trip and how far in advance you cancel. Please refer to the cancellation policy for specific details.',
    },
    {
      'question': 'What payment methods are accepted?',
      'answer':
          'We accept credit cards (Visa, MasterCard), debit cards, and mobile wallets. All payments are processed securely through our payment gateway.',
    },
    {
      'question': 'How do I contact customer support?',
      'answer':
          'You can reach our customer support team through phone, email, WhatsApp, or live chat. Visit the Customer Service section in the app for detailed contact information.',
    },
    {
      'question': 'Can I modify my booking after confirmation?',
      'answer':
          'Modifications to confirmed bookings are subject to availability and may incur additional charges. Please contact our support team as soon as possible if you need to make changes.',
    },
    {
      'question': 'Are meals included in the trip?',
      'answer':
          'Meal inclusions vary by trip. Each trip listing clearly states what is included. Check the trip details page for specific information about meals and other inclusions.',
    },
    {
      'question': 'Is travel insurance included?',
      'answer':
          'Basic travel insurance is included with most trips. For additional coverage, we recommend purchasing supplementary travel insurance. Details are provided during the booking process.',
    },
  ];

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
          'FAQs',
          style: AppTextStyles.subtitle(),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: _faqs.length,
        itemBuilder: (context, index) {
          final faq = _faqs[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  childrenPadding:
                      const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  title: Text(
                    faq['question']!,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkText,
                    ),
                  ),
                  iconColor: AppColors.primary,
                  collapsedIconColor: AppColors.greyText,
                  children: [
                    Text(
                      faq['answer']!,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryText,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/trip_summary_card.dart';
import '../widgets/info_row.dart';
import '../widgets/price_breakdown.dart';

class ReviewView extends StatefulWidget {
  const ReviewView({super.key});

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  final _couponController = TextEditingController();
  bool _couponApplied = false;

  final double _basePrice = 699.0;
  final double _activitiesPrice = 130.0;
  final double _discount = 50.0;

  double get _totalPrice => _basePrice + _activitiesPrice - (_couponApplied ? _discount : 0);

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

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
        title: Text('Review', style: AppTextStyles.bodyMedium(color: AppColors.darkText)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TripSummaryCard(
              title: 'Dahab Trip',
              subtitle: '7 Days | Jan 15 - Jan 21, 2026',
              ratingRow: Row(
                children: [
                  const Icon(Iconsax.star1, color: AppColors.primary, size: 14),
                  const SizedBox(width: 4),
                  Text('4.9 (112)', style: AppTextStyles.bodyMedium()),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionCard(
              title: 'Traveler Details',
              children: const [
                InfoRow(label: 'Full Name', value: 'Ahmed Hassan'),
                InfoRow(label: 'Phone', value: '+20 123 456 7890'),
                InfoRow(label: 'Email', value: 'ahmed@example.com'),
                InfoRow(label: 'Emergency Contact', value: '+20 111 222 3333'),
                InfoRow(label: 'ID/Passport', value: 'A12345678'),
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionCard(
              title: 'Selected Options',
              children: const [
                InfoRow(label: 'Room Type', value: 'Double Room'),
                InfoRow(label: 'Bus Seat', value: 'Middle'),
                InfoRow(label: 'Travelers', value: '1'),
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionCard(
              title: 'Activities',
              children: const [
                InfoRow(label: 'Snorkeling', value: '+\$50'),
                InfoRow(label: 'Desert Safari', value: '+\$80'),
              ],
            ),
            const SizedBox(height: 20),
            _buildCouponSection(),
            const SizedBox(height: 20),
            PriceBreakdown(
              items: [
                PriceBreakdownItem(label: 'Base Price', value: '\$${_basePrice.toStringAsFixed(0)}'),
                PriceBreakdownItem(label: 'Activities', value: '+\$${_activitiesPrice.toStringAsFixed(0)}'),
                if (_couponApplied)
                  PriceBreakdownItem(label: 'Discount', value: '-\$${_discount.toStringAsFixed(0)}', isDiscount: true),
              ],
              totalLabel: 'Total',
              totalValue: '\$${_totalPrice.toStringAsFixed(0)}',
            ),
            const SizedBox(height: 24),
            _buildProceedButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
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
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildCouponSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Coupon Code', style: AppTextStyles.subtitle(color: AppColors.darkText)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _couponController,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkText,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter coupon code',
                  hintStyle: GoogleFonts.inter(fontSize: 14, color: AppColors.greyText),
                  filled: true,
                  fillColor: AppColors.lightBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                if (_couponController.text.isNotEmpty) {
                  setState(() => _couponApplied = true);
                }
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text('Apply', style: AppTextStyles.button()),
                ),
              ),
            ),
          ],
        ),
        if (_couponApplied)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                const Icon(Iconsax.tick_circle, color: Colors.green, size: 16),
                const SizedBox(width: 6),
                Text(
                  'Coupon applied! -\$${_discount.toStringAsFixed(0)}',
                  style: AppTextStyles.bodySmall(color: Colors.green),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildProceedButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text('Proceed to Payment', style: AppTextStyles.button()),
        ),
      ),
    );
  }
}

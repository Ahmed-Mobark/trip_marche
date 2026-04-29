import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class PriceBreakdownItem {
  final String label;
  final String value;
  final bool isDiscount;

  const PriceBreakdownItem({
    required this.label,
    required this.value,
    this.isDiscount = false,
  });
}

class PriceBreakdown extends StatelessWidget {
  const PriceBreakdown({
    super.key,
    required this.items,
    required this.totalLabel,
    required this.totalValue,
  });

  final List<PriceBreakdownItem> items;
  final String totalLabel;
  final String totalValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          ...items.map((item) => _buildPriceRow(item.label, item.value, isDiscount: item.isDiscount)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Divider(color: AppColors.border),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(totalLabel, style: AppTextStyles.subtitle(color: AppColors.darkText)),
              Text(
                totalValue,
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.body(color: AppColors.greyText)),
          Text(
            value,
            style: AppTextStyles.bodyMedium(
              color: isDiscount ? Colors.green : AppColors.darkText,
            ),
          ),
        ],
      ),
    );
  }
}

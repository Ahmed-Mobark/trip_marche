import 'package:flutter/material.dart';
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
          ...items.map(
            (item) => _buildPriceRow(
              context,
              item.label,
              item.value,
              isDiscount: item.isDiscount,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Divider(color: AppColors.border(context)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                totalLabel,
                style: AppTextStyles.subtitle(color: AppColors.darkText(context)),
              ),
              Text(
                totalValue,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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

  Widget _buildPriceRow(
    BuildContext context,
    String label,
    String value, {
    bool isDiscount = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.body(color: AppColors.greyText(context))),
          Text(
            value,
            style: AppTextStyles.bodyMedium(
              color: isDiscount ? AppColors.success : AppColors.darkText(context),
            ),
          ),
        ],
      ),
    );
  }
}

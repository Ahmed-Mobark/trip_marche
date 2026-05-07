import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.labelColor,
    this.valueColor,
    this.bottomPadding = 8,
  });

  final String label;
  final String value;
  final Color? labelColor;
  final Color? valueColor;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall(
              color: labelColor ?? AppColors.greyText(context),
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium(
              color: valueColor ?? AppColors.darkText(context),
            ),
          ),
        ],
      ),
    );
  }
}

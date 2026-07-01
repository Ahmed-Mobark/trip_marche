import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/review_figma_tokens.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

class PriceRow extends StatelessWidget {
  const PriceRow({
    super.key,
    required this.label,
    required this.value,
    this.isDiscount = false,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isDiscount;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    final labelStyle = isTotal
        ? AppTextStyles.subtitle(
            color: AppColors.tripDetailsFigmaBlack,
          ).copyWith(fontSize: ReviewFigmaTokens.bodySize, fontWeight: FontWeight.w600)
        : AppTextStyles.bodyMedium(
            color: ReviewFigmaTokens.metaGrey,
          ).copyWith(fontSize: ReviewFigmaTokens.bodySize, fontWeight: FontWeight.w400);

    final valueStyle = isTotal
        ? AppTextStyles.subtitle(
            color: AppColors.tripDetailsFigmaBlack,
          ).copyWith(fontSize: ReviewFigmaTokens.bodySize, fontWeight: FontWeight.w700)
        : AppTextStyles.bodyMedium(
            color: isDiscount
                ? ReviewFigmaTokens.successGreen
                : AppColors.tripDetailsFigmaBlack,
          ).copyWith(
            fontSize: ReviewFigmaTokens.bodySize,
            fontWeight: FontWeight.w500,
          );

    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: isTotal ? 0 : 10.h),
      child: Row(
        children: [
          Expanded(child: Text(label, style: labelStyle)),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}

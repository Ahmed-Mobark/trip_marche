import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/review_figma_tokens.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_review_data.dart';
import 'price_row.dart';

class PaymentDetailsCard extends StatelessWidget {
  const PaymentDetailsCard({
    super.key,
    required this.title,
    required this.breakdown,
    required this.travelersLabel,
    required this.activitiesLabel,
    required this.taxesLabel,
    required this.totalLabel,
    required this.currencySuffix,
    this.subtotalLabel,
    this.finalTotalLabel,
    this.couponRowLabel,
    this.showCouponBreakdown = false,
  });

  final String title;
  final BookingPriceBreakdown breakdown;
  final String travelersLabel;
  final String activitiesLabel;
  final String taxesLabel;
  final String totalLabel;
  final String currencySuffix;
  final String? subtotalLabel;
  final String? finalTotalLabel;
  final String? couponRowLabel;
  final bool showCouponBreakdown;

  String _format(double value, {bool forceNegative = false}) {
    final abs = value.abs();
    final formatted = abs == abs.roundToDouble()
        ? abs.toStringAsFixed(0)
        : abs.toStringAsFixed(2);
    if (forceNegative || value < 0) {
      return '-$formatted $currencySuffix';
    }
    return '$formatted $currencySuffix';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: AppTextStyles.subtitle(
            color: AppColors.ink(context),
          ).copyWith(
            fontSize: ReviewFigmaTokens.bodySize,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        PriceRow(
          label: travelersLabel,
          value: _format(breakdown.travelersTotal),
        ),
        PriceRow(
          label: breakdown.roomLabel,
          value: _format(breakdown.roomTotal),
        ),
        PriceRow(
          label: activitiesLabel,
          value: _format(breakdown.activitiesTotal),
        ),
        PriceRow(
          label: taxesLabel,
          value: _format(breakdown.taxes),
        ),
        if (showCouponBreakdown && breakdown.couponDiscount > 0) ...[
          PriceRow(
            label: subtotalLabel ?? totalLabel,
            value: _format(breakdown.subtotal),
          ),
          PriceRow(
            label: couponRowLabel ?? '',
            value: _format(breakdown.couponDiscount, forceNegative: true),
            isDiscount: true,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 4.h),
            child: PriceRow(
              label: finalTotalLabel ?? totalLabel,
              value: _format(breakdown.total),
              isTotal: true,
            ),
          ),
        ] else
          Padding(
            padding: EdgeInsetsDirectional.only(top: 4.h),
            child: PriceRow(
              label: totalLabel,
              value: _format(breakdown.total),
              isTotal: true,
            ),
          ),
      ],
    );
  }
}

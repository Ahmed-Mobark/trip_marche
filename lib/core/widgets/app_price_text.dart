import 'package:flutter/material.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/utils/price_formatter.dart';

class AppPriceText extends StatelessWidget {
  const AppPriceText({
    super.key,
    required this.value,
    required this.currency,
    required this.style,
  });

  final num value;
  final String currency;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final amount = PriceFormatter.format(value, currency: '').trimRight();

    return Text.rich(
      TextSpan(
        style: style.copyWith(color: AppColors.primary),
        children: [
          TextSpan(text: amount),
          TextSpan(
            text: ' $currency',
            style: style.copyWith(
              fontSize: (style.fontSize ?? 14) * 0.8,
              color: AppColors.primaryGradient.colors.last,
            ),
          ),
        ],
      ),
    );
  }
}

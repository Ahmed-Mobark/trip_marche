import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';

class CardPreview extends StatelessWidget {
  const CardPreview({
    super.key,
    required this.maskedCardNumber,
    required this.cardholderName,
    required this.expiry,
    this.brandLabel = 'VISA',
  });

  final String maskedCardNumber;
  final String cardholderName;
  final String expiry;
  final String brandLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.cardPreviewStart, AppColors.cardPreviewEnd],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Iconsax.card,
                color: AppColors.onImage.withValues(alpha: 0.70),
                size: 32,
              ),
              Text(
                brandLabel,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onImage,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          Text(
            maskedCardNumber,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.onImage,
              letterSpacing: 3,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CARDHOLDER',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 10,
                      color: AppColors.onImage.withValues(alpha: 0.54),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    cardholderName,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onImage,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'EXPIRES',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 10,
                      color: AppColors.onImage.withValues(alpha: 0.54),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    expiry,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onImage,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

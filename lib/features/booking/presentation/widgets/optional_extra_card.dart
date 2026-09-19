import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/trip_options_figma_tokens.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/trip_details/presentation/trip_details_ui_formatters.dart';

import 'trip_options_stepper.dart';

class OptionalExtraCard extends StatelessWidget {
  const OptionalExtraCard({
    super.key,
    required this.name,
    required this.totalPrice,
    required this.currency,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  final String name;
  final double totalPrice;
  final String currency;
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: TripOptionsFigmaTokens.travelerCardHPad,
        vertical: TripOptionsFigmaTokens.travelerCardVPad,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBg(context),
        borderRadius: BorderRadius.circular(TripOptionsFigmaTokens.cardRadius),
        border: Border.all(
          color: TripOptionsFigmaTokens.cardBorder(context),
          width: TripOptionsFigmaTokens.cardBorderWidth,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.add_circle,
            size: TripOptionsFigmaTokens.iconSize,
            color: AppColors.primary,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              name,
              style: AppTextStyles.bodyMedium(color: AppColors.ink(context))
                  .copyWith(
                    fontSize: TripOptionsFigmaTokens.cardTitleFontSize,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              TripDetailsUiFormatters.formatAmount(
                totalPrice,
                currency: currency,
              ),
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: AppTextStyles.caption(color: AppColors.primary),
            ),
          ),
          SizedBox(width: 8.w),
          TripOptionsStepper(
            value: quantity,
            canDecrement: quantity > 0,
            canIncrement: true,
            onDecrement: onDecrement,
            onIncrement: onIncrement,
          ),
        ],
      ),
    );
  }
}

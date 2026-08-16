import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/config/dimensions/trip_options_figma_tokens.dart';
import 'trip_options_stepper.dart';

class AccommodationCard extends StatelessWidget {
  const AccommodationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.priceLabel,
    required this.personLabel,
    required this.personCount,
    required this.onIncrement,
    required this.onDecrement,
    required this.canIncrement,
    required this.canDecrement,
  });

  final String title;
  final String subtitle;
  final String priceLabel;
  final String personLabel;
  final int personCount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool canIncrement;
  final bool canDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(
        TripOptionsFigmaTokens.accommodationCardPad,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBg(context),
        borderRadius: BorderRadius.circular(TripOptionsFigmaTokens.cardRadius),
        border: Border.all(
          color: TripOptionsFigmaTokens.cardBorder(context),
          width: TripOptionsFigmaTokens.cardBorderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.ink(context),
                      ).copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: AppTextStyles.caption(
                        color: AppColors.subtitleGrey(context),
                      ).copyWith(fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              Text(
                priceLabel,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.primary,
                ).copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: TripOptionsFigmaTokens.accommodationInnerGap),
          Row(
            children: [
              Expanded(
                child: Text(
                  personLabel,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.ink(context),
                ).copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TripOptionsStepper(
                value: personCount,
                canDecrement: canDecrement,
                canIncrement: canIncrement,
                onDecrement: onDecrement,
                onIncrement: onIncrement,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

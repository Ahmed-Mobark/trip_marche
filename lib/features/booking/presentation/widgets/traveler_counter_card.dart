import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/config/dimensions/trip_options_figma_tokens.dart';
import 'trip_options_stepper.dart';

class TravelerCounterCard extends StatelessWidget {
  const TravelerCounterCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
    this.min = 0,
    this.max = 99,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final int min;
  final int max;

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
          Container(
            width: TripOptionsFigmaTokens.iconBox,
            height: TripOptionsFigmaTokens.iconBox,
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: TripOptionsFigmaTokens.iconSize,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: subtitle == null
                ? Text(
                    title,
                    style: AppTextStyles.bodyMedium(
                      color: AppColors.ink(context),
                    ).copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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
                      SizedBox(height: 2.h),
                      Text(
                        subtitle!,
                        style: AppTextStyles.caption(
                          color: AppColors.subtitleGrey(context),
                        ).copyWith(fontSize: 12.sp),
                      ),
                    ],
                  ),
          ),
          TripOptionsStepper(
            value: count,
            canDecrement: count > min,
            canIncrement: count < max,
            onDecrement: onDecrement,
            onIncrement: onIncrement,
          ),
        ],
      ),
    );
  }
}

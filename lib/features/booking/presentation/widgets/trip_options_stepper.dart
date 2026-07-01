import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/config/dimensions/trip_options_figma_tokens.dart';

class TripOptionsStepper extends StatelessWidget {
  const TripOptionsStepper({
    super.key,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
    this.canDecrement = true,
    this.canIncrement = true,
  });

  final int value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final bool canDecrement;
  final bool canIncrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepperButton(
          icon: Iconsax.minus,
          enabled: canDecrement,
          onTap: onDecrement,
        ),
        SizedBox(width: TripOptionsFigmaTokens.counterGap),
        SizedBox(
          width: TripOptionsFigmaTokens.counterValueWidth,
          child: Text(
            '$value',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium(
              color: AppColors.tripDetailsFigmaBlack,
            ).copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: TripOptionsFigmaTokens.counterGap),
        _StepperButton(
          icon: Iconsax.add,
          enabled: canIncrement,
          onTap: onIncrement,
        ),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = enabled
        ? AppColors.primary
        : TripOptionsFigmaTokens.stepperDisabledBorder;
    final iconColor = enabled
        ? AppColors.primary
        : TripOptionsFigmaTokens.stepperDisabledIcon;
    final fill = enabled
        ? TripOptionsFigmaTokens.stepperEnabledFill
        : AppColors.white;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: TripOptionsFigmaTokens.stepperSize,
        height: TripOptionsFigmaTokens.stepperSize,
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(
            TripOptionsFigmaTokens.stepperRadius,
          ),
          border: Border.all(color: borderColor, width: 1),
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: TripOptionsFigmaTokens.stepperIconSize,
          color: iconColor,
        ),
      ),
    );
  }
}

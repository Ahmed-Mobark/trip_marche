import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/contact_info_figma_tokens.dart';
import 'package:trip_marche/core/config/dimensions/trip_options_figma_tokens.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/widgets/app_back_outlined_button.dart';
import 'package:trip_marche/core/widgets/app_button.dart';

class BottomBookingBar extends StatelessWidget {
  const BottomBookingBar({
    super.key,
    required this.onBack,
    required this.onContinue,
    required this.continueLabel,
    this.backButtonCircular = false,
  });

  final VoidCallback onBack;
  final VoidCallback onContinue;
  final String continueLabel;
  final bool backButtonCircular;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(
        TripOptionsFigmaTokens.bottomBarHPadding,
        TripOptionsFigmaTokens.bottomBarVPadding,
        TripOptionsFigmaTokens.bottomBarHPadding,
        TripOptionsFigmaTokens.bottomBarBottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: TripOptionsFigmaTokens.cardBorder(context),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.06),
            blurRadius: 8.r,
            offset: Offset(0, -2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          AppBackOutlinedButton(
            circular: backButtonCircular,
            onPressed: onBack,
          ),
          SizedBox(
            width: backButtonCircular
                ? ContactInfoFigmaTokens.bottomBarGap
                : TripOptionsFigmaTokens.bottomBarGap,
          ),
          Expanded(
            child: AppButton(
              onTap: onContinue,
              text: continueLabel,
              color: AppColors.primary,
              textColor: AppColors.onImage,
              heigh: TripOptionsFigmaTokens.bottomBarButtonHeight,
              radius: TripOptionsFigmaTokens.bottomBarRadius,
              style: TextStyles.textViewSemiBold14.copyWith(
                color: AppColors.onImage,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

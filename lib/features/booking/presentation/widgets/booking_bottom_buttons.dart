import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/contact_info_figma_tokens.dart';
import 'package:trip_marche/core/config/dimensions/trip_options_figma_tokens.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/widgets/app_back_outlined_button.dart';
import 'package:trip_marche/core/widgets/app_button.dart';

class BookingBottomButtons extends StatelessWidget {
  const BookingBottomButtons({
    super.key,
    required this.onBack,
    required this.onPay,
    required this.payLabel,
    this.isLoading = false,
  });

  final VoidCallback onBack;
  final VoidCallback? onPay;
  final String payLabel;
  final bool isLoading;

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
        color: AppColors.cardBg(context),
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
            circular: true,
            onPressed: onBack,
          ),
          SizedBox(width: ContactInfoFigmaTokens.bottomBarGap),
          Expanded(
            child: AppButton(
              onTap: isLoading ? null : onPay,
              color: AppColors.primary,
              textColor: AppColors.onImage,
              heigh: TripOptionsFigmaTokens.bottomBarButtonHeight,
              radius: TripOptionsFigmaTokens.bottomBarRadius,
              child: isLoading
                  ? SizedBox(
                      width: 22.w,
                      height: 22.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.2,
                        color: AppColors.onImage,
                      ),
                    )
                  : Text(
                      payLabel,
                      style: TextStyles.textViewSemiBold14.copyWith(
                        color: AppColors.onImage,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

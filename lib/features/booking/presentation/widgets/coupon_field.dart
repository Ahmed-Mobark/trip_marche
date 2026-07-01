import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/review_figma_tokens.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

class CouponField extends StatelessWidget {
  const CouponField({
    super.key,
    required this.controller,
    required this.title,
    required this.placeholder,
    required this.applyLabel,
    required this.successMessage,
    required this.onApply,
    required this.showSuccess,
  });

  final TextEditingController controller;
  final String title;
  final String placeholder;
  final String applyLabel;
  final String successMessage;
  final VoidCallback onApply;
  final bool showSuccess;

  static const _transparentInputTheme = InputDecorationTheme(
    filled: false,
    fillColor: Colors.transparent,
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
    contentPadding: EdgeInsets.zero,
    isDense: true,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: AppTextStyles.subtitle(
            color: AppColors.tripDetailsFigmaBlack,
          ).copyWith(
            fontSize: ReviewFigmaTokens.bodySize,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          height: ReviewFigmaTokens.couponFieldHeight,
          padding: EdgeInsetsDirectional.fromSTEB(12.w, 6.h, 6.w, 6.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(ReviewFigmaTokens.couponFieldRadius),
            border: Border.all(color: ReviewFigmaTokens.cardBorder),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Icon(
                  Iconsax.ticket_discount,
                  size: 20.sp,
                  color: ReviewFigmaTokens.metaGrey,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    inputDecorationTheme: _transparentInputTheme,
                  ),
                  child: TextField(
                    controller: controller,
                    cursorColor: AppColors.primary,
                    expands: true,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.center,
                    style: AppTextStyles.bodyMedium(
                      color: AppColors.tripDetailsFigmaBlack,
                    ).copyWith(fontSize: ReviewFigmaTokens.bodySize),
                    decoration: InputDecoration(
                      hintText: placeholder,
                      hintStyle: AppTextStyles.body(
                        color: AppColors.captionText(context),
                      ).copyWith(fontSize: ReviewFigmaTokens.bodySize),
                      filled: false,
                      fillColor: Colors.transparent,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: onApply,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: ReviewFigmaTokens.applyButtonHPadding,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(
                      ReviewFigmaTokens.applyButtonRadius,
                    ),
                  ),
                  child: Text(
                    applyLabel,
                    style: AppTextStyles.button(
                      color: AppColors.onImage,
                    ).copyWith(
                      fontSize: ReviewFigmaTokens.smallSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showSuccess) ...[
          SizedBox(height: 8.h),
          Text(
            successMessage,
            style: AppTextStyles.bodyMedium(
              color: ReviewFigmaTokens.successGreen,
            ).copyWith(
              fontSize: ReviewFigmaTokens.smallSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}

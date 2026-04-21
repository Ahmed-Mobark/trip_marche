import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/app_button.dart';

class TripDetailsBookingBar extends StatelessWidget {
  const TripDetailsBookingBar({
    super.key,
    required this.priceLabel,
    required this.priceText,
    this.perPersonLine,
    required this.bookNowText,
    required this.onBookNow,
  });

  final String priceLabel;
  final String priceText;
  final String? perPersonLine;
  final String bookNowText;
  final VoidCallback onBookNow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        start: 20.w,
        end: 20.w,
        top: 16.h,
        bottom: MediaQuery.paddingOf(context).bottom + 16.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                priceLabel,
                style: AppTextStyles.caption(color: AppColors.greyText),
              ),
              Text(
                priceText,
                style: AppTextStyles.heading3(color: AppColors.darkText),
              ),
              if (perPersonLine != null)
                Text(
                  perPersonLine!,
                  style: AppTextStyles.caption(color: AppColors.greyText),
                ),
            ],
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: AppButton(
              heigh: 52.h,
              radius: 14.r,
              color: AppColors.primary,
              onTap: onBookNow,
              text: bookNowText,
            ),
          ),
        ],
      ),
    );
  }
}


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
    this.secondaryLabel,
    this.secondaryBadgeText,
    this.perPersonLine,
    required this.bookNowText,
    required this.onBookNow,
  });

  final String priceLabel;
  final String priceText;
  final String? secondaryLabel;
  final String? secondaryBadgeText;
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
        color: AppColors.scaffoldBg,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(
              alpha: AppColors.brightness == Brightness.dark ? 0.35 : 0.08,
            ),
            blurRadius: 10.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  priceLabel,
                  style: AppTextStyles.bodySmall(color: AppColors.darkText),
                ),
              ),
              Text(
                priceText,
                style: AppTextStyles.heading3(
                  color: AppColors.darkText,
                ).copyWith(fontWeight: FontWeight.w800),
              ),
            ],
          ),
          if (secondaryLabel != null || secondaryBadgeText != null) ...[
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    secondaryLabel ?? '',
                    style: AppTextStyles.bodySmall(color: AppColors.darkText),
                  ),
                ),
                if (secondaryBadgeText != null)
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.warning,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Text(
                      secondaryBadgeText!,
                      style: AppTextStyles.caption(
                        color: AppColors.black,
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
              ],
            ),
          ],
          if (perPersonLine != null) ...[
            SizedBox(height: 6.h),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                perPersonLine!,
                style: AppTextStyles.caption(color: AppColors.greyText),
              ),
            ),
          ],
          SizedBox(height: 14.h),
          AppButton(
            heigh: 54.h,
            radius: 999.r,
            color: AppColors.primary,
            textColor: AppColors.onImage,
            onTap: onBookNow,
            text: bookNowText,
          ),
        ],
      ),
    );
  }
}

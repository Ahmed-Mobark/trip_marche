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
    this.expanded = false,
  });

  final String priceLabel;
  final String priceText;
  final String? secondaryLabel;
  final String? secondaryBadgeText;
  final String? perPersonLine;
  final String bookNowText;
  final VoidCallback onBookNow;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      padding: EdgeInsetsDirectional.only(
        start: expanded ? 20.w : 24.w,
        end: expanded ? 20.w : 24.w,
        top: expanded ? 16.h : 10.h,
        bottom: MediaQuery.paddingOf(context).bottom + (expanded ? 16.h : 8.h),
      ),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBg(context),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(
              alpha: Theme.of(context).brightness == Brightness.dark
                  ? 0.35
                  : 0.08,
            ),
            blurRadius: 10.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (expanded) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    priceLabel,
                    style: AppTextStyles.bodySmall(color: AppColors.darkText(context)),
                  ),
                ),
                Text(
                  priceText,
                  style: AppTextStyles.body(
                    color: AppColors.darkText(context),
                  ).copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    height: 1.2,
                  ),
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
                      style: AppTextStyles.bodySmall(color: AppColors.darkText(context)),
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
                  style: AppTextStyles.caption(color: AppColors.greyText(context)),
                ),
              ),
            ],
            SizedBox(height: 14.h),
          ],
          // Compact: price + button in a row; Expanded: full-width button
          if (expanded)
            AppButton(
              heigh: 54.h,
              radius: 999.r,
              color: AppColors.primary,
              textColor: AppColors.onImage,
              onTap: onBookNow,
              text: bookNowText,
            )
          else
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      priceText,
                      style: AppTextStyles.body(
                        color: AppColors.darkText(context),
                      ).copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      priceLabel,
                      style: AppTextStyles.caption(color: AppColors.greyText(context)),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: 42.h,
                  child: AppButton(
                    heigh: 42.h,
                    radius: 999.r,
                    color: AppColors.primary,
                    textColor: AppColors.onImage,
                    onTap: onBookNow,
                    text: bookNowText,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

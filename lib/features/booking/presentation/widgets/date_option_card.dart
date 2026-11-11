import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/config/dimensions/trip_options_figma_tokens.dart';

class DateOptionCard extends StatelessWidget {
  const DateOptionCard({
    super.key,
    required this.dateRange,
    required this.price,
    required this.isSelected,
    required this.onTap,
    this.isFull = false,
    this.soldOutText,
  });

  final String dateRange;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isFull;
  final String? soldOutText;

  @override
  Widget build(BuildContext context) {
    final effectiveBorder = isFull
        ? TripOptionsFigmaTokens.cardBorder(context)
        : (isSelected
            ? TripOptionsFigmaTokens.selectedBorder(context)
            : TripOptionsFigmaTokens.cardBorder(context));

    final effectiveBg = isFull
        ? AppColors.cardBg(context).withValues(alpha: 0.5)
        : (isSelected
            ? AppColors.selectedPurpleTint(context)
            : AppColors.cardBg(context));

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: TripOptionsFigmaTokens.dateCardHeight,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: effectiveBg,
          borderRadius: BorderRadius.circular(
            TripOptionsFigmaTokens.dateCardRadius,
          ),
          border: Border.all(
            color: effectiveBorder,
            width: TripOptionsFigmaTokens.cardBorderWidth,
          ),
        ),
        child: Row(
          children: [
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  dateRange,
                  maxLines: 1,
                  softWrap: false,
                  style: AppTextStyles.bodyMedium(
                    color: isFull
                        ? AppColors.greyText(context)
                        : AppColors.ink(context),
                  ).copyWith(
                    fontSize: TripOptionsFigmaTokens.dateOptionFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.centerEnd,
                child: isFull
                    ? Container(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.red.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          soldOutText ?? 'اكتمل العدد',
                          maxLines: 1,
                          softWrap: false,
                          style: AppTextStyles.caption(
                            color: AppColors.red,
                          ).copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : Text(
                        price,
                        maxLines: 1,
                        softWrap: false,
                        style: AppTextStyles.bodyMedium(color: AppColors.primary)
                            .copyWith(
                              fontSize: TripOptionsFigmaTokens.dateOptionFontSize,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
  });

  final String dateRange;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: TripOptionsFigmaTokens.dateCardHeight,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: isSelected
              ? TripOptionsFigmaTokens.selectedDateFill
              : AppColors.white,
          borderRadius: BorderRadius.circular(
            TripOptionsFigmaTokens.dateCardRadius,
          ),
          border: Border.all(
            color: isSelected
                ? TripOptionsFigmaTokens.selectedBorder(context)
                : TripOptionsFigmaTokens.cardBorder(context),
            width: TripOptionsFigmaTokens.cardBorderWidth,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                dateRange,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.tripDetailsFigmaBlack,
                ).copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              price,
              style: AppTextStyles.bodyMedium(
                color: AppColors.primary,
              ).copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

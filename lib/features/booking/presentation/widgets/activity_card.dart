import 'package:flutter/material.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/select_activities_figma_tokens.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/booking/domain/entities/activity.dart';
import 'package:trip_marche/features/trip_details/presentation/trip_details_ui_formatters.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    super.key,
    required this.activity,
    required this.currency,
    required this.isSelected,
    required this.onTap,
    this.isClickable = true,
  });

  final Activity activity;
  final String currency;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isClickable;

  @override
  Widget build(BuildContext context) {
    final isVisuallyDisabled = !isClickable && !isSelected;
    final backgroundColor = isVisuallyDisabled
        ? AppColors.includedSurface(context)
        : isSelected
        ? AppColors.selectedPurpleTint(context)
        : AppColors.cardBg(context);
    final borderColor = isVisuallyDisabled
        ? AppColors.includedBorder(context)
        : isSelected
        ? AppColors.primary
        : AppColors.softBorder(context);
    final textColor = isVisuallyDisabled
        ? AppColors.subtitleGrey(context)
        : AppColors.ink(context);
    final priceColor = isVisuallyDisabled
        ? AppColors.metaGrey(context)
        : AppColors.primary;

    return GestureDetector(
      onTap: isClickable ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: SelectActivitiesFigmaTokens.activityCardHeight,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: SelectActivitiesFigmaTokens.activityCardHPadding,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            SelectActivitiesFigmaTokens.activityCardRadius,
          ),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                activity.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyMedium(color: textColor).copyWith(
                  fontSize: SelectActivitiesFigmaTokens.activityNameSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              TripDetailsUiFormatters.formatAmount(
                activity.price,
                currency: currency,
              ),
              style: AppTextStyles.bodyMedium(color: priceColor).copyWith(
                fontSize: SelectActivitiesFigmaTokens.activityPriceSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

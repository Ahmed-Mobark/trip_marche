import 'package:flutter/material.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/select_activities_figma_tokens.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/booking/domain/entities/activity.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    super.key,
    required this.activity,
    required this.isSelected,
    required this.onTap,
    this.enabled = true,
  });

  final Activity activity;
  final bool isSelected;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: Opacity(
        opacity: enabled ? 1 : 0.72,
        child: Container(
          height: SelectActivitiesFigmaTokens.activityCardHeight,
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: SelectActivitiesFigmaTokens.activityCardHPadding,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? SelectActivitiesFigmaTokens.selectedCardFill
                : AppColors.white,
            borderRadius: BorderRadius.circular(
              SelectActivitiesFigmaTokens.activityCardRadius,
            ),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : SelectActivitiesFigmaTokens.cardBorder,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  activity.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.tripDetailsFigmaBlack,
                  ).copyWith(
                    fontSize: SelectActivitiesFigmaTokens.activityNameSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                '\$${activity.price.toStringAsFixed(0)}+',
                style: AppTextStyles.bodyMedium(
                  color: AppColors.primary,
                ).copyWith(
                  fontSize: SelectActivitiesFigmaTokens.activityPriceSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

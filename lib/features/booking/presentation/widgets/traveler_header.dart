import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/select_activities_figma_tokens.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

class TravelerHeader extends StatelessWidget {
  const TravelerHeader({
    super.key,
    required this.travelerName,
    required this.travelerIndexLabel,
    this.sameAsTravelerOneLabel,
    this.showSameAsTravelerOne = false,
    this.sameAsTravelerOne = false,
    this.onSameAsTravelerOneChanged,
  });

  final String travelerName;
  final String travelerIndexLabel;
  final String? sameAsTravelerOneLabel;
  final bool showSameAsTravelerOne;
  final bool sameAsTravelerOne;
  final ValueChanged<bool>? onSameAsTravelerOneChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: travelerName,
                  style: AppTextStyles.subtitle(
                    color: AppColors.ink(context),
                  ).copyWith(
                    fontSize: SelectActivitiesFigmaTokens.travelerNameSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: ' $travelerIndexLabel',
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.subtitleGrey(context),
                  ).copyWith(
                    fontSize: SelectActivitiesFigmaTokens.travelerIndexSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showSameAsTravelerOne && sameAsTravelerOneLabel != null) ...[
          SizedBox(width: 8.w),
          _SameAsTravelerOneChip(
            label: sameAsTravelerOneLabel!,
            value: sameAsTravelerOne,
            onChanged: onSameAsTravelerOneChanged,
          ),
        ],
      ],
    );
  }
}

class _SameAsTravelerOneChip extends StatelessWidget {
  const _SameAsTravelerOneChip({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged == null ? null : () => onChanged!(!value),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: SelectActivitiesFigmaTokens.sameAsCheckboxHPadding,
          vertical: SelectActivitiesFigmaTokens.sameAsCheckboxVPadding,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardBg(context),
          borderRadius: BorderRadius.circular(
            SelectActivitiesFigmaTokens.sameAsCheckboxRadius,
          ),
          border: Border.all(
            color: AppColors.softBorder(context),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: SelectActivitiesFigmaTokens.sameAsCheckboxSize,
              height: SelectActivitiesFigmaTokens.sameAsCheckboxSize,
              child: Checkbox(
                value: value,
                onChanged: onChanged == null
                    ? null
                    : (next) => onChanged!(next ?? false),
                activeColor: AppColors.primary,
                side: BorderSide(
                  color: AppColors.softBorder(context),
                  width: 1.2,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              label,
              style: AppTextStyles.caption(
                color: AppColors.ink(context),
              ).copyWith(
                fontSize: SelectActivitiesFigmaTokens.sameAsLabelSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

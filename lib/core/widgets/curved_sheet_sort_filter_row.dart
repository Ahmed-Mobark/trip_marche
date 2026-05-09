import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

/// Sort + Filters pills under the search field (Search Result / home “See all” curved sheets).
class CurvedSheetSortFilterRow extends StatelessWidget {
  const CurvedSheetSortFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionPill(
            icon: Icons.keyboard_arrow_down_rounded,
            label: context.tr.searchResultSortBy,
            iconLeading: false,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _ActionPill(
            icon: Icons.tune_rounded,
            label: context.tr.searchResultFilters,
            iconLeading: true,
          ),
        ),
      ],
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({
    required this.icon,
    required this.label,
    required this.iconLeading,
  });

  final IconData icon;
  final String label;
  final bool iconLeading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.cardBg(context),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Row(
        children: [
          if (iconLeading) ...[
            Icon(icon, color: AppColors.searchResultMetaSlate, size: 18.sp),
            SizedBox(width: 10.w),
          ],
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyMedium(
                color: AppColors.darkText(context),
              ).copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500),
              textAlign: iconLeading ? TextAlign.end : TextAlign.center,
            ),
          ),
          if (!iconLeading) ...[
            SizedBox(width: 8.w),
            Icon(icon, color: AppColors.searchResultMetaSlate, size: 20.sp),
          ],
        ],
      ),
    );
  }
}

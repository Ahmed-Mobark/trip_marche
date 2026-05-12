import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

/// Sort + Filters pills under the search field (Search Result / home "See all"
/// curved sheets). Pills are interactive: tapping "Filters" opens the filter
/// page (#52), tapping "Sort By" opens a sort sheet provided by the host.
class CurvedSheetSortFilterRow extends StatelessWidget {
  const CurvedSheetSortFilterRow({
    super.key,
    this.onSortTap,
    this.onFilterTap,
  });

  final VoidCallback? onSortTap;
  final VoidCallback? onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionPill(
            icon: Icons.keyboard_arrow_down_rounded,
            label: context.tr.searchResultSortBy,
            iconLeading: false,
            onTap: onSortTap,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _ActionPill(
            icon: Icons.tune_rounded,
            label: context.tr.searchResultFilters,
            iconLeading: true,
            onTap: onFilterTap,
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
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool iconLeading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(999.r);
    return Material(
      color: AppColors.cardBg(context),
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          height: 44.h,
          padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            borderRadius: radius,
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
        ),
      ),
    );
  }
}

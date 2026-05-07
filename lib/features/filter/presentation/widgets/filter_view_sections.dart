import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/app_switch.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({required this.title, required this.child, super.key});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bodyMedium(
            color: AppColors.darkText,
          ).copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 16.h),
        child,
      ],
    );
  }
}

class SelectField extends StatelessWidget {
  const SelectField({
    required this.value,
    this.onTap,
    this.isLoading = false,
    super.key,
  });

  final String value;
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          height: 44.h,
          padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.secondaryText,
                  ).copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              if (isLoading)
                SizedBox(
                  width: 16.w,
                  height: 16.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                )
              else
                Icon(
                  Iconsax.arrow_down_1,
                  size: 16.sp,
                  color: AppColors.greyText,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectedDestinationChip extends StatelessWidget {
  const SelectedDestinationChip({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31.h,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(21.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Iconsax.close_circle, color: AppColors.onImage, size: 16.sp),
          SizedBox(width: 8.w),
          Text(
            label,
            style: AppTextStyles.caption(
              color: AppColors.onImage,
            ).copyWith(fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}

class PriceHistogram extends StatelessWidget {
  const PriceHistogram({required this.range, super.key});

  final RangeValues range;

  @override
  Widget build(BuildContext context) {
    const heights = [
      22.0,
      18.0,
      28.0,
      20.0,
      32.0,
      36.0,
      26.0,
      44.0,
      58.0,
      70.0,
      48.0,
      80.0,
      62.0,
      74.0,
      70.0,
      78.0,
      72.0,
      76.0,
      50.0,
      30.0,
      24.0,
      22.0,
    ];

    return SizedBox(
      height: 88.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(heights.length, (index) {
          final value = index / (heights.length - 1) * 10000;
          final selected = value >= range.start && value <= range.end;
          return Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 1.5.w),
              child: Container(
                height: heights[index].h,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primary.withValues(alpha: 0.55)
                      : AppColors.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class PriceValueField extends StatelessWidget {
  const PriceValueField({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body(
            color: AppColors.catalogMetaMuted,
          ).copyWith(fontSize: 14.sp),
        ),
        SizedBox(height: 7.h),
        Container(
          height: 44.h,
          width: double.infinity,
          padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
          alignment: AlignmentDirectional.centerStart,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            value,
            style: AppTextStyles.bodyMedium(
              color: AppColors.darkText,
            ).copyWith(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    required this.options,
    required this.isSelected,
    required this.onTap,
    this.labelBuilder,
    super.key,
  });

  final List<String> options;
  final bool Function(String value) isSelected;
  final ValueChanged<String> onTap;
  final String Function(String value)? labelBuilder;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.map((option) {
        final selected = isSelected(option);
        return Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              end: option == options.last ? 0 : 11.w,
            ),
            child: OutlinedOption(
              label: labelBuilder?.call(option) ?? option,
              selected: selected,
              onTap: () => onTap(option),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class NumberRow extends StatelessWidget {
  const NumberRow({required this.selected, required this.onTap, super.key});

  final int selected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [1, 2, 3, 4, 5].map((value) {
        final label = value == 5 ? '5+' : value.toString();
        return Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(end: value == 5 ? 0 : 11.w),
            child: OutlinedOption(
              label: label,
              selected: selected == value,
              onTap: () => onTap(value),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class OutlinedOption extends StatelessWidget {
  const OutlinedOption({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          height: 48.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: selected ? 2 : 1,
            ),
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body(
              color: selected ? AppColors.primary : AppColors.secondaryText,
            ).copyWith(fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}

class TripFeaturesSection extends StatelessWidget {
  const TripFeaturesSection({
    required this.selectedKeys,
    required this.onChanged,
    super.key,
  });

  final Set<String> selectedKeys;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final items = [
      ('includeFlight', context.tr.wishlistFiltersFeatureIncludeFlight),
      ('includeHotel', context.tr.wishlistFiltersFeatureIncludeHotel),
      ('freeMeal', context.tr.wishlistFiltersFeatureFreeMeal),
      ('visaOnArrival', context.tr.wishlistFiltersFeatureVisaOnArrival),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.tr.wishlistFiltersTripFeatures,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.darkText,
                ).copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Icon(Icons.keyboard_arrow_up_rounded, color: AppColors.greyText),
          ],
        ),
        SizedBox(height: 16.h),
        ...items.map((item) {
          final selected = selectedKeys.contains(item.$1);
          return Padding(
            padding: EdgeInsetsDirectional.only(bottom: 25.h),
            child: InkWell(
              onTap: () => onChanged(item.$1),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.$2,
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.secondaryText,
                      ).copyWith(fontSize: 14.sp),
                    ),
                  ),
                  SizedBox(
                    width: 24.r,
                    height: 24.r,
                    child: Checkbox(
                      value: selected,
                      onChanged: (_) => onChanged(item.$1),
                      activeColor: AppColors.primary,
                      side: BorderSide(color: AppColors.border),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        Text(
          context.tr.tripDetailsReadMore.trim(),
          style: AppTextStyles.bodyMedium(
            color: AppColors.primary,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class ToggleRow extends StatelessWidget {
  const ToggleRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 22.sp, color: AppColors.secondaryText),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodyMedium(
              color: AppColors.darkText,
            ).copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
        ),
        AppSwitch(value: value, onChanged: onChanged),
      ],
    );
  }
}

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
            color: AppColors.darkText(context),
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
            color: AppColors.cardBg(context),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border(context)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.secondaryText(context),
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
                  color: AppColors.greyText(context),
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

/// Animated price histogram. Bar heights are derived from real trip counts
/// when provided ([counts]) and otherwise fall back to a deterministic
/// synthetic curve so the chart still looks alive on first open.
///
/// Bars within the current [range] highlight in the primary colour. Height
/// and colour transitions are animated to give the chart a sense of motion
/// as the user drags the price slider or as new counts arrive.
class PriceHistogram extends StatelessWidget {
  const PriceHistogram({
    required this.range,
    required this.priceMin,
    required this.priceMax,
    this.counts = const [],
    this.bucketCount = 22,
    super.key,
  });

  /// Current selected price range (in the same units as [priceMin]/[priceMax]).
  final RangeValues range;

  /// Lower bound of the slider's domain. Bar `i` represents the bucket
  /// `[priceMin + i*step, priceMin + (i+1)*step)`.
  final double priceMin;

  /// Upper bound of the slider's domain.
  final double priceMax;

  /// Optional per-bucket trip counts. When empty (or all-zero) the histogram
  /// falls back to a synthetic curve.
  final List<int> counts;

  /// Number of bars. Used both for layout and to size the synthetic curve.
  final int bucketCount;

  @override
  Widget build(BuildContext context) {
    final heights = _resolveBarHeights();
    final domain = (priceMax - priceMin).abs() < 0.0001
        ? 1.0
        : (priceMax - priceMin);
    final step = domain / heights.length;

    return SizedBox(
      height: 88.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(heights.length, (index) {
          final bucketStart = priceMin + index * step;
          final bucketEnd = bucketStart + step;
          final selected = bucketEnd >= range.start && bucketStart <= range.end;
          final heightFactor = heights[index].clamp(0.06, 1.0);
          return Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 1.5.w),
              child: _AnimatedHistogramBar(
                heightFactor: heightFactor,
                maxHeight: 88.h,
                selected: selected,
                activeColor: AppColors.primary.withValues(alpha: 0.55),
                inactiveColor: AppColors.border(context),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// Converts [counts] to normalised heights (0..1). Falls back to a
  /// deterministic synthetic curve when no real data is available.
  List<double> _resolveBarHeights() {
    if (counts.isNotEmpty) {
      final clamped = counts.length >= bucketCount
          ? counts.sublist(0, bucketCount)
          : [...counts, ...List<int>.filled(bucketCount - counts.length, 0)];
      final maxCount = clamped.fold<int>(0, (m, v) => v > m ? v : m);
      if (maxCount > 0) {
        return clamped.map((c) => c / maxCount).toList(growable: false);
      }
    }
    return _syntheticCurve(bucketCount);
  }

  /// Bell-ish, slightly skewed distribution that mimics a realistic price
  /// histogram (low at edges, peak around the cheaper mid-range).
  List<double> _syntheticCurve(int n) {
    // Cached pattern (peak around index 10–15 of 22, gently sloping).
    const seed = <double>[
      0.22,
      0.18,
      0.28,
      0.20,
      0.32,
      0.36,
      0.26,
      0.44,
      0.58,
      0.70,
      0.48,
      0.80,
      0.62,
      0.74,
      0.70,
      0.78,
      0.72,
      0.76,
      0.50,
      0.30,
      0.24,
      0.22,
    ];
    if (n == seed.length) {
      return seed;
    }
    return List.generate(n, (i) {
      final t = i / (n - 1);
      final idx = (t * (seed.length - 1)).round();
      return seed[idx];
    });
  }
}

class _AnimatedHistogramBar extends StatelessWidget {
  const _AnimatedHistogramBar({
    required this.heightFactor,
    required this.maxHeight,
    required this.selected,
    required this.activeColor,
    required this.inactiveColor,
  });

  final double heightFactor;
  final double maxHeight;
  final bool selected;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    final targetHeight = maxHeight * heightFactor;
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
      tween: Tween<double>(begin: 0, end: targetHeight),
      builder: (context, value, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          height: value,
          decoration: BoxDecoration(
            color: selected ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(2.r),
          ),
        );
      },
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
            color: AppColors.catalogMetaMuted(context),
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
            border: Border.all(color: AppColors.border(context)),
          ),
          child: Text(
            value,
            style: AppTextStyles.bodyMedium(
              color: AppColors.darkText(context),
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

/// Row of 1..5 (+) chips with multi-select + tap-to-deselect semantics.
///
/// [selected] is a Set; tapping a chip calls [onTap] with that value and the
/// owner is expected to toggle it (add if missing, remove if present). This
/// satisfies both multi-select (#54, #55) and deselect-on-tap (#56).
class NumberRow extends StatelessWidget {
  const NumberRow({required this.selected, required this.onTap, super.key});

  final Set<int> selected;
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
              selected: selected.contains(value),
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
            color: AppColors.cardBg(context),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border(context),
              width: selected ? 2 : 1,
            ),
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body(
              color: selected
                  ? AppColors.primary
                  : AppColors.secondaryText(context),
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
                  color: AppColors.darkText(context),
                ).copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_up_rounded,
              color: AppColors.greyText(context),
            ),
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
                        color: AppColors.secondaryText(context),
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
                      side: BorderSide(color: AppColors.border(context)),
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
        Icon(icon, size: 22.sp, color: AppColors.secondaryText(context)),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodyMedium(
              color: AppColors.darkText(context),
            ).copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
        ),
        AppSwitch(value: value, onChanged: onChanged),
      ],
    );
  }
}

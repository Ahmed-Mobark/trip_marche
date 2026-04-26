import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_switch.dart';

class WishlistFilterSectionTitle extends StatelessWidget {
  const WishlistFilterSectionTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.bodyMedium(color: AppColors.darkText)
          .copyWith(fontWeight: FontWeight.w700),
    );
  }
}

class WishlistFilterSelectField extends StatelessWidget {
  const WishlistFilterSelectField({
    super.key,
    required this.value,
    required this.hint,
    required this.onTap,
  });

  final String value;
  final String hint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final display = value.isEmpty ? hint : value;
    final color = value.isEmpty ? AppColors.greyText : AppColors.darkText;

    return Material(
      color: AppColors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          height: 46.h,
          padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  display,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium(color: color),
                ),
              ),
              Icon(Iconsax.arrow_down_1, color: AppColors.greyText, size: 18.sp),
            ],
          ),
        ),
      ),
    );
  }
}

class WishlistFilterPriceHistogram extends StatelessWidget {
  const WishlistFilterPriceHistogram({super.key});

  @override
  Widget build(BuildContext context) {
    const heights = <double>[
      10, 18, 26, 16, 22, 30, 12, 20, 28, 14, 24, 18, 12, 22, 16, 26, 14, 20,
    ];
    return Container(
      height: 56.h,
      padding: EdgeInsetsDirectional.only(top: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(heights.length, (i) {
          final isActive = i >= 4 && i <= 12;
          return Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 1.2.w),
              child: Container(
                height: heights[i].h,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.purpleColor : AppColors.border,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class WishlistFilterPricePill extends StatelessWidget {
  const WishlistFilterPricePill({super.key, required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.h,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.border),
      ),
      alignment: Alignment.center,
      child: Text(
        value,
        style: AppTextStyles.bodyMedium(color: AppColors.darkText)
            .copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class WishlistFilterSegmented extends StatelessWidget {
  const WishlistFilterSegmented({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    required this.value,
    required this.onChanged,
  });

  final String leftLabel;
  final String rightLabel;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      padding: EdgeInsetsDirectional.all(4.r),
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SegItem(
              label: leftLabel,
              selected: value == 'domestic',
              onTap: () => onChanged('domestic'),
            ),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: _SegItem(
              label: rightLabel,
              selected: value == 'international',
              onTap: () => onChanged('international'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegItem extends StatelessWidget {
  const _SegItem({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999.r),
        child: Container(
          decoration: BoxDecoration(
            color: selected ? AppColors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(999.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTextStyles.bodyMedium(
              color: selected ? AppColors.darkText : AppColors.greyText,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class WishlistFilterChip extends StatelessWidget {
  const WishlistFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999.r),
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: selected ? AppColors.purpleColor : AppColors.white,
            borderRadius: BorderRadius.circular(999.r),
            border: Border.all(color: selected ? AppColors.purpleColor : AppColors.border),
          ),
          child: Text(
            label,
            style: AppTextStyles.bodyMedium(
              color: selected ? AppColors.white : AppColors.darkText,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class WishlistFilterChoiceChips extends StatelessWidget {
  const WishlistFilterChoiceChips({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: options.map((o) {
        final selected = value == o;
        return WishlistFilterChip(
          label: o,
          selected: selected,
          onTap: () => onChanged(selected ? '' : o),
        );
      }).toList(),
    );
  }
}

class WishlistFilterRatingChips extends StatelessWidget {
  const WishlistFilterRatingChips({super.key, required this.value, required this.onChanged});
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: [1, 2, 3, 4, 5].map((r) {
        final selected = value == r;
        return WishlistFilterChip(
          label: r.toString(),
          selected: selected,
          onTap: () => onChanged(selected ? 0 : r),
        );
      }).toList(),
    );
  }
}

class WishlistFilterNumberChips extends StatelessWidget {
  const WishlistFilterNumberChips({super.key, required this.value, required this.onChanged});
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final options = <int>[1, 2, 3, 4, 5];
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: [
        ...options.map((n) {
          final selected = value == n;
          return WishlistFilterChip(
            label: n.toString(),
            selected: selected,
            onTap: () => onChanged(n),
          );
        }),
        WishlistFilterChip(
          label: '5+',
          selected: value >= 5,
          onTap: () => onChanged(5),
        ),
      ],
    );
  }
}

class WishlistFilterTripFeatures extends StatelessWidget {
  const WishlistFilterTripFeatures({
    super.key,
    required this.title,
    required this.items,
    required this.selectedKeys,
    required this.onChanged,
  });

  final String title;
  final List<(String key, String label)> items;
  final Set<String> selectedKeys;
  final void Function(String key, bool selected) onChanged;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsetsDirectional.zero,
        childrenPadding: EdgeInsetsDirectional.only(top: 8.h, bottom: 8.h),
        title: WishlistFilterSectionTitle(title: title),
        trailing: Icon(Iconsax.arrow_down_1, size: 18.sp, color: AppColors.greyText),
        children: items.map((it) {
          final isSelected = selectedKeys.contains(it.$1);
          return CheckboxListTile(
            value: isSelected,
            controlAffinity: ListTileControlAffinity.trailing,
            contentPadding: EdgeInsetsDirectional.zero,
            onChanged: (v) => onChanged(it.$1, v ?? false),
            title: Text(
              it.$2,
              style: AppTextStyles.bodyMedium(color: AppColors.darkText),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class WishlistFilterToggleRow extends StatelessWidget {
  const WishlistFilterToggleRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodyMedium(color: AppColors.darkText)
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        AppSwitch(value: value, onChanged: onChanged),
      ],
    );
  }
}


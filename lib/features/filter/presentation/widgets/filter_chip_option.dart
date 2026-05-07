import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class FilterChipOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool showCheckmark;
  final Widget? leading;

  const FilterChipOption({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.showCheckmark = false,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border(context),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected && showCheckmark) ...[
              const Icon(Icons.check, size: 16, color: AppColors.onImage),
              const SizedBox(width: 6),
            ],
            if (leading != null) ...[leading!, const SizedBox(width: 4)],
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.onImage : AppColors.secondaryText(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

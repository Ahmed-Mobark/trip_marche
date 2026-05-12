import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
    this.icon,
    this.iconUrl,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  /// Local icon (e.g. from `Iconsax`) used when no remote icon URL is given.
  final IconData? icon;

  /// Optional remote icon URL (PNG / SVG). Takes precedence over [icon].
  final String? iconUrl;

  @override
  Widget build(BuildContext context) {
    final foreground =
        isSelected ? AppColors.onImage : AppColors.greyText(context);

    final hasRemote = iconUrl != null && iconUrl!.trim().isNotEmpty;
    final hasLocal = icon != null;
    final hasLeading = hasRemote || hasLocal;

    Widget? leading;
    if (hasRemote) {
      leading = ClipRRect(
        borderRadius: BorderRadius.circular(4.r),
        child: SizedBox(
          width: 16.r,
          height: 16.r,
          child: AppCachedNetworkImage(
            imageUrl: iconUrl!,
            fit: BoxFit.contain,
          ),
        ),
      );
    } else if (hasLocal) {
      leading = Icon(icon, size: 16.sp, color: foreground);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 14.w,
            vertical: 8.h,
          ),
          decoration: BoxDecoration(
            color:
                isSelected ? AppColors.primary : AppColors.background(context),
            borderRadius: BorderRadius.circular(999.r),
            border: Border.all(
              color:
                  isSelected ? AppColors.primary : AppColors.border(context),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hasLeading) ...[
                leading!,
                SizedBox(width: 6.w),
              ],
              Text(
                label,
                style: AppTextStyles.bodySmall(color: foreground).copyWith(
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

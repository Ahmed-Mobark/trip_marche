import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/config/styles/styles.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? titleColor;
  final Color? iconColor;
  final bool showChevron;
  final Widget? trailing;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.titleColor,
    this.iconColor,
    this.showChevron = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 18.w,
          vertical: 14.h,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22.sp,
              color: iconColor ?? AppColors.secondaryText,
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodyMedium(
                  color: titleColor ?? AppColors.darkText,
                ).copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            if (trailing != null) trailing!,
            if (showChevron)
              Icon(
                Iconsax.arrow_right_3,
                size: 18.sp,
                color: AppColors.greyText,
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class TripDetailItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const TripDetailItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightBg(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 22.sp),
          SizedBox(height: 6.h),
          Text(
            value,
            style: AppTextStyles.bodyMedium(color: AppColors.darkText(context)),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: AppTextStyles.caption(color: AppColors.greyText(context)),
          ),
        ],
      ),
    );
  }
}

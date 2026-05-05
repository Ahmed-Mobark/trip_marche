import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  Color _statusColor() {
    switch (status) {
      case 'Confirmed':
        return AppColors.success;
      case 'Completed':
        return AppColors.primary;
      case 'Cancelled':
        return AppColors.error;
      default:
        return AppColors.greyText;
    }
  }

  Color _statusBgColor() {
    switch (status) {
      case 'Confirmed':
        return AppColors.success.withValues(alpha: 0.1);
      case 'Completed':
        return AppColors.primary.withValues(alpha: 0.1);
      case 'Cancelled':
        return AppColors.error.withValues(alpha: 0.1);
      default:
        return AppColors.lightBg;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _statusBgColor(),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        status,
        style: AppTextStyles.caption(
          color: _statusColor(),
        ).copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

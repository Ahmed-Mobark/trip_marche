import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CompanyFollowButton extends StatelessWidget {
  const CompanyFollowButton({
    super.key,
    required this.isFollowing,
    required this.onPressed,
    this.isLoading = false,
  });

  final bool isFollowing;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        backgroundColor: isFollowing
            ? AppColors.primary
            : AppColors.transparent,
        side: BorderSide(
          color: isFollowing ? AppColors.primary : AppColors.border(context),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: isLoading
          ? SizedBox(
              width: 14.r,
              height: 14.r,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: isFollowing ? AppColors.white : AppColors.primary,
              ),
            )
          : Text(
              isFollowing
                  ? context.tr.companyProfileFollowing
                  : context.tr.companyProfileFollow,
              style: AppTextStyles.button(
                color: isFollowing ? AppColors.white : AppColors.primary,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
    );
  }
}

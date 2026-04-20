import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

class PromoBannerItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final int currentIndex;
  final int totalCount;
  final VoidCallback? onBookNowTap;

  const PromoBannerItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.currentIndex,
    required this.totalCount,
    this.onBookNowTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTight = constraints.maxHeight <= 140;
        final titleStyle = isTight
            ? AppTextStyles.heading3(color: AppColors.white)
            : AppTextStyles.heading2(color: AppColors.white);

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: isTight ? 12.h : 16.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(title, style: titleStyle),
                      SizedBox(height: 4.h),
                      Flexible(
                        child: Text(
                          subtitle,
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.white.withValues(alpha: 0.85),
                          ),
                          maxLines: isTight ? 1 : 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: isTight ? 6.h : 10.h),
                      SizedBox(
                        height: isTight ? 30.h : 34.h,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: AlignmentDirectional.centerStart,
                          child: GestureDetector(
                            onTap: onBookNowTap,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: isTight ? 7.h : 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.yellow,
                                borderRadius: BorderRadius.circular(999.r),
                              ),
                              child: Text(
                                'Book Now',
                                style: AppTextStyles.bodyMedium(
                                  color: AppColors.darkText,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${currentIndex + 1}/$totalCount',
                    style: AppTextStyles.bodySmall(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

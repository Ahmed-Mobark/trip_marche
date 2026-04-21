import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

class ReviewItemDisplay extends StatelessWidget {
  final String name;
  final int rating;
  final String date;
  final String comment;

  const ReviewItemDisplay({
    super.key,
    required this.name,
    required this.rating,
    required this.date,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.lightBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: Text(
                  name[0],
                  style: AppTextStyles.bodyMedium(color: AppColors.primary),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyles.bodyMedium(color: AppColors.darkText)),
                    Text(date, style: AppTextStyles.caption()),
                  ],
                ),
              ),
              Row(
                children: List.generate(rating, (i) {
                  return Icon(Iconsax.star1, color: AppColors.starYellow, size: 14.sp);
                }),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(comment, style: AppTextStyles.body(color: AppColors.secondaryText)),
        ],
      ),
    );
  }
}

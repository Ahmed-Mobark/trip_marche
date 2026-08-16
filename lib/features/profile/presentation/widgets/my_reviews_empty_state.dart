import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/config/app_icons.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../my_trips/presentation/view/my_trips_view.dart';

class MyReviewsEmptyState extends StatelessWidget {
  const MyReviewsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: AppColors.cardBg(context),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppIcons.frameSvg,
            width: 100.r,
            height: 100.r,
          ),
          SizedBox(height: 16.h),
          Text(
            'No Reviews Yet',
            textAlign: TextAlign.center,
            style: AppTextStyles.subtitle(
              color: AppColors.darkText(context),
            ).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Start by reviewing your past\ntrips!',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium(
              color: AppColors.greyText(context),
            ).copyWith(
              fontSize: 13.sp,
              height: 1.3,
            ),
          ),
          SizedBox(height: 24.h),
          Divider(
            color: AppColors.border(context).withValues(alpha: 0.5),
            height: 1,
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () {
                sl<AppNavigator>().push(screen: const MyTripsView());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Go To My Trips',
                style: AppTextStyles.bodyMedium(
                  color: Colors.white,
                ).copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

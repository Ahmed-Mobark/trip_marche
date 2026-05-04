import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/network/connectivity/connectivity_cubit.dart';
import 'package:trip_marche/core/widgets/app_button.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/offline.png',
                  width: 160.w,
                  height: 160.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 24.h),
                Text(
                  'You are offline',
                  style: TextStyles.textViewBold22.copyWith(
                    color: AppColors.darkText,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'your app will be available when connection is restored. You can still clock in and out',
                  textAlign: TextAlign.center,
                  style: TextStyles.textViewRegular14.copyWith(
                    color: AppColors.greyText,
                  ),
                ),
                SizedBox(height: 32.h),
                AppButton(
                  text: 'Try Again',
                  gradient: AppColors.primaryGradient,
                  radius: 30.r,
                  onTap: () {
                    context.read<ConnectivityCubit>().checkConnection();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

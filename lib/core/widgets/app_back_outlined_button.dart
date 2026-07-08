import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/config/dimensions/contact_info_figma_tokens.dart';
import 'package:trip_marche/core/config/dimensions/trip_options_figma_tokens.dart';

class AppBackOutlinedButton extends StatelessWidget {
  const AppBackOutlinedButton({
    super.key,
    required this.onPressed,
    this.circular = false,
  });

  final VoidCallback onPressed;
  final bool circular;

  @override
  Widget build(BuildContext context) {
    final size = circular
        ? ContactInfoFigmaTokens.bottomBarBackSize
        : TripOptionsFigmaTokens.bottomBarBackWidth;
    final height = circular
        ? ContactInfoFigmaTokens.bottomBarBackSize
        : TripOptionsFigmaTokens.bottomBarButtonHeight;
    final radius = circular
        ? size / 2
        : TripOptionsFigmaTokens.bottomBarRadius;

    return SizedBox(
      width: size,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.subtitleGrey(context),
          backgroundColor: AppColors.cardBg(context),
          side: BorderSide(
            color: circular
                ? AppColors.ink(context)
                : AppColors.softBorder(context),
            width: circular ? 1.w : 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18.sp,
        ),
      ),
    );
  }
}

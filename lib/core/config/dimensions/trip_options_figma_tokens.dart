import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';

/// Figma reference tokens for the Trip Options screen (393 × 852).
abstract final class TripOptionsFigmaTokens {
  static const Color selectedDateFill = Color(0xFFF8F0FC);
  static const Color subtitleGrey = Color(0xFF757575);
  static const Color stepperDisabledBorder = Color(0xFFE0E0E0);
  static const Color stepperDisabledIcon = Color(0xFFBDBDBD);
  static const Color stepperEnabledFill = Color(0xFFF8F0FC);

  static double get screenPadding => 20.w;
  static double get titleTop => 8.h;
  static double get titleBottom => 24.h;
  static double get titleFontSize => 18.sp;
  static double get sectionTitleFontSize => 16.sp;
  static double get sectionTitleBottom => 12.h;
  static double get sectionBottom => 24.h;
  static double get dateCardHeight => 50.h;
  static double get dateCardRadius => 12.r;
  static double get gridHGap => 10.w;
  static double get gridVGap => 10.h;
  static double get seeAllTop => 12.h;
  static double get seeAllFontSize => 14.sp;
  static double get cardRadius => 12.r;
  static double get cardBorderWidth => 1.w;
  static double get travelerCardVPad => 14.h;
  static double get travelerCardHPad => 14.w;
  static double get travelerCardGap => 10.h;
  static double get iconBox => 40.w;
  static double get iconSize => 22.sp;
  static double get stepperSize => 32.w;
  static double get stepperRadius => 8.r;
  static double get stepperIconSize => 16.sp;
  static double get counterValueWidth => 28.w;
  static double get counterGap => 10.w;
  static double get accommodationCardPad => 14.w;
  static double get accommodationInnerGap => 12.h;
  static double get bottomBarHPadding => 16.w;
  static double get bottomBarVPadding => 10.h;
  static double get bottomBarBottom => 14.h;
  static double get bottomBarButtonHeight => 48.h;
  static double get bottomBarBackWidth => 52.w;
  static double get bottomBarGap => 8.w;
  static double get bottomBarRadius => 24.r;

  static Color cardBorder(BuildContext context) => AppColors.border(context);
  static Color selectedBorder(BuildContext context) => AppColors.primary;
}

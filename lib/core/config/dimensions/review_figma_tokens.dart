import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Figma reference tokens for the Review screen (393 × 852).
abstract final class ReviewFigmaTokens {
  static const Color screenBackground = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE0E0E0);
  static const Color metaGrey = Color(0xFF757575);
  static const Color descriptionGrey = Color(0xFF6B7280);
  static const Color successGreen = Color(0xFF10A94B);
  static const Color includedBorder = Color(0xFFE5E7EB);
  static const Color includedBg = Color(0xFFFAFAFA);

  static double get screenPadding => 16.w;
  static double get titleTop => 8.h;
  static double get titleBottom => 20.h;
  static double get titleFontSize => 18.sp;
  static double get sectionGap => 20.h;
  static double get cardRadius => 16.r;
  static double get cardPadding => 16.w;
  static double get tripNameSize => 16.sp;
  static double get bodySize => 14.sp;
  static double get smallSize => 12.sp;
  static double get rowGap => 12.h;
  static double get includedRadius => 12.r;
  static double get includedPadding => 12.w;
  static double get couponFieldRadius => 12.r;
  static double get couponFieldHeight => 48.h;
  static double get applyButtonRadius => 10.r;
  static double get applyButtonHPadding => 16.w;
  static double get listBottom => 16.h;
}

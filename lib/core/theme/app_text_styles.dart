import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_marche/core/theme/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  /// 24px Bold
  static TextStyle heading1({Color? color}) => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.darkText,
      );

  /// 20px SemiBold
  static TextStyle heading2({Color? color}) => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.darkText,
      );

  /// 18px Bold
  static TextStyle heading3({Color? color}) => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.darkText,
      );

  /// 16px SemiBold
  static TextStyle subtitle({Color? color}) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.darkText,
      );

  /// 16px Regular
  static TextStyle body({Color? color}) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.darkText,
      );

  /// 14px Medium
  static TextStyle bodyMedium({Color? color}) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.darkText,
      );

  /// 12px Medium
  static TextStyle bodySmall({Color? color}) => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.darkText,
      );

  /// 12px Regular
  static TextStyle caption({Color? color}) => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.greyText,
      );

  /// 16px SemiBold
  static TextStyle button({Color? color}) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.white,
      );

  /// 14px Medium
  static TextStyle label({Color? color}) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.darkText,
      );
}

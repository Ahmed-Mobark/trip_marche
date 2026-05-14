import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/config/styles/font_utils.dart';
import '../../../../core/theme/app_colors.dart';

/// Design tokens from Figma **Profile** [`1:22365`], handoff frame width **430**.
/// Horizontal metrics scale with [MediaQuery.sizeOf(context).width] / 430 so
/// layout stays proportional on all devices (not “approximate” .w guesses).
///
/// See: `Trip-March-Handoff--Copy-` profile screen.
class ProfileHandoffTokens {
  ProfileHandoffTokens._(this._screenW);

  final double _screenW;

  static const double kFigmaFrameW = 430;

  /// `figmaPx` measured on the 430-wide Figma frame → logical px on device.
  double w(double figmaPx) => figmaPx * _screenW / kFigmaFrameW;

  double r(double figmaPx) => w(figmaPx);

  static ProfileHandoffTokens of(BuildContext context) =>
      ProfileHandoffTokens._(MediaQuery.sizeOf(context).width);

  // --- Figma colors (light reference; dark uses theme fallbacks) ---
  static const Color canvasLight = Color(0xFFFEFCFF);
  static const Color gradientStart = Color(0xFF511C6F);
  static const Color gradientEnd = Color(0xFF9B36D5);
  static const Color sectionLabel = Color(0xFF7C818A);
  static const Color menuTitleLight = Color(0xFF131213);
  static const Color emailOnHeader = Color(0xFFDCD9DE);
  static const Color tripsBooked = AppColors.yellow;
  static const Color divider = Color(0xFFD5D9DF);
  static const Color deleteRowTitleLight = Color(0xFF060606);
  static const double kHeaderGradientAngleDeg = 122.80092926841509;

  static LinearGradient headerGradient() {
    return LinearGradient(
      transform: GradientRotation(kHeaderGradientAngleDeg * math.pi / 180),
      colors: const [gradientStart, gradientEnd],
    );
  }

  static List<BoxShadow> cardShadow() => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.10),
          blurRadius: 5,
          offset: const Offset(0, 4),
        ),
      ];

  static Color canvas(BuildContext context) =>
      AppColors.isDark(context) ? AppColors.scaffoldBg(context) : canvasLight;

  static Color menuTitle(BuildContext context) =>
      AppColors.isDark(context) ? AppColors.textColorDark : menuTitleLight;

  static Color sectionLabelColor(BuildContext context) =>
      AppColors.isDark(context) ? AppColors.greyTextColorDark : sectionLabel;

  static Color emailColor(BuildContext context) =>
      AppColors.isDark(context)
          ? AppColors.onImage.withValues(alpha: 0.72)
          : emailOnHeader;

  static Color dividerColor(BuildContext context) =>
      AppColors.isDark(context) ? AppColors.borderColorDark : divider;

  static Color deleteTitle(BuildContext context) =>
      AppColors.isDark(context) ? AppColors.error : deleteRowTitleLight;

  // --- Typography (Readex Pro = project font; sizes from Figma) ---
  static TextStyle headerNameStyle() => TextStyle(
        fontFamily: AppFont.fontFamily,
        fontWeight: AppFont.semiBold,
        fontSize: FontSizes.s20,
        height: 1.0,
        color: AppColors.onImage,
      );

  static TextStyle headerEmailStyle(BuildContext context) => TextStyle(
        fontFamily: AppFont.fontFamily,
        fontWeight: AppFont.medium,
        fontSize: FontSizes.s14,
        height: 20 / 14,
        letterSpacing: 0.1,
        color: emailColor(context),
      );

  static TextStyle headerTripsStyle() => TextStyle(
        fontFamily: AppFont.fontFamily,
        fontWeight: AppFont.medium,
        fontSize: FontSizes.s14,
        height: 20 / 14,
        letterSpacing: 0.1,
        color: tripsBooked,
      );

  static TextStyle sectionHeaderStyle(BuildContext context) => TextStyle(
        fontFamily: AppFont.fontFamily,
        fontWeight: AppFont.medium,
        fontSize: FontSizes.s16,
        height: 20 / 16,
        letterSpacing: 0.1,
        color: sectionLabelColor(context),
      );

  static TextStyle menuRowTitleStyle(BuildContext context) => TextStyle(
        fontFamily: AppFont.fontFamily,
        fontWeight: AppFont.medium,
        fontSize: FontSizes.s16,
        height: 20 / 16,
        letterSpacing: 0.1,
        color: menuTitle(context),
      );

  static TextStyle logoutTitleStyle() => TextStyle(
        fontFamily: AppFont.fontFamily,
        fontWeight: AppFont.medium,
        fontSize: FontSizes.s16,
        height: 20 / 16,
        letterSpacing: 0.1,
        color: AppColors.red,
      );
}

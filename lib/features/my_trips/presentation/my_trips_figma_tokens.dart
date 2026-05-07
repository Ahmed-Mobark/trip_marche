import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/styles/font_utils.dart';

/// My Trips design tokens scaled with [ScreenUtil] (design size 393×852).
/// Base numbers match Figma logical px; use `.w` / `.h` / `.sp` / `.r` at read time.
abstract final class MyTripsFigmaTokens {
  // --- Screen rhythm ---
  static double get padH => 16.w;
  static double get headerPadTop => 6.h;
  static double get headerPadBottom => 20.h;
  static double get sheetTopRadius => 20.r;
  static double get sheetOverlapUp => 16.h;
  static double get searchBlockTop => 16.h;
  static double get tabRowTop => 10.h;
  static double get tabGap => 10.w;
  static double get tabHeight => 34.h;
  static double get listPadTop => 12.h;
  static double get listPadBottom => 20.h;
  static double get cardSeparator => 12.h;

  // --- Header title ---
  static double get headerTitleSize => 24.sp;
  static const double headerTitleLineHeight = 1.2;

  // --- Search ---
  static double get searchFontSize => 16.sp;
  static const double searchLineHeight = 1.25;
  static double get searchIconSize => 20.sp;
  static double get searchContentPadH => 12.w;
  static double get searchContentPadV => 12.h;

  /// Pill radius (fully rounded ends).
  static double get searchRadiusPill => 999.r;

  // --- Tabs ---
  static double get tabFontSize => 12.sp;
  static const double tabLineHeight = 1.2;
  static double get tabPadH => 8.w;

  // --- Legacy card shell (catalog / shared) ---
  static double get cardRadius => 20.r;
  static double get cardPad => 16.w;
  static double get cardShadowBlur => 6.r;
  static double get cardShadowY => 1.h;
  static const double cardShadowAlpha = 0.06;

  // --- Thumb (legacy token set) ---
  static double get thumbSize => 100.w;
  static double get thumbRadius => 16.r;
  static double get thumbBadgeInset => 6.w;
  static double get badgeFontSize => 10.sp;
  static double get badgePadH => 6.w;
  static double get badgePadV => 3.h;
  static double get imageToTextGap => 12.w;

  // --- Card typography (legacy) ---
  static double get titleFontSize => 18.sp;
  static const double titleLineHeight = 1.2;
  static double get metaFontSize => 12.sp;
  static const double metaLineHeight = 1.2;
  static double get metaIconSize => 14.sp;
  static double get metaIconTextGap => 4.w;
  static double get metaRowGap => 4.h;
  static double get titleToMetaGap => 4.h;
  static double get metaToActionsGap => 10.h;

  // --- Favorite chip ---
  static double get favoriteDiameter => 30.w;
  static double get favoriteIconSize => 15.sp;
  static double get favoritePadStart => 6.w;
  static double get favoriteShadowBlur => 4.r;
  static double get favoriteShadowY => 2.h;
  static const double favoriteShadowAlpha = 0.12;

  // --- Row actions ---
  static double get actionHeight => 34.h;
  static double get actionRadius => 8.r;
  static double get actionFontSize => 12.sp;
  static const double actionLineHeight = 1.2;
  static double get actionGapH => 8.w;
  static double get actionPadH => 6.w;
  static double get rowToFooterGap => 10.h;

  // --- Bottom PDF row ---
  static double get bottomActionHeight => 42.h;
  static double get bottomActionRadius => 12.r;
  static double get bottomFontSize => 12.sp;
  static const double bottomLineHeight = 1.2;
  static double get pdfIconSize => 18.sp;
  static double get pdfIconTextGap => 8.w;
  static double get bottomPadH => 12.w;

  static TextStyle text({
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    double height = 1.2,
    double? letterSpacing,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: AppFont.fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      color: color,
    );
  }
}

/// Trip card on My Trips shell — scaled tokens (was `_Px`).
abstract final class MyTripsTripCardTokens {
  static double get cardRadius => 16.r;
  static double get cardBorderWidth => 1.w;
  static double get shadowBlur => 4.r;
  static double get shadowY => 1.h;
  static const double shadowAlpha = 0.04;

  /// Unitless fraction of card width for leading strip.
  static const double imageStripWidthFactor = 0.42;

  static double get imageStripMinW => 110.w;
  static double get imageStripMaxW => 132.w;

  static double get contentPad => 10.w;

  static double get badgeInset => 8.w;
  static double get badgePadH => 7.w;
  static double get badgePadV => 3.h;
  static double get badgeFont => 10.sp;

  static double get titleFont => 16.sp;

  static double get metaFont => 12.sp;

  static double get rowTight => 4.h;
  static double get beforeActions => 8.h;
  static double get belowTwinRow => 6.h;

  static double get starSize => 14.sp;
  static double get starToText => 3.w;
  static double get metaIcon => 14.sp;
  static double get metaIconGap => 4.w;

  static double get favoriteSize => 34.w;
  static double get favoriteIcon => 18.sp;
  static double get favoriteStartPad => 6.w;
  static double get favoriteShadowBlur => 4.r;
  static double get favoriteShadowY => 2.h;
  static const double favoriteShadowAlpha = 0.1;

  static double get twinH => 30.h;
  static double get twinRadius => 8.r;
  static double get twinFont => 12.sp;
  static double get twinGap => 6.w;
  static double get twinPadH => 8.w;

  static double get footerH => 30.h;
  static double get footerRadius => 8.r;
  static double get footerFont => 12.sp;
  static double get pdfSize => 14.sp;
  static double get pdfGap => 6.w;
  static double get footerPadH => 12.w;

  /// Line-height multiplier from Figma px pair (ratio; do not mix .sp here).
  static double lh(double fontDesignPx, double lineDesignPx) =>
      lineDesignPx / fontDesignPx;
}

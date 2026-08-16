import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract final class CompanyProfileFigmaTokens {
  static double get screenPadding => 16.w;
  static double get screenPaddingSmall => 14.w;

  static double get sectionGap => 14.h;
  static double get sectionBottom => 28.h;

  static double get cardRadius => 8.r;
  static double get cardRadiusLarge => 12.r;
  static double get cardRadiusXLarge => 20.r;

  static double get cardPadding => 14.w;

  static double get titleFontSize => 17.sp;
  static double get bodyFontSize => 12.sp;
  static double get bodyMediumFontSize => 13.sp;
  static double get smallFontSize => 11.sp;
  static double get captionFontSize => 11.sp;

  static double get headerAvatarWidth => 56.w;
  static double get headerAvatarHeight => 60.h;

  static double get teamAvatarSize => 60.r;
  static double get reviewAvatarSize => 44.r;
  static double get teamSectionListHeight => 120.r;

  static double get actionButtonHeight => 36.h;
  static double get actionButtonRadius => 10.r;
  static double get followButtonWidth => 70.w;
  static double get followButtonHeight => 30.h;

  static double get socialIconButtonHeight => 36.h;
  static double get socialIconButtonRadius => 8.r;

  static double get tripCardImageWidth => 130.w;
  static double get tripCardImageAspectRatio => 4 / 5;
  static double get tripCardRadius => 16.r;

  static double get categoryItemWidth => 76.w;
  static double get categoryItemHeight => 58.h;

  static double get faqRadius => 16.r;
  static double get faqPadding => 14.w;

  static double get verifiedBadgeSize => 18.r;
  static double get favoriteButtonSize => 34.r;

  static double get rowGapSmall => 4.w;
  static double get rowGapMedium => 8.w;
  static double get rowGapLarge => 10.w;

  static double get starIconSize => 12.r;
  static double get smallIconSize => 10.r;
  static double get mediumIconSize => 14.r;
  static double get largeIconSize => 18.r;

  static List<BoxShadow> cardShadow() => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
}

import 'package:flutter/material.dart';

abstract class AppColors {
  // ---------------------------------------------------------------------------
  // Brightness signal (kept in sync from MyApp via AdaptiveTheme/Theme.of)
  // ---------------------------------------------------------------------------
  static Brightness brightness = Brightness.light;
  static bool get _isDark => brightness == Brightness.dark;

  // ---------------------------------------------------------------------------
  // Brand / fixed tokens
  // ---------------------------------------------------------------------------
  static const Color primary = Color(0xFF9B36D5);
  static const Color accent = purpleColor;

  static const Color scaffoldColorLight = Color(0xFFF8F8F8);
  static const Color cardColorLight = Color(0xFFffffff);
  static const Color textColorLight = Color(0xFF2B2B2B);
  static const Color greyTextColorLight = Color(0xFF555555);
  static const Color hintColorLight = Color(0xFFA5A5A5);
  static const Color borderColorLight = Color(0xFFE8E4E4);
  static const Color disableColorLight = Color(0xFFA6BBBE);
  static const Color inputBgLight = Color(0xFFF2F2F2);

  static const Color primaryDark = Color(0xFF645A9E);
  static const Color purpleColor = Color(0xFF5D5FEF);
  static const Color purpleColorLight = Color(0xFFE8E9FF);
  static const Color scaffoldColorDark = Color(0xFF121212);
  static const Color cardColorDark = Color(0xFF1E1E1E);
  static const Color textColorDark = Color(0xFFFFFFFF);
  static const Color greyTextColorDark = Color(0xFFB3B3B3);
  static const Color hintColorDark = Color(0xFF8C8C8C);
  static const Color borderColorDark = Color(0xFF333333);
  static const Color disableColorDark = Color(0xFF556E73);
  static const Color inputBgDark = Color(0xFF1C1C1C);

  static const Color red = Color(0xFFD00416);
  static const Color yellow = Color(0xFFFFD43B);
  static const Color green = Color(0xFF1FC16B);

  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static const Color statusBadge = Color(0xFFC89563);
  static const Color tabActive = primaryDark;
  static const Color starYellow = Color(0xFFFBB532);

  /// Trip details hero — company pill text/border (reference amber).
  static const Color tripDetailsHeroCompanyAccent = Color(0xFFFFB347);

  /// Trip details hero — compact rating star (reference #FFD700).
  static const Color tripDetailsHeroStarGold = Color(0xFFFFD700);

  /// Trip details hero — vertical gallery outer frame (teal tint).
  static const Color tripDetailsHeroGalleryFrame = Color(0xFF0A6B6B);

  /// Trip details stat icons (reference Material purple ~#9C27B0).
  static const Color tripDetailsStatIconPurple = Color(0xFF9C27B0);

  /// Trip details — secondary labels / overview body (reference #757575).
  static Color get tripDetailsSecondaryGrey =>
      _isDark ? greyTextColorDark : const Color(0xFF757575);

  /// Trip details "What's included" checkmark (reference #58C299).
  static const Color tripDetailsInclusionCheck = Color(0xFF58C299);

  /// Departure details row icons (Figma ref #8A2BE2).
  static const Color tripDetailsDepartureIconPurple = Color(0xFF8A2BE2);

  /// Map launcher chip on departure card (reference #F5F5F5).
  static const Color tripDetailsMapButtonBg = Color(0xFFF5F5F5);

  /// Google-style map glyph accent (reference Maps blue).
  static const Color tripDetailsMapIconBlue = Color(0xFF4285F4);

  /// Trip program meal code chips & checklist bullets (Figma ref #F9A825).
  static const Color tripDetailsProgramOrange = Color(0xFFF9A825);

  /// Trip program day header bar (reference #F5F5F5).
  static const Color tripDetailsProgramDayHeaderBar = Color(0xFFF5F5F5);

  // --- Trip details: Figma screenshot tokens (Departure + Program) ---
  /// Secondary labels (Figma #8E8E93).
  static const Color tripDetailsFigmaLabel = Color(0xFF8E8E93);

  /// Hairlines / card borders (Figma #E5E5EA).
  static const Color tripDetailsFigmaDivider = Color(0xFFE5E5EA);

  /// Primary titles & values on light cards (Figma #000000).
  static const Color tripDetailsFigmaBlack = Color(0xFF000000);

  /// Destination details grid — icon glyph (reference #9C27B0; light tint in dark).
  static Color get tripDetailsDestinationIconPurple =>
      _isDark ? const Color(0xFFE1BEE7) : const Color(0xFF9C27B0);

  /// Destination details grid — 32×32 icon tile fill (reference #F3E5F5).
  static Color get tripDetailsDestinationIconTileBg =>
      _isDark ? const Color(0xFF332742) : const Color(0xFFF3E5F5);

  static const Color infoBlue = Color(0xFF5B7FFF);
  static const Color linkBlue = Color(0xFF1976D2);
  static const Color burntOrange = Color(0xFFC93E27);
  static const Color neutralIcon = greyTextColorLight;
  static const Color cardPreviewStart = Color(0xFF1A1A2E);
  static const Color cardPreviewEnd = Color(0xFF16213E);
  static const Color scrim = Color(0xFF000000);
  static const Color onImage = Color(0xFFFFFFFF);
  static const Color shadow = Color(0xFF000000);

  static const Color error = red;
  static const Color success = green;
  static const Color warning = yellow;

  // Social buttons
  static const Color google = Color(0xFFDB4437);
  static const Color apple = Color(0xFF000000);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primary, primaryDark],
  );

  // ---------------------------------------------------------------------------
  // Theme-aware aliases used across feature widgets/screens.
  // These resolve based on [brightness] which is updated by MyApp on every
  // theme change, so screens repaint automatically when the toggle flips.
  // ---------------------------------------------------------------------------
  static Color get darkText => _isDark ? textColorDark : textColorLight;
  static Color get bodyText => _isDark ? textColorDark : textColorLight;
  static Color get greyText => _isDark ? greyTextColorDark : greyTextColorLight;
  static Color get secondaryText =>
      _isDark ? greyTextColorDark : greyTextColorLight;
  static Color get captionText => _isDark ? hintColorDark : hintColorLight;
  static Color get lightGreyText => _isDark ? hintColorDark : hintColorLight;
  static Color get tabInactive => _isDark ? hintColorDark : hintColorLight;
  static Color get onPrimary => _isDark ? textColorDark : cardColorLight;
  static Color get inverseText => _isDark ? textColorLight : textColorDark;

  static Color get border => _isDark ? borderColorDark : borderColorLight;
  static Color get inputBg => _isDark ? inputBgDark : inputBgLight;
  static Color get lightBg => inputBg;
  static Color get disabled => _isDark ? disableColorDark : disableColorLight;

  static Color get scaffoldBg =>
      _isDark ? scaffoldColorDark : scaffoldColorLight;
  static Color get background => _isDark ? cardColorDark : cardColorLight;
  static Color get cardBg => _isDark ? cardColorDark : cardColorLight;

  /// Trip details screen canvas (reference off-white #F8F9FA).
  static Color get tripDetailsScreenBg =>
      _isDark ? scaffoldColorDark : const Color(0xFFF8F9FA);

  /// Trending destination sheet / catalog controls (reference #E0E0E0).
  static const Color catalogSheetBorderLight = Color(0xFFE0E0E0);
  /// Secondary lines, meta text, strikethrough prices (reference #9E9E9E).
  static const Color catalogMetaMutedLight = Color(0xFF9E9E9E);

  static Color get catalogSheetBorder =>
      _isDark ? borderColorDark : catalogSheetBorderLight;
  static Color get catalogMetaMuted =>
      _isDark ? greyTextColorDark : catalogMetaMutedLight;
}

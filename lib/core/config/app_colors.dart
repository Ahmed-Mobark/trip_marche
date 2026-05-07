import 'package:flutter/material.dart';

abstract class AppColors {
  // ---------------------------------------------------------------------------
  // Brightness signal (kept in sync from MyApp via AdaptiveTheme/Theme.of)
  // ---------------------------------------------------------------------------
  static Brightness brightness = Brightness.light;
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  // ---------------------------------------------------------------------------
  // Brand / fixed tokens
  // ---------------------------------------------------------------------------
  static const Color primary = Color(0xFF9B36D5);
  static const Color accent = purpleColor;
  static const Color searchResultHeaderStart = Color(0xFF511C6F);
  static const Color searchResultCardInk = Color(0xFF28282A);
  static const Color searchResultMetaSlate = Color(0xFF556371);
  static const Color searchResultRecommendedOrange = Color(0xFFF9830D);
  static const Color searchResultBestPriceGreen = Color(0xFF10A94B);

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
  static const Color greyTextColorDarkOpacity50 = Color.fromARGB(
    212,
    251,
    250,
    247,
  );
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

  /// Trip details — secondary body / meta (readable on dark surfaces).
  static Color tripDetailsSecondaryGrey(BuildContext context) =>
      isDark(context) ? const Color(0xFFCECECE) : const Color(0xFF757575);

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

  /// Accordion day header — light grey in light mode, elevated surface in dark.
  static Color tripDetailsProgramHeaderBg(BuildContext context) =>
      isDark(context)
      ? const Color(0xFF2C2C2C)
      : tripDetailsProgramDayHeaderBar;

  /// Hairlines inside trip-details cards (light divider vs dark border).
  static Color tripDetailsHairline(BuildContext context) =>
      isDark(context) ? borderColorDark : tripDetailsFigmaDivider;

  // --- Trip details: Figma screenshot tokens (Departure + Program) ---
  /// Secondary labels (Figma #8E8E93).
  static const Color tripDetailsFigmaLabel = Color(0xFF8E8E93);

  /// Hairlines / card borders (Figma #E5E5EA).
  static const Color tripDetailsFigmaDivider = Color(0xFFE5E5EA);

  /// Primary titles & values on light cards (Figma #000000).
  static const Color tripDetailsFigmaBlack = Color(0xFF000000);

  /// Destination details grid — icon glyph (reference #9C27B0; light tint in dark).
  static Color tripDetailsDestinationIconPurple(BuildContext context) =>
      isDark(context) ? const Color(0xFFE1BEE7) : const Color(0xFF9C27B0);

  /// Destination details grid — 32×32 icon tile fill (reference #F3E5F5).
  static Color tripDetailsDestinationIconTileBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF332742) : const Color(0xFFF3E5F5);

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
  static Color darkText(BuildContext context) =>
      isDark(context) ? textColorDark : textColorLight;

  static Color bodyText(BuildContext context) =>
      isDark(context) ? textColorDark : textColorLight;

  static Color greyText(BuildContext context) =>
      isDark(context) ? greyTextColorDark : greyTextColorLight;

  static Color secondaryText(BuildContext context) =>
      isDark(context) ? greyTextColorDark : greyTextColorLight;

  static Color captionText(BuildContext context) =>
      isDark(context) ? hintColorDark : hintColorLight;

  static Color lightGreyText(BuildContext context) =>
      isDark(context) ? hintColorDark : hintColorLight;

  static Color tabInactive(BuildContext context) =>
      isDark(context) ? hintColorDark : hintColorLight;

  static Color onPrimary(BuildContext context) =>
      isDark(context) ? textColorDark : cardColorLight;

  static Color inverseText(BuildContext context) =>
      isDark(context) ? textColorLight : textColorDark;

  static Color border(BuildContext context) =>
      isDark(context) ? borderColorDark : borderColorLight;

  static Color inputBg(BuildContext context) =>
      isDark(context) ? inputBgDark : inputBgLight;

  static Color lightBg(BuildContext context) => inputBg(context);

  static Color disabled(BuildContext context) =>
      isDark(context) ? disableColorDark : disableColorLight;

  static Color scaffoldBg(BuildContext context) =>
      isDark(context) ? scaffoldColorDark : scaffoldColorLight;

  static Color background(BuildContext context) =>
      isDark(context) ? cardColorDark : cardColorLight;

  static Color cardBg(BuildContext context) =>
      isDark(context) ? cardColorDark : cardColorLight;

  /// Trip details screen canvas (reference off-white #F8F9FA).
  static Color tripDetailsScreenBg(BuildContext context) =>
      isDark(context) ? scaffoldColorDark : const Color(0xFFF8F9FA);

  /// Trending destination sheet / catalog controls (reference #E0E0E0).
  static const Color catalogSheetBorderLight = Color(0xFFE0E0E0);

  /// Secondary lines, meta text, strikethrough prices (reference #9E9E9E).
  static const Color catalogMetaMutedLight = Color(0xFF9E9E9E);

  static Color catalogSheetBorder(BuildContext context) =>
      isDark(context) ? borderColorDark : catalogSheetBorderLight;

  static Color catalogMetaMuted(BuildContext context) =>
      isDark(context) ? const Color(0xFFCCCCCC) : catalogMetaMutedLight;

  // --- My Trips (Figma / design QA — light reference; dark fallbacks) ---
  /// Header gradient top (Figma ref #8E24AA).
  static const Color myTripsHeaderGradientStart = Color(0xFF8E24AA);
  static const Color myTripsHeaderGradientEnd = Color(0xFFAB47BC);

  /// Primary purple for tabs + primary buttons on this screen (Figma #9C27B0).
  static const Color myTripsPrimary = Color(0xFF9C27B0);
  static const Color myTripsBadgeActive = Color(0xFF4CAF50);
  static const Color myTripsBadgePast = Color(0xFFFF5252);
  static const Color myTripsBadgeCanceled = Color(0xFF9E9E9E);
  static const Color myTripsBorderFigma = Color(0xFFE0E0E0);
  static const Color myTripsMetaGrey = Color(0xFF757575);
  static const Color myTripsPdfIcon = Color(0xFFD00416);

  /// List / canvas behind cards (Figma #F8F8F8).
  static Color myTripsListBackground(BuildContext context) =>
      isDark(context) ? const Color(0xFF1A1A1A) : const Color(0xFFF8F8F8);

  /// Secondary outline button: white surface in light (Figma).
  static Color myTripsOutlineButtonFill(BuildContext context) =>
      isDark(context) ? cardColorDark : white;

  static Color myTripsOutlineButtonBorder(BuildContext context) =>
      isDark(context) ? borderColorDark : black;

  static Color myTripsOutlineButtonText(BuildContext context) =>
      isDark(context) ? textColorDark : black;

  /// "View Receipt" — thin **grey** stroke in Figma (not black).
  static Color myTripsSecondaryButtonBorder(BuildContext context) =>
      isDark(context) ? borderColorDark : myTripsBorderFigma;

  /// Favorite chip on card (Figma: light grey circle + shadow).
  static Color myTripsFavoriteCircleFill(BuildContext context) =>
      isDark(context) ? cardColorDark : inputBgLight;

  /// My Trips trip card — outer border (Figma #EEEEEE).
  static Color myTripsCardBorderHairline(BuildContext context) =>
      isDark(context) ? borderColorDark : const Color(0xFFEEEEEE);

  /// My Trips trip card — title + rating value (Figma #212121).
  static Color myTripsCardTitle(BuildContext context) =>
      isDark(context) ? textColorDark : const Color(0xFF212121);

  /// My Trips trip card — location, date, pin/calendar icons (Figma #546E7A).
  static Color myTripsCardSlate(BuildContext context) =>
      isDark(context) ? greyTextColorDark : const Color(0xFF546E7A);

  /// My Trips trip card — favorite heart (Figma #E91E63).
  static const Color myTripsCardHeartPink = Color(0xFFE91E63);

  /// My Trips trip card — star (Figma #FFB300).
  static const Color myTripsCardStarAmber = Color(0xFFFFB300);

  /// My Trips trip card — review count (Figma #9E9E9E).
  static Color myTripsCardReviewCount(BuildContext context) =>
      isDark(context) ? greyTextColorDark : const Color(0xFF9E9E9E);

  // --- My Trips trip card — pixel Figma frame (tailwind-scale ref) ---
  /// Primary CTA fill (#9333EA).
  static const Color myTripsTripCardPurple = Color(0xFF9333EA);

  /// "Active" pill (#4ADE80).
  static const Color myTripsTripCardBadgeGreen = Color(0xFF4ADE80);

  /// Heart + PDF (#EF4444).
  static const Color myTripsTripCardRed = Color(0xFFEF4444);

  /// Star (#FBBF24).
  static const Color myTripsTripCardStar = Color(0xFFFBBF24);

  /// Secondary lines (location, date, review count) (#6B7280).
  static Color myTripsTripCardMuted(BuildContext context) =>
      isDark(context) ? greyTextColorDark : const Color(0xFF6B7280);

  /// Card / outline stroke (#E5E7EB).
  static Color myTripsTripCardBorder(BuildContext context) =>
      isDark(context) ? borderColorDark : const Color(0xFFE5E7EB);

  /// Title + rating value — black.
  static Color myTripsTripCardInk(BuildContext context) =>
      isDark(context) ? textColorDark : const Color(0xFF000000);

  /// Favorite circle fill (off-white).
  static Color myTripsTripCardFavoriteFill(BuildContext context) =>
      isDark(context) ? const Color(0xFF2C2C2C) : const Color(0xFFF3F4F6);
}

import 'package:flutter/material.dart';
import 'package:trip_marche/core/config/styles/font_utils.dart';
import 'package:trip_marche/core/theme/app_colors.dart';

/// Purple gradient + title row used on My Trips and Wishlist (Figma parity).
///
/// Metrics mirror `MyTripsFigmaTokens` header padding and typography (fixed dp).
class GradientSheetScreenHeader extends StatelessWidget {
  const GradientSheetScreenHeader({
    super.key,
    required this.title,
  });

  final String title;

  /// Overlap of the white sheet into the header (matches My Trips).
  static const double sheetOverlapUp = 16;

  /// Top corner radius of the sheet below the header.
  static const double sheetTopRadius = 32;

  static const double _padH = 16;
  static const double _padTop = 8;
  static const double _padBottom = 24;
  static const double _titleFontSize = 24;
  static const double _titleLineHeight = 1.2;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.myTripsHeaderGradientStart,
            AppColors.myTripsHeaderGradientEnd,
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            start: _padH,
            top: _padTop,
            end: _padH,
            bottom: _padBottom,
          ),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              title,
              style: TextStyle(
                fontFamily: AppFont.fontFamily,
                fontSize: _titleFontSize,
                fontWeight: FontWeight.w700,
                height: _titleLineHeight,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

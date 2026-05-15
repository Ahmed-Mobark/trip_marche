import 'package:flutter/material.dart';

/// Bottom nav tokens — Figma **Frame70** (`1:24923`) on handoff frame **430**.
class NavBarHandoffTokens {
  NavBarHandoffTokens._(this._screenW);

  final double _screenW;

  static const double kFigmaFrameW = 430;

  /// Top hairline under indicator strip (`#E1DBE4`).
  static const Color borderTop = Color(0xFFE1DBE4);

  double w(double figmaPx) => figmaPx * _screenW / kFigmaFrameW;

  static NavBarHandoffTokens of(BuildContext context) =>
      NavBarHandoffTokens._(MediaQuery.sizeOf(context).width);

  static List<BoxShadow> topShadow() => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 4.5,
          offset: const Offset(0, -5),
        ),
      ];
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Nav tab glyph — full-icon tint via [BlendMode.srcIn] (stroke + fill).
///
/// Uses [AnimatedSwitcher] for a short fade when active/inactive changes.
class NavBarSvgIcon extends StatelessWidget {
  const NavBarSvgIcon({
    super.key,
    required this.assetPath,
    required this.selected,
    required this.primaryColor,
    required this.inactiveColor,
    required this.size,
  });

  final String assetPath;
  final bool selected;
  final Color primaryColor;
  final Color inactiveColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = selected ? primaryColor : inactiveColor;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeOutCubic,
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: SvgPicture.asset(
        assetPath,
        key: ValueKey<bool>(selected),
        width: size,
        height: size,
        fit: BoxFit.contain,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}

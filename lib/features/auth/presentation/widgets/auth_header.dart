import 'package:flutter/material.dart';
import 'package:trip_marche/core/theme/app_colors.dart';

class AuthHeader extends StatelessWidget {
  final Widget child;
  final bool showIllustration;

  const AuthHeader({
    super.key,
    this.showIllustration = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          // Logo — exported SVG from Figma
          if (showIllustration) Image.asset('assets/icons/llo.png', width: 160),
          // Illustration area — exported PNG from Figma
          SizedBox(height: 12),
          if (showIllustration)
            SizedBox(
              height: 140,
              child: Image.asset(
                'assets/images/login_illustration.png',
                fit: BoxFit.contain,
              ),
            )
          else
            const SizedBox(height: 30),
          // White content area with Figma curve
          Expanded(
            child: Stack(
              children: [
                ClipPath(
                  clipper: _AuthCurveClipper(),
                  child: Container(width: double.infinity, color: Colors.white),
                ),
                Padding(padding: const EdgeInsets.only(top: 90), child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Clips with the exact curve from Figma design:
/// M430 831H0V0C0 89.54 64.5 92.68 64.5 92.68L376.72 96.85C406.26 97.25 430 121.3 430 150.85V831Z
class _AuthCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final sx = w / 430;
    final sy = h / 831;

    final path = Path();
    path.moveTo(0, 0);
    path.cubicTo(0, 89.54 * sy, 64.5 * sx, 92.68 * sy, 64.5 * sx, 92.68 * sy);
    path.lineTo(376.72 * sx, 96.85 * sy);
    path.cubicTo(406.26 * sx, 97.25 * sy, w, 121.3 * sy, w, 150.85 * sy);
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

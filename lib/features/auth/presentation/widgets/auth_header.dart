import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/config/app_icons.dart';

class AuthHeader extends StatelessWidget {
  final Widget child;
  final bool showIllustration;
  final String? illustration;

  /// When true, the entire header + content scroll together.
  /// Use this for screens where you want the header to scroll with the body.
  final bool scrollable;

  /// When [showIllustration] is false: show a compact purple bar with back (left) + logo (right).
  final bool compactTopBar;

  /// Back action for [compactTopBar]. Defaults to [Navigator.maybePop].
  final VoidCallback? onBack;

  const AuthHeader({
    super.key,
    this.showIllustration = true,
    required this.child,
    this.illustration,
    this.scrollable = false,
    this.compactTopBar = false,
    this.onBack,
  });

  Widget _buildTop(BuildContext context) {
    if (showIllustration) {
      return Column(
        children: [
          Image.asset(AppIcons.lloPng, width: 160),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: illustration != null
                ? AppIcons.icon(icon: illustration!, size: 150.w)
                : AppIcons.icon(icon: AppIcons.authIllustration, size: 150.w),
          ),
        ],
      );
    }

    if (compactTopBar) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                  onPressed: onBack ?? () => Navigator.maybePop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const Spacer(),
                Image.asset(
                  AppIcons.lloPng,
                  height: 28,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
        ],
      );
    }

    return const SizedBox(height: 30);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary],
        ),
      ),
      child: scrollable
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  _buildTop(context),
                  ClipPath(
                    clipper: _AuthCurveClipper(),
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                _buildTop(context),
                // White content area with Figma curve
                Expanded(
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: _AuthCurveClipper(),
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: child,
                      ),
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

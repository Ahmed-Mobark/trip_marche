import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    this.iconColor,
    required this.onTap,
    this.diameter,
    this.iconSize,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.blurredBackground = false,
  });

  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final double? diameter;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final bool blurredBackground;

  @override
  Widget build(BuildContext context) {
    final d = diameter ?? 40.r;
    final iSize = iconSize ?? (d * 0.42);
    final fill = backgroundColor ?? AppColors.shadow.withValues(alpha: 0.3);
    final bw = borderWidth ?? 1;

    Widget circle = DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: fill,
        border: borderColor != null
            ? Border.all(color: borderColor!, width: bw)
            : null,
      ),
      child: SizedBox(
        width: d,
        height: d,
        child: Icon(
          icon,
          color: iconColor ?? AppColors.onImage,
          size: iSize,
        ),
      ),
    );

    if (blurredBackground) {
      circle = ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: circle,
        ),
      );
    }

    return Material(
      color: AppColors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: circle,
      ),
    );
  }
}

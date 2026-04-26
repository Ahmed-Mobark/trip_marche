import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';

class TripDetailsInfoCard extends StatelessWidget {
  const TripDetailsInfoCard({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.withShadow = true,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? borderColor;
  final bool withShadow;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? 24.r;

    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsetsDirectional.all(20.r),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: (borderColor ?? AppColors.border).withValues(alpha: 0.6),
        ),
        boxShadow: withShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 22.r,
                  offset: Offset(0, 10.h),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}

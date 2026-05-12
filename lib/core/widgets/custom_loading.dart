import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';

/// App loading indicator — brand logo in center with a spinning arc around it.
class CustomLoading extends StatelessWidget {
  final double? size;
  final double? top;
  final double? bottom;
  final Color? color;
  final double? strokeWidth;

  const CustomLoading({
    this.strokeWidth,
    this.top,
    this.bottom,
    this.size,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final outerSize = size?.w ?? 68.w;
    final logoSize = outerSize * 0.55;
    final stroke = strokeWidth?.r ?? 4.r;
    final indicatorColor = color ?? AppColors.primary;

    return Padding(
      padding: EdgeInsets.only(top: top?.h ?? 0, bottom: bottom?.h ?? 0),
      child: Center(
        child: SizedBox(
          width: outerSize,
          height: outerSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: outerSize,
                height: outerSize,
                child: CircularProgressIndicator(
                  color: indicatorColor,
                  strokeWidth: stroke,
                ),
              ),
              Image.asset(
                'assets/icons/load.png',
                width: logoSize,
                height: logoSize,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

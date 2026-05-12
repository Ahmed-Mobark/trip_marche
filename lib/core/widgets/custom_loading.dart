import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';

/// App loading indicator — brand logo in center with a spinning arc around it.
class CustomLoading extends StatefulWidget {
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
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outerSize = widget.size?.w ?? 48.w;
    final logoSize = outerSize * 0.52;
    final stroke = widget.strokeWidth?.r ?? 2.5.r;
    final indicatorColor = widget.color ?? AppColors.primary;

    return Padding(
      padding: EdgeInsets.only(
        top: widget.top?.h ?? 0,
        bottom: widget.bottom?.h ?? 0,
      ),
      child: Center(
        child: SizedBox(
          width: outerSize,
          height: outerSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              RotationTransition(
                turns: _controller,
                child: SizedBox(
                  width: outerSize,
                  height: outerSize,
                  child: CircularProgressIndicator(
                    color: indicatorColor,
                    strokeWidth: stroke,
                    strokeCap: StrokeCap.round,
                  ),
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

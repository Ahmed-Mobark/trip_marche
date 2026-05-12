import 'dart:math' as math;
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
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outerSize = widget.size?.w ?? 68.w;
    final logoSize = outerSize * 0.55;
    final stroke = widget.strokeWidth?.r ?? 4.r;
    final arcColor = widget.color ?? AppColors.primary;

    return Padding(
      padding: EdgeInsets.only(
        top: widget.top?.h ?? 0,
        bottom: widget.bottom?.h ?? 0,
      ),
      child: Center(
        child: SizedBox(
          width: outerSize,
          height: outerSize,
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (context, child) {
              return CustomPaint(
                painter: _ArcPainter(
                  progress: _ctrl.value,
                  color: arcColor,
                  strokeWidth: stroke,
                ),
                child: child,
              );
            },
            child: Center(
              child: Image.asset(
                'assets/icons/load.png',
                width: logoSize,
                height: logoSize,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  _ArcPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Offset(strokeWidth / 2, strokeWidth / 2) &
        Size(size.width - strokeWidth, size.height - strokeWidth);

    final startAngle = progress * 2 * math.pi;
    const sweepAngle = 1.2 * math.pi;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(_ArcPainter old) => old.progress != progress;
}

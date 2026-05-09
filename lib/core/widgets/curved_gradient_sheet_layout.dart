import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

/// Purple gradient background with a centered app title and a white curved sheet
/// overlapping the header (Search Result / filter-results style).
class CurvedGradientSheetLayout extends StatelessWidget {
  const CurvedGradientSheetLayout({
    super.key,
    required this.headerTitle,
    required this.sheetChild,
    this.onBack,
    this.curveRadius,
  });

  final String headerTitle;
  final Widget sheetChild;
  final VoidCallback? onBack;

  /// Top corner radius of the white sheet; defaults to ~30 logical px (scaled).
  final double? curveRadius;

  @override
  Widget build(BuildContext context) {
    final r = curveRadius ?? 30.r;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(gradient: AppColors.primaryGradient),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _CurvedSheetHeader(
                title: headerTitle,
                onBack: onBack ?? () => Navigator.maybePop(context),
              ),
              Expanded(
                child: _CurvedSheetSurface(radius: r, child: sheetChild),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CurvedSheetHeader extends StatelessWidget {
  const _CurvedSheetHeader({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(2.w, 6.h, 8.w, 8.h),
        child: SizedBox(
          height: 48.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: IconButton(
                  onPressed: onBack,
                  visualDensity: VisualDensity.compact,
                  style: IconButton.styleFrom(
                    foregroundColor: AppColors.onImage,
                  ),
                  icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 56.w),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading2(
                    color: AppColors.onImage,
                  ).copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurvedSheetSurface extends StatelessWidget {
  const _CurvedSheetSurface({required this.radius, required this.child});

  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final sheetColor = AppColors.cardBg(context);
    final topRadius = BorderRadius.vertical(top: Radius.circular(radius));
    return Container(
      decoration: BoxDecoration(
        color: sheetColor,
        borderRadius: topRadius,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.07),
            blurRadius: 18,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: ClipRRect(borderRadius: topRadius, child: child),
    );
  }
}

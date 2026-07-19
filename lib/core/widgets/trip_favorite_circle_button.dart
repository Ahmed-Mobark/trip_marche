import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';

/// Flat grey circle + heart (no elevation on the circle); slight depth on the glyph.
class TripFavoriteCircleButton extends StatelessWidget {
  const TripFavoriteCircleButton({
    super.key,
    required this.isFavorite,
    required this.onTap,
    this.diameter = 36,
    this.iconSize = 18,
  });

  final bool isFavorite;
  final VoidCallback onTap;
  final double diameter;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final iconData = isFavorite ? Icons.favorite : Icons.favorite_border;
    final iconColor = isFavorite ? Colors.red : AppColors.greyText(context);
    final d = diameter.w;
    final s = iconSize.sp;

    return Material(
      color: AppColors.inputBg(context),
      shape: const CircleBorder(),
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: d,
          height: d,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Transform.translate(
                  offset: Offset(0, 1.2.h),
                  child: Icon(
                    iconData,
                    size: s,
                    color: AppColors.shadow.withValues(alpha: 0.14),
                  ),
                ),
                Icon(
                  iconData,
                  size: s,
                  color: iconColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

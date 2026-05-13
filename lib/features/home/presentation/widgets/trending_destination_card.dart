import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_cached_network_image.dart';

class TrendingDestinationCard extends StatelessWidget {
  const TrendingDestinationCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.rank,
    this.onTap,
    this.width,
    this.height,
  });

  final String name;
  final String imageUrl;
  final int rank;
  final VoidCallback? onTap;

  /// When set (e.g. grid), fills the cell; otherwise uses the home rail size.
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final w = width ?? 102.w;
    final h = height ?? 120.h;
    final useGridMargin = width != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w,
        height: h,
        margin: useGridMargin
            ? EdgeInsets.zero
            : EdgeInsetsDirectional.only(end: 6.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.inputBg(context),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            children: [
              Positioned.fill(
                child: AppCachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              PositionedDirectional(
                start: 10.w,
                top: 0.h,
                child: _RankRibbon(rank: rank),
              ),
              PositionedDirectional(
                start: 0,
                end: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsetsDirectional.only(
                    start: 4.w,
                    end: 4.w,
                    top: 18.h,
                    bottom: 8.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.shadow.withValues(alpha: 0.0),
                        AppColors.shadow.withValues(alpha: 0.45),
                        AppColors.shadow.withValues(alpha: 0.7),
                      ],
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                  child: Text(
                    // Force each word onto its own line so multi-word city
                    // names (e.g. "New York", "Rio de Janeiro", "نيو يورك")
                    // are fully visible stacked vertically.
                    name.trim(),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subtitle(color: AppColors.onImage)
                        .copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.15,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RankRibbon extends StatelessWidget {
  const _RankRibbon({required this.rank});

  final int rank;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34.w,
      height: 34.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Image.asset(AppIcons.bookIcon, fit: BoxFit.contain),
          ),
          Text(
            '#$rank',
            style: AppTextStyles.bodySmall(
              color: AppColors.onImage,
            ).copyWith(fontWeight: FontWeight.w900, fontSize: 11.sp, height: 1),
          ),
        ],
      ),
    );
  }
}

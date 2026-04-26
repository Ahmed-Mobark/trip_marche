import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import '../cubit/trip_details_cubit.dart';
import '../cubit/trip_details_state.dart';
import 'circle_icon_button.dart';

class TripDetailsHeroHeader extends StatelessWidget {
  const TripDetailsHeroHeader({super.key});

  static const String _heroUrl =
      'https://images.unsplash.com/photo-1539635278303-d4002c07eae3?w=800';
  static const List<String> _thumbUrls = <String>[
    'https://images.unsplash.com/photo-1539635278303-d4002c07eae3?w=200',
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=200',
    'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=200',
  ];

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;
    final heroHeight = 380.h;

    /// Deep bottom curve on the hero (design ~40–50 logical px); scales with [ScreenUtil].
    final bottomRadius = 44.r;
    final thumbSize = 56.r;

    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(bottomRadius),
        bottomRight: Radius.circular(bottomRadius),
      ),
      child: SizedBox(
        height: heroHeight,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const ColoredBox(
              color: AppColors.lightBg,
              child: AppCachedNetworkImage(
                imageUrl: _heroUrl,
                fit: BoxFit.cover,
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.25),
                    Colors.black.withValues(alpha: 0.65),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              top: topPad + 8.h,
              start: 16.w,
              child: CircleIconButton(
                icon: Iconsax.arrow_left,
                onTap: () => Navigator.pop(context),
              ),
            ),
            PositionedDirectional(
              top: topPad + 8.h,
              end: 16.w,
              child: CircleIconButton(icon: Iconsax.share, onTap: () {}),
            ),
            BlocBuilder<TripDetailsCubit, TripDetailsState>(
              builder: (context, state) {
                return PositionedDirectional(
                  top: topPad + 8.h,
                  end: 16.w + 44.w,
                  child: CircleIconButton(
                    icon: state.isFavorite ? Iconsax.heart5 : Iconsax.heart,
                    iconColor: state.isFavorite
                        ? AppColors.error
                        : Colors.white,
                    onTap: context.read<TripDetailsCubit>().toggleFavorite,
                  ),
                );
              },
            ),
            PositionedDirectional(
              start: 16.w,
              end: 16.w,
              bottom: 20.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.tr.tripDetailsTitle,
                          style: AppTextStyles.heading2(color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(
                              Iconsax.star1,
                              color: AppColors.starYellow,
                              size: 16.sp,
                            ),
                            SizedBox(width: 6.w),
                            Expanded(
                              child: Text(
                                context.tr.tripDetailsHeroRatingLine,
                                style: AppTextStyles.bodySmall(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Icon(
                              Iconsax.location,
                              color: Colors.white,
                              size: 16.sp,
                            ),
                            SizedBox(width: 6.w),
                            Expanded(
                              child: Text(
                                context.tr.tripDetailsHeroLocationShort,
                                style: AppTextStyles.bodySmall(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.45),
                            borderRadius: BorderRadius.circular(999.r),
                          ),
                          child: Text(
                            context.tr.tripDetailsHeroDaysBadge,
                            style: AppTextStyles.caption(color: Colors.white)
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var i = 0; i < _thumbUrls.length; i++) ...[
                        if (i > 0) SizedBox(height: 8.h),
                        _ThumbTile(
                          url: _thumbUrls[i],
                          size: thumbSize,
                          showMoreOverlay: i == _thumbUrls.length - 1,
                          moreLabel: context.tr.tripDetailsGalleryMoreCount(
                            '8',
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThumbTile extends StatelessWidget {
  const _ThumbTile({
    required this.url,
    required this.size,
    required this.showMoreOverlay,
    required this.moreLabel,
  });

  final String url;
  final double size;
  final bool showMoreOverlay;
  final String moreLabel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppCachedNetworkImage(imageUrl: url, fit: BoxFit.cover),
            if (showMoreOverlay)
              ColoredBox(
                color: Colors.black.withValues(alpha: 0.55),
                child: Center(
                  child: Text(
                    moreLabel,
                    style: AppTextStyles.bodyMedium(
                      color: Colors.white,
                    ).copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

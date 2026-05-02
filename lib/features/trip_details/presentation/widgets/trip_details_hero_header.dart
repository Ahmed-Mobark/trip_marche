import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import 'package:trip_marche/core/widgets/app_image_gallery_screen.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import '../cubit/trip_details_cubit.dart';
import '../cubit/trip_details_state.dart';
import '../trip_wishlist_pop_result.dart';
import 'circle_icon_button.dart';

class TripDetailsHeroHeader extends StatelessWidget {
  const TripDetailsHeroHeader({super.key, required this.trip});

  final TripDetails trip;

  static const String _fallbackHeroUrl =
      'https://images.unsplash.com/photo-1539635278303-d4002c07eae3?w=800';

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;
    final heroHeight = 380.h;
    final bottomRadius = 44.r;
    final thumbSize = 56.r;

    final gallery = trip.galleryImageUrls;
    final heroUrl =
        trip.primaryHeroImageUrl.isNotEmpty ? trip.primaryHeroImageUrl : _fallbackHeroUrl;
    final viewerUrls = gallery.isNotEmpty ? gallery : <String>[heroUrl];

    final restAfterHero = gallery.length > 1 ? gallery.skip(1).toList() : <String>[];
    final thumbUrls = restAfterHero.take(3).toList();
    final extraCount = restAfterHero.length > thumbUrls.length
        ? restAfterHero.length - thumbUrls.length
        : 0;

    final locationLine = trip.fromLocation.isNotEmpty
        ? trip.fromLocation
        : (trip.destination?.name ?? trip.country);

    final ratingLine =
        '${trip.rating.toStringAsFixed(2)} · ${context.tr.tripDetailsReviewsCount(trip.reviewsCount)}';

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
            ColoredBox(
              color: AppColors.lightBg,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => AppImageGalleryScreen.open(
                  context,
                  imageUrls: viewerUrls,
                  initialIndex: 0,
                ),
                child: AppCachedNetworkImage(
                  imageUrl: heroUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.shadow.withValues(alpha: 0.25),
                    AppColors.shadow.withValues(alpha: 0.65),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              top: topPad + 8.h,
              start: 16.w,
              child: CircleIconButton(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () {
                  final cubit = context.read<TripDetailsCubit>();
                  Navigator.pop(
                    context,
                    TripWishlistPopResult(
                      tripId: cubit.tripId,
                      isWishlisted: cubit.state.isFavorite,
                    ),
                  );
                },
              ),
            ),
            PositionedDirectional(
              top: topPad + 8.h,
              end: 16.w,
              child: CircleIconButton(icon: Iconsax.share, onTap: () {}),
            ),
            BlocBuilder<TripDetailsCubit, TripDetailsState>(
              buildWhen: (p, n) =>
                  p.isFavorite != n.isFavorite ||
                  p.wishlistToggling != n.wishlistToggling,
              builder: (context, state) {
                return PositionedDirectional(
                  top: topPad + 8.h,
                  end: 16.w + 44.w,
                  child: Opacity(
                    opacity: state.wishlistToggling ? 0.55 : 1,
                    child: CircleIconButton(
                      icon: state.isFavorite ? Iconsax.heart5 : Iconsax.heart,
                      iconColor: state.isFavorite
                          ? AppColors.error
                          : AppColors.onImage,
                      onTap: state.wishlistToggling
                          ? null
                          : context.read<TripDetailsCubit>().toggleWishlist,
                    ),
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
                          trip.title,
                          style: AppTextStyles.heading2(
                            color: AppColors.onImage,
                          ),
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
                                ratingLine,
                                style: AppTextStyles.bodySmall(
                                  color: AppColors.onImage,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Icon(
                              Iconsax.location,
                              color: AppColors.onImage,
                              size: 16.sp,
                            ),
                            SizedBox(width: 6.w),
                            Expanded(
                              child: Text(
                                locationLine,
                                style: AppTextStyles.bodySmall(
                                  color: AppColors.onImage,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        if (trip.badge != null && trip.badge!.isNotEmpty)
                          Container(
                            padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.shadow.withValues(alpha: 0.45),
                              borderRadius: BorderRadius.circular(999.r),
                            ),
                            child: Text(
                              trip.badge!,
                              style: AppTextStyles.caption(
                                color: AppColors.onImage,
                              ).copyWith(fontWeight: FontWeight.w700),
                            ),
                          )
                        else
                          Container(
                            padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.shadow.withValues(alpha: 0.45),
                              borderRadius: BorderRadius.circular(999.r),
                            ),
                            child: Text(
                              '${trip.durationDays} ${context.tr.tripDetailsDurationUnit}',
                              style: AppTextStyles.caption(
                                color: AppColors.onImage,
                              ).copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (thumbUrls.isNotEmpty) ...[
                    SizedBox(width: 12.w),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var i = 0; i < thumbUrls.length; i++) ...[
                          if (i > 0) SizedBox(height: 8.h),
                          _ThumbTile(
                            url: thumbUrls[i],
                            size: thumbSize,
                            showMoreOverlay:
                                i == thumbUrls.length - 1 && extraCount > 0,
                            moreLabel:
                                context.tr.tripDetailsGalleryMoreCount('$extraCount'),
                            onTap: () => AppImageGalleryScreen.open(
                              context,
                              imageUrls: viewerUrls,
                              initialIndex: i + 1,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
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
    required this.onTap,
  });

  final String url;
  final double size;
  final bool showMoreOverlay;
  final String moreLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: ClipRRect(
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
                    color: AppColors.shadow.withValues(alpha: 0.55),
                    child: Center(
                      child: Text(
                        moreLabel,
                        style: AppTextStyles.bodyMedium(
                          color: AppColors.onImage,
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

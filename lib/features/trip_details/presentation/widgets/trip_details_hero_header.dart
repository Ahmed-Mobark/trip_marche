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
import 'package:trip_marche/features/trip_details/presentation/trip_details_ui_formatters.dart';
import '../cubit/trip_details_cubit.dart';
import '../cubit/trip_details_state.dart';
import '../trip_wishlist_pop_result.dart';
import 'circle_icon_button.dart';

class TripDetailsHeroHeader extends StatelessWidget {
  const TripDetailsHeroHeader({super.key, required this.trip});

  final TripDetails trip;

  static const String _fallbackHeroUrl =
      'https://images.unsplash.com/photo-1539635278303-d4002c07eae3?w=800';

  static final Color _frostFill = AppColors.onImage.withValues(alpha: 0.22);
  static final Color _frostBorder = AppColors.onImage.withValues(alpha: 0.38);

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;
    final heroHeight = 428.h;
    final bottomRadius = 40.r;
    final thumbInner = 72.r;
    final framePad = 3.r;
    final thumbOuter = thumbInner + framePad * 2;

    final gallery = trip.galleryImageUrls;
    final heroUrl = trip.primaryHeroImageUrl.isNotEmpty
        ? trip.primaryHeroImageUrl
        : _fallbackHeroUrl;
    final viewerUrls = gallery.isNotEmpty ? gallery : <String>[heroUrl];

    final restAfterHero = gallery.length > 1
        ? gallery.skip(1).toList()
        : <String>[];
    final thumbUrls = restAfterHero.take(3).toList();
    final extraCount = restAfterHero.length > thumbUrls.length
        ? restAfterHero.length - thumbUrls.length
        : 0;

    final countryTag = (trip.destination?.country ?? trip.country).trim();
    final dateRange = TripDetailsUiFormatters.heroTripDateRange(
      context,
      trip.startDate,
      trip.endDate,
    );
    final companyName = (trip.vendor.company?.trim().isNotEmpty ?? false)
        ? trip.vendor.company!.trim()
        : trip.vendor.name.trim();
    final showCompany = companyName.isNotEmpty;
    final fromLine = trip.fromLocation.trim();
    final showFrom = fromLine.isNotEmpty;
    final ratingText = trip.rating.toStringAsFixed(1);

    final actionDiameter = 48.r;
    final actionGap = 8.w;
    final horizontalInset = 24.w;
    final topBarTop = topPad + 12.h;

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
                  stops: const [0.0, 0.42, 1.0],
                  colors: [
                    AppColors.shadow.withValues(alpha: 0.1),
                    AppColors.shadow.withValues(alpha: 0.28),
                    AppColors.shadow.withValues(alpha: 0.74),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              top: topBarTop,
              start: horizontalInset,
              child: CircleIconButton(
                diameter: actionDiameter,
                iconSize: 20.sp,
                backgroundColor: AppColors.shadow.withValues(alpha: 0.35),
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
              top: topBarTop,
              end: horizontalInset,
              child: CircleIconButton(
                diameter: actionDiameter,
                iconSize: 22.sp,
                icon: Iconsax.share,
                backgroundColor: _frostFill,
                borderColor: _frostBorder,
                blurredBackground: true,
                onTap: () {},
              ),
            ),
            BlocBuilder<TripDetailsCubit, TripDetailsState>(
              buildWhen: (p, n) =>
                  p.isFavorite != n.isFavorite ||
                  p.wishlistToggling != n.wishlistToggling,
              builder: (context, state) {
                return PositionedDirectional(
                  top: topBarTop,
                  end: horizontalInset + actionDiameter + actionGap,
                  child: Opacity(
                    opacity: state.wishlistToggling ? 0.55 : 1,
                    child: CircleIconButton(
                      diameter: actionDiameter,
                      iconSize: 22.sp,
                      icon: state.isFavorite ? Iconsax.heart5 : Iconsax.heart,
                      iconColor: AppColors.red,
                      backgroundColor: _frostFill,
                      borderColor: _frostBorder,
                      blurredBackground: true,
                      onTap: state.wishlistToggling
                          ? null
                          : context.read<TripDetailsCubit>().toggleWishlist,
                    ),
                  ),
                );
              },
            ),
            PositionedDirectional(
              start: horizontalInset,
              end: horizontalInset,
              bottom: 36.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (countryTag.isNotEmpty) ...[
                          _CountryTag(text: countryTag),
                          SizedBox(height: 10.h),
                        ],
                        Text(
                          trip.title,
                          style:
                              AppTextStyles.heading1(
                                color: AppColors.onImage,
                              ).copyWith(
                                fontSize: 34.sp,
                                height: 1.08,
                                letterSpacing: -0.35,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (showCompany) ...[
                          SizedBox(height: 10.h),
                          _CompanyPill(
                            label: context.tr.tripDetailsHeroByCompanyLine(
                              companyName,
                            ),
                          ),
                        ],
                        if (showFrom) ...[
                          SizedBox(height: 18.h),
                          _HeroMetaRow(
                            icon: Iconsax.location,
                            child: Text.rich(
                              TextSpan(
                                style:
                                    AppTextStyles.body(
                                      color: AppColors.onImage,
                                    ).copyWith(
                                      fontSize: 14.sp,
                                      height: 1.25,
                                      fontWeight: FontWeight.w400,
                                    ),
                                children: [
                                  TextSpan(
                                    text: context.tr.tripDetailsHeroFromPrefix,
                                  ),
                                  TextSpan(
                                    text: fromLine,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                        if (dateRange.isNotEmpty) ...[
                          SizedBox(height: showFrom ? 8.h : 18.h),
                          _HeroMetaRow(
                            icon: Iconsax.calendar,
                            child: Text(
                              dateRange,
                              style:
                                  AppTextStyles.body(
                                    color: AppColors.onImage,
                                  ).copyWith(
                                    fontSize: 14.sp,
                                    height: 1.25,
                                    fontWeight: FontWeight.w400,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                        SizedBox(height: 16.h),
                        _RatingPill(ratingText: ratingText),
                      ],
                    ),
                  ),
                  if (thumbUrls.isNotEmpty) ...[
                    SizedBox(width: 16.w),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var i = 0; i < thumbUrls.length; i++) ...[
                          if (i > 0) SizedBox(height: 12.h),
                          _FramedThumbTile(
                            outerSize: thumbOuter,
                            innerSize: thumbInner,
                            framePadding: framePad,
                            url: thumbUrls[i],
                            showMoreOverlay:
                                i == thumbUrls.length - 1 && extraCount > 0,
                            moreLabel: context.tr.tripDetailsGalleryMoreCount(
                              '$extraCount',
                            ),
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

class _CountryTag extends StatelessWidget {
  const _CountryTag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: AppColors.onImage,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        text,
        style: AppTextStyles.label(
          color: AppColors.textColorLight,
        ).copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600, height: 1.1),
      ),
    );
  }
}

class _CompanyPill extends StatelessWidget {
  const _CompanyPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.shadow.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption(
          color: AppColors.tripDetailsHeroCompanyAccent,
        ).copyWith(fontSize: 13.sp, fontWeight: FontWeight.w600, height: 1.15),
      ),
    );
  }
}

class _HeroMetaRow extends StatelessWidget {
  const _HeroMetaRow({required this.icon, required this.child});

  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(top: 1.h),
          child: Icon(icon, color: AppColors.onImage, size: 18.sp),
        ),
        SizedBox(width: 8.w),
        Expanded(child: child),
      ],
    );
  }
}

class _RatingPill extends StatelessWidget {
  const _RatingPill({required this.ratingText});

  final String ratingText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.shadow.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            ratingText,
            style: AppTextStyles.bodyMedium(color: AppColors.onImage).copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              height: 1.1,
            ),
          ),
          SizedBox(width: 5.w),
          Icon(
            Icons.star_rounded,
            color: AppColors.tripDetailsHeroStarGold,
            size: 17.sp,
          ),
        ],
      ),
    );
  }
}

class _FramedThumbTile extends StatelessWidget {
  const _FramedThumbTile({
    required this.outerSize,
    required this.innerSize,
    required this.framePadding,
    required this.url,
    required this.showMoreOverlay,
    required this.moreLabel,
    required this.onTap,
  });

  final double outerSize;
  final double innerSize;
  final double framePadding;
  final String url;
  final bool showMoreOverlay;
  final String moreLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radiusOuter = 14.r;
    final radiusInner = 11.r;

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radiusOuter),
        child: Container(
          width: outerSize,
          height: outerSize,
          padding: EdgeInsets.all(framePadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radiusOuter),
            border: Border.all(
              color: AppColors.tripDetailsHeroGalleryFrame.withValues(
                alpha: 0.5,
              ),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.tripDetailsHeroGalleryFrame.withValues(
                  alpha: 0.22,
                ),
                blurRadius: 14.r,
                spreadRadius: 0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radiusInner),
            child: SizedBox(
              width: innerSize,
              height: innerSize,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppCachedNetworkImage(imageUrl: url, fit: BoxFit.cover),
                  if (showMoreOverlay)
                    ColoredBox(
                      color: AppColors.shadow.withValues(alpha: 0.52),
                      child: Center(
                        child: Text(
                          moreLabel,
                          style:
                              AppTextStyles.bodyMedium(
                                color: AppColors.onImage,
                              ).copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                height: 1,
                              ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

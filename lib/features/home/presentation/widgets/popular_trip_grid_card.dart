import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import '../../data/models/home_section_response.dart';

/// Figma home trip rail card — 190×346 @ 393×852 design.
abstract final class _PopularTripGridCardTokens {
  static double get cardWidth => 190.w;
  static double get cardHeight => 346.h;
  static double get cardRadius => 20.r;
  static double get inset => 12.w;
  static double get imageToContentGap => 6.h;
  static double get contentRowGap => 4.h;
  static double get priceTopGap => 6.h;
  static double get contentBottomInset => 10.h;

  /// Target share of card height for the cover image.
  static double get imageHeightFactor => 0.635;

  /// Conservative max height for title + 4 rows + price (tight line heights).
  static double get maxContentBodyHeight => 112.h;

  static double coverImageHeight(double cardHeight) {
    final desired = cardHeight * imageHeightFactor;
    final maxSafe =
        cardHeight -
        imageToContentGap -
        contentBottomInset -
        maxContentBodyHeight;
    return math.min(desired, maxSafe);
  }
}

class PopularTripGridCard extends StatelessWidget {
  const PopularTripGridCard({
    super.key,
    required this.trip,
    this.onTap,
    this.onFavoriteTap,
  });

  final TripModel trip;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  static TextStyle _tight(TextStyle style) => style.copyWith(height: 1.1);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : _PopularTripGridCardTokens.cardHeight;
        final cardWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : _PopularTripGridCardTokens.cardWidth;
        final radius = _PopularTripGridCardTokens.cardRadius;
        final inset = _PopularTripGridCardTokens.inset;
        final imageHeight = _PopularTripGridCardTokens.coverImageHeight(
          cardHeight,
        );

        return SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.cardBg(context),
                  border: Border.all(
                    color: AppColors.border(context).withValues(alpha: 0.4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: imageHeight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radius),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            AppCachedNetworkImage(
                              imageUrl: trip.coverImage,
                              fit: BoxFit.cover,
                            ),
                            PositionedDirectional(
                              top: 12.h,
                              end: 12.w,
                              child: Material(
                                color: AppColors.transparent,
                                child: InkWell(
                                  onTap: onFavoriteTap,
                                  borderRadius: BorderRadius.circular(999),
                                  child: Container(
                                    width: 36.w,
                                    height: 36.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.white.withValues(
                                        alpha: 0.45,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      trip.isWishlisted
                                          ? Iconsax.heart5
                                          : Iconsax.heart,
                                      size: 18.sp,
                                      color: trip.isWishlisted
                                          ? AppColors.error
                                          : AppColors.onImage,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _PopularTripGridCardTokens.imageToContentGap,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: inset,
                          end: inset,
                          bottom: _PopularTripGridCardTokens.contentBottomInset,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              trip.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: _tight(
                                AppTextStyles.subtitle(
                                  color: AppColors.darkText(context),
                                ).copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              height: _PopularTripGridCardTokens.contentRowGap,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Iconsax.star1,
                                  size: 14.sp,
                                  color: AppColors.starYellow,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  trip.rating.toStringAsFixed(1),
                                  style: _tight(
                                    AppTextStyles.bodySmall(
                                      color: AppColors.darkText(context),
                                    ).copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Text(
                                  '(${trip.reviewsCount})',
                                  style: _tight(
                                    AppTextStyles.bodySmall(
                                      color: AppColors.greyText(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: _PopularTripGridCardTokens.contentRowGap,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Iconsax.location,
                                  size: 14.sp,
                                  color: AppColors.greyText(context),
                                ),
                                SizedBox(width: 6.w),
                                Expanded(
                                  child: Text(
                                    '${context.tr.myTripsFromPrefix} ${trip.fromLocation}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: _tight(
                                      AppTextStyles.body(
                                        color: AppColors.greyText(context),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: _PopularTripGridCardTokens.contentRowGap,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Iconsax.calendar_1,
                                  size: 14.sp,
                                  color: AppColors.greyText(context),
                                ),
                                SizedBox(width: 6.w),
                                Expanded(
                                  child: Text(
                                    trip.dateRange,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: _tight(
                                      AppTextStyles.body(
                                        color: AppColors.greyText(context),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: _PopularTripGridCardTokens.priceTopGap,
                            ),
                            Row(
                              children: [
                                if (trip.discountPrice != null) ...[
                                  Flexible(
                                    child: Text(
                                      PriceFormatter.format(
                                        trip.discountPrice!,
                                        currency: trip.currency,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: _tight(
                                        AppTextStyles.bodyMedium(
                                          color: AppColors.primary,
                                        ).copyWith(fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Flexible(
                                    child: Text(
                                      PriceFormatter.format(
                                        trip.price,
                                        currency: trip.currency,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: _tight(
                                        AppTextStyles.bodySmall(
                                          color: AppColors.greyText(context),
                                        ).copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ),
                                  ),
                                ] else
                                  Flexible(
                                    child: Text(
                                      PriceFormatter.format(
                                        trip.price,
                                        currency: trip.currency,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: _tight(
                                        AppTextStyles.bodyMedium(
                                          color: AppColors.primary,
                                        ).copyWith(fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

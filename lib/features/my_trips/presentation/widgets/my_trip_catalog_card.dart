import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/utils/price_formatter.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import 'package:trip_marche/features/trip_details/presentation/trip_wishlist_pop_result.dart';
import 'package:trip_marche/features/trip_details/presentation/view/trip_details_view.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';

class MyTripCatalogCard extends StatelessWidget {
  const MyTripCatalogCard({
    super.key,
    required this.trip,
    required this.locationLabel,
    required this.onFavoriteTap,
    this.onReturnedFromTripDetails,
  });

  final WishlistTripItem trip;
  final String locationLabel;
  final VoidCallback onFavoriteTap;
  final void Function(TripWishlistPopResult? result)? onReturnedFromTripDetails;

  static String _priceWithCurrency(num value, String currency) =>
      PriceFormatter.format(value, currency: currency);

  static String _dateArrowRange(BuildContext context, WishlistTripItem trip) {
    try {
      final loc = Localizations.localeOf(context).toString();
      final s = DateTime.parse(trip.startDate);
      final e = DateTime.parse(trip.endDate);
      final df = DateFormat('d MMM', loc);
      return '${df.format(s)} -> ${df.format(e)}';
    } catch (_) {
      return trip.dateRange
          .replaceAll(' - ', ' -> ')
          .replaceAll(' → ', ' -> ');
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasDiscount =
        trip.discountPrice != null && trip.discountPrice! < trip.price;
    final currentPrice = hasDiscount ? trip.discountPrice! : trip.price;
    final originalPrice = trip.price;

    final cardRadius = 18.r;

    final imageCornerRadius = 20.r;

    final metaStyle = TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.catalogMetaMuted,
      height: 1.3,
    );

    return Semantics(
      button: true,
      label: trip.title,
      hint: context.tr.myTripsViewDetails,
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: () async {
            final result = await sl<AppNavigator>().push<TripWishlistPopResult>(
              screen: TripDetailsView(
                tripId: trip.id,
                initialIsWishlisted: trip.isWishlisted,
              ),
            );
            onReturnedFromTripDetails?.call(result);
          },
          borderRadius: BorderRadius.circular(cardRadius),
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(cardRadius),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cardRadius),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.r),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 155.w,
                          height: 155.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              imageCornerRadius,
                            ),
                            child: AppCachedNetworkImage(
                              imageUrl: trip.coverImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 14.w),

                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              end: 36.w,
                              top: 2.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  trip.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkText,
                                    height: 1.25,
                                  ),
                                ),
                                SizedBox(height: 6.h),

                                Row(
                                  children: [
                                    Icon(
                                      Iconsax.star1,
                                      size: 16.sp,
                                      color: AppColors.starYellow,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      trip.rating.toStringAsFixed(1),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.darkText,
                                        height: 1.2,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Flexible(
                                      child: Text(
                                        context
                                            .tr
                                            .myTripsCatalogReviewCountInline(
                                          trip.reviewsCount,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: metaStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.h),

                                Row(
                                  children: [
                                    Icon(
                                      Iconsax.location,
                                      size: 14.sp,
                                      color: AppColors.catalogMetaMuted,
                                    ),
                                    SizedBox(width: 5.w),
                                    Expanded(
                                      child: Text(
                                        locationLabel,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: metaStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),

                                Row(
                                  children: [
                                    Icon(
                                      Iconsax.calendar_1,
                                      size: 14.sp,
                                      color: AppColors.catalogMetaMuted,
                                    ),
                                    SizedBox(width: 5.w),
                                    Expanded(
                                      child: Text(
                                        _dateArrowRange(context, trip),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: metaStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),

                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    if (hasDiscount) ...[
                                      Text(
                                        _priceWithCurrency(
                                          originalPrice,
                                          trip.currency,
                                        ),
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.catalogMetaMuted,
                                          height: 1.2,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor:
                                              AppColors.catalogMetaMuted,
                                        ),
                                      ),
                                      SizedBox(width: 6.w),
                                    ],

                                    Text(
                                      _priceWithCurrency(
                                        currentPrice,
                                        trip.currency,
                                      ),
                                      style: TextStyle(
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.darkText,
                                        height: 1.15,
                                      ),
                                    ),
                                    SizedBox(width: 3.w),

                                    Flexible(
                                      child: Text(
                                        context.tr.tripDetailsPerPerson,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.catalogMetaMuted,
                                          height: 1.2,
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

                  PositionedDirectional(
                    top: 10.h,
                    end: 10.w,
                    child: _CatalogFavoriteButton(
                      isFavorite: trip.isWishlisted,
                      onTap: onFavoriteTap,
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

class _CatalogFavoriteButton extends StatelessWidget {
  const _CatalogFavoriteButton({required this.isFavorite, required this.onTap});

  final bool isFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: isFavorite
          ? context.tr.myTripsCatalogRemoveWishlist
          : context.tr.myTripsCatalogSaveWishlist,
      child: Material(
        color: AppColors.cardBg,
        shape: const CircleBorder(),
        elevation: 2,
        shadowColor: AppColors.shadow.withValues(alpha: 0.12),
        surfaceTintColor: AppColors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox(
            width: 38.w,
            height: 38.w,
            child: Center(
              child: ExcludeSemantics(
                child: Icon(
                  isFavorite ? Iconsax.heart5 : Iconsax.heart,
                  size: 18.sp,
                  color: isFavorite
                      ? AppColors.error
                      : AppColors.catalogMetaMuted,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

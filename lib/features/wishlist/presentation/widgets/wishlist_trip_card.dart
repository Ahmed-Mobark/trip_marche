import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/utils/price_formatter.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import 'package:trip_marche/features/trip_details/presentation/trip_wishlist_pop_result.dart';
import 'package:trip_marche/features/trip_details/presentation/view/trip_details_view.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';

import '../cubit/wishlist_cubit.dart';

class WishlistTripCard extends StatelessWidget {
  const WishlistTripCard({super.key, required this.trip, this.onFavoriteTap});

  final WishlistTripItem trip;
  final VoidCallback? onFavoriteTap;

  ({String text, Color color})? _derivedFlagBadge(BuildContext context) {
    if (trip.badge != null && trip.badge!.isNotEmpty) {
      return null;
    }
    if (trip.flags.recommended) {
      return (text: context.tr.wishlistRecommended, color: AppColors.warning);
    }
    if (trip.flags.sponsored) {
      return (
        text: context.tr.wishlistNewInTripMarche,
        color: AppColors.primary,
      );
    }
    if (trip.flags.special) {
      return (text: context.tr.wishlistBestPrice, color: AppColors.success);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final flagBadge = _derivedFlagBadge(context);
    final hasDiscount =
        trip.discountPrice != null && trip.discountPrice! < trip.price;

    return GestureDetector(
      onTap: () async {
        final result = await sl<AppNavigator>().push<TripWishlistPopResult>(
          screen: TripDetailsView(
            tripId: trip.id,
            initialIsWishlisted: trip.isWishlisted,
          ),
        );
        if (!context.mounted || result == null) {
          return;
        }
        context.read<WishlistCubit>().applyWishlistStateFromDetails(
          result.tripId,
          result.isWishlisted,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBg(context),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border(context)),
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(context),
            SizedBox(width: 12.w),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  top: 10.h,
                  end: 10.w,
                  bottom: 10.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleRow(context),
                    SizedBox(height: 6.h),
                    _buildRatingRow(context),
                    SizedBox(height: 4.h),
                    _buildLocationRow(context),
                    SizedBox(height: 4.h),
                    _buildDateRow(context),
                    if (flagBadge != null) ...[
                      SizedBox(height: 6.h),
                      _buildFlagBadge(flagBadge),
                    ],
                    SizedBox(height: 8.h),
                    _buildPriceRow(context, hasDiscount),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10.w, top: 10.h),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: AppCachedNetworkImage(
              imageUrl: trip.coverImage,
              fit: BoxFit.cover,
              width: 135.w,
              height: 180.h,
            ),
          ),
          if (trip.badge != null && trip.badge!.isNotEmpty)
            PositionedDirectional(
              top: 0,
              start: 0,
              child: Container(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 7.w,
                  vertical: 3.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.starYellow,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(14.r),
                    right: Radius.circular(14.r),
                  ),
                ),
                child: Text(
                  trip.badge!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall(
                    color: AppColors.onImage,
                  ).copyWith(fontWeight: FontWeight.w800, fontSize: 10.sp),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            trip.title,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall(color: AppColors.darkText(context))
                .copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  height: 1.25,
                ),
          ),
        ),
        SizedBox(width: 6.w),
        _WishlistFavoriteButton(
          isFavorite: trip.isWishlisted || trip.isFavorite,
          onTap: onFavoriteTap,
        ),
      ],
    );
  }

  Widget _buildRatingRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Iconsax.star1, size: 14.sp, color: AppColors.starYellow),
        SizedBox(width: 4.w),
        Text(
          trip.rating.toStringAsFixed(1),
          style: AppTextStyles.bodySmall(
            color: AppColors.darkText(context),
          ).copyWith(fontWeight: FontWeight.w700),
        ),
        Text(
          ' (${trip.reviewsCount})',
          style: AppTextStyles.bodySmall(color: AppColors.greyText(context)),
        ),
      ],
    );
  }

  Widget _buildLocationRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Iconsax.location, size: 14.sp, color: AppColors.greyText(context)),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            '${context.tr.myTripsFromPrefix} ${trip.fromLocation}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall(color: AppColors.greyText(context)),
          ),
        ),
      ],
    );
  }

  Widget _buildDateRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Iconsax.calendar_1,
          size: 14.sp,
          color: AppColors.greyText(context),
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            trip.dateRange,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall(color: AppColors.greyText(context)),
          ),
        ),
      ],
    );
  }

  Widget _buildFlagBadge(({String text, Color color}) flagBadge) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 7.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: flagBadge.color,
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: Text(
        flagBadge.text,
        style: AppTextStyles.bodySmall(
          color: AppColors.onImage,
        ).copyWith(fontWeight: FontWeight.w700, fontSize: 10.sp),
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context, bool hasDiscount) {
    final currentPrice = hasDiscount ? trip.discountPrice! : trip.price;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        if (hasDiscount) ...[
          Text(
            PriceFormatter.format(trip.price, currency: trip.currency),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall(
              color: AppColors.greyText(context),
            ).copyWith(decoration: TextDecoration.lineThrough, fontSize: 12.sp),
          ),
          SizedBox(width: 6.w),
        ],
        Flexible(
          child: Text(
            PriceFormatter.format(currentPrice, currency: trip.currency),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.heading3(
              color: AppColors.darkText(context),
            ).copyWith(fontWeight: FontWeight.w800, fontSize: 16.sp),
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          '/${context.tr.homePerPerson}',
          style: AppTextStyles.bodySmall(color: AppColors.greyText(context)),
        ),
      ],
    );
  }
}

class _WishlistFavoriteButton extends StatelessWidget {
  const _WishlistFavoriteButton({
    required this.isFavorite,
    required this.onTap,
  });

  final bool isFavorite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: isFavorite
          ? context.tr.myTripsCatalogRemoveWishlist
          : context.tr.myTripsCatalogSaveWishlist,
      child: Material(
        color: AppColors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Container(
            width: 34.w,
            height: 34.w,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.85),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 18.sp,
              color: isFavorite ? Colors.red : AppColors.greyText(context),
            ),
          ),
        ),
      ),
    );
  }
}

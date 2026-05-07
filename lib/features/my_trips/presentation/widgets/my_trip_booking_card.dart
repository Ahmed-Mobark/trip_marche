import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/data/dummy_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/config/styles/styles.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import '../../../../core/widgets/trip_favorite_circle_button.dart';
import 'package:trip_marche/features/trip_details/presentation/trip_wishlist_pop_result.dart';
import 'package:trip_marche/features/trip_details/presentation/view/trip_details_view.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';

class MyTripBookingCard extends StatelessWidget {
  /// Local dummy / past trips row.
  const MyTripBookingCard.legacy({
    super.key,
    required TripItem trip,
    required this.statusText,
    required this.statusColor,
    required this.locationText,
    required this.primaryActionText,
    required this.secondaryActionText,
    required this.bottomActionText,
    this.onFavoriteTap,
    this.isFavorite = true,
    this.onPrimaryActionTap,
    this.onSecondaryActionTap,
    this.onBottomActionTap,
  })  : _legacyTrip = trip,
        _apiTrip = null,
        onReturnedFromTripDetails = null;

  /// Trip from GET [/trips] (same shape as wishlist rows).
  const MyTripBookingCard.api({
    super.key,
    required WishlistTripItem trip,
    required this.statusText,
    required this.statusColor,
    required this.locationText,
    required this.primaryActionText,
    required this.secondaryActionText,
    required this.bottomActionText,
    this.onFavoriteTap,
    this.onPrimaryActionTap,
    this.onSecondaryActionTap,
    this.onBottomActionTap,
    this.onReturnedFromTripDetails,
  })  : _apiTrip = trip,
        _legacyTrip = null,
        isFavorite = false;

  final TripItem? _legacyTrip;
  final WishlistTripItem? _apiTrip;

  final String statusText;
  final Color statusColor;
  final String locationText;
  final String primaryActionText;
  final String secondaryActionText;
  final String bottomActionText;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;
  final VoidCallback? onPrimaryActionTap;
  final VoidCallback? onSecondaryActionTap;
  final VoidCallback? onBottomActionTap;
  final void Function(TripWishlistPopResult? result)? onReturnedFromTripDetails;

  int get _tripId => _apiTrip?.id ?? _legacyTrip?.id ?? 0;

  String get _title => _apiTrip?.title ?? _legacyTrip?.title ?? '';

  double get _rating => _apiTrip?.rating ?? _legacyTrip?.rating ?? 0;

  int get _reviewsCount => _apiTrip?.reviewsCount ?? 112;

  String get _dateRange =>
      _apiTrip?.dateRange ?? _legacyTrip?.dateRange ?? '';

  String? get _imageUrl {
    final api = _apiTrip;
    if (api != null) {
      final u = api.coverImage.trim();
      return u.isEmpty ? null : u;
    }
    return _legacyTrip?.imageUrl;
  }

  bool get _heartFilled =>
      _apiTrip?.isWishlisted ?? isFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final initialWishlisted = _apiTrip?.isWishlisted ?? isFavorite;
        final result = await sl<AppNavigator>().push<TripWishlistPopResult>(
          screen: TripDetailsView(
            tripId: _tripId,
            initialIsWishlisted: initialWishlisted,
          ),
        );
        onReturnedFromTripDetails?.call(result);
      },
      child: Container(
        padding: EdgeInsetsDirectional.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.cardBg(context),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.06),
              blurRadius: 14.r,
              offset: Offset(0, 6.h),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: SizedBox(
                width: 132.w,
                height: 172.w,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: AppCachedNetworkImage(
                        imageUrl: _imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    PositionedDirectional(
                      top: 10.h,
                      start: 10.w,
                      child: Container(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Text(
                          statusText,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.onImage,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.subtitle(
                            color: AppColors.darkText(context),
                          ).copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      TripFavoriteCircleButton(
                        isFavorite: _heartFilled,
                        onTap: () => onFavoriteTap?.call(),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(
                        Iconsax.star1,
                        size: 14.sp,
                        color: AppColors.starYellow,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        _rating.toStringAsFixed(1),
                        style: AppTextStyles.bodySmall(
                          color: AppColors.darkText(context),
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        ' ($_reviewsCount)',
                        style: AppTextStyles.bodySmall(
                          color: AppColors.greyText(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
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
                          locationText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.greyText(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
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
                          _dateRange,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.greyText(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: _ActionPill(
                          text: primaryActionText,
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.onImage,
                          onTap: onPrimaryActionTap,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _ActionPill(
                          text: secondaryActionText,
                          backgroundColor: AppColors.inputBg(context),
                          textColor: AppColors.darkText(context),
                          borderColor: AppColors.border(context),
                          onTap: onSecondaryActionTap,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  _BottomAction(
                    text: bottomActionText,
                    onTap: onBottomActionTap,
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

class _ActionPill extends StatelessWidget {
  const _ActionPill({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    this.onTap,
  });

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 34.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          border: borderColor == null ? null : Border.all(color: borderColor!),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: AppTextStyles.bodySmall(color: textColor).copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _BottomAction extends StatelessWidget {
  const _BottomAction({required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 42.h,
        decoration: BoxDecoration(
          color: AppColors.cardBg(context),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.border(context).withValues(alpha: 0.75),
          ),
        ),
        padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.document_download,
              size: 18.sp,
              color: AppColors.primary,
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyMedium(color: AppColors.darkText(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

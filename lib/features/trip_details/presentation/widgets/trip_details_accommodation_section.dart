import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_images.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import 'package:trip_marche/core/widgets/app_image_gallery_screen.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'trip_details_info_card.dart';

class TripDetailsAccommodationSection extends StatelessWidget {
  const TripDetailsAccommodationSection({super.key, required this.trip});

  final TripDetails trip;

  void _showTextSheet(BuildContext context, String title, String? body) {
    final text = body?.trim();
    if (text == null || text.isEmpty) {
      return;
    }
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        final maxH = MediaQuery.sizeOf(ctx).height * 0.65;
        return SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: 20.w,
              end: 20.w,
              top: 16.h,
              bottom: MediaQuery.paddingOf(ctx).bottom + 16.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.heading3(color: AppColors.darkText),
                ),
                SizedBox(height: 12.h),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: maxH),
                  child: SingleChildScrollView(
                    child: SelectableText(
                      text,
                      style: AppTextStyles.body(color: AppColors.secondaryText),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: Text(context.tr.commonCancel),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accommodations = trip.accommodations;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.tripDetailsAccommodationTitle,
          style: TextStyles.textViewBold14,
        ),
        SizedBox(height: 14.h),
        for (final hotel in accommodations) ...[
          _AccommodationItemCard(
            hotelName: hotel.name,
            hotelLocation: hotel.address,
            imageUrls: hotel.images,
            onMapTap: () {},
          ),
          SizedBox(height: 14.h),
        ],
        if (trip.activityRates.isNotEmpty) ...[
          _ActivityRateCard(rates: trip.activityRates),
          SizedBox(height: 14.h),
        ],
        _TripDetailsQuickLinks(
          onVisa: () => _showTextSheet(
            context,
            context.tr.tripDetailsVisaDetailsTitle,
            trip.visaDetails,
          ),
          onInstructions: () => _showTextSheet(
            context,
            context.tr.tripDetailsTripInstructionsTitle,
            trip.tripInstructions,
          ),
          onSafety: () => _showTextSheet(
            context,
            context.tr.tripDetailsSafetyProceduresTitle,
            trip.safetyProcedures,
          ),
          onTerms: () => _showTextSheet(
            context,
            context.tr.tripDetailsPolicyTerms,
            trip.termsConditions,
          ),
          onCancellation: () => _showTextSheet(
            context,
            context.tr.tripDetailsPolicyCancellation,
            trip.cancellationPolicy,
          ),
        ),
        SizedBox(height: 24.h),
        if (trip.reviewsCount > 0) ...[
          _SectionHeader(
            title: context.tr.tripDetailsReviewsTitle,
            actionText: context.tr.tripDetailsReviewsCount(trip.reviewsCount),
            onAction: () {},
          ),
          SizedBox(height: 8.h),
          Text(
            '${trip.rating.toStringAsFixed(2)} · ${context.tr.tripDetailsReviewsCount(trip.reviewsCount)}',
            style: AppTextStyles.body(color: AppColors.greyText),
          ),
          SizedBox(height: 24.h),
        ],
        Text(
          context.tr.tripDetailsCompanySectionTitle,
          style: TextStyles.textViewBold14,
        ),
        SizedBox(height: 12.h),
        _CompanyCard(
          companyName: trip.vendor.name,
          ratingValue: trip.rating.toStringAsFixed(2),
          ratingCount: context.tr.tripDetailsReviewsCount(trip.reviewsCount),
          avatarUrl: trip.vendor.avatar,
          onFollow: () {},
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.actionText,
    required this.onAction,
  });

  final String title;
  final String actionText;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.subtitle(color: AppColors.darkText),
          ),
        ),
        TextButton(
          onPressed: onAction,
          child: Text(
            actionText,
            style: AppTextStyles.bodyMedium(
              color: AppColors.primary,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _CompanyCard extends StatelessWidget {
  const _CompanyCard({
    required this.companyName,
    required this.ratingValue,
    required this.ratingCount,
    required this.onFollow,
    this.avatarUrl,
  });

  final String companyName;
  final String ratingValue;
  final String ratingCount;
  final VoidCallback onFollow;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return TripDetailsInfoCard(
      withShadow: false,
      borderRadius: 16.r,
      padding: EdgeInsetsDirectional.all(14.r),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: SizedBox(
              width: 56.r,
              height: 56.r,
              child: avatarUrl != null && avatarUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: avatarUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) =>
                          Image.asset(AppImages.logo, fit: BoxFit.cover),
                    )
                  : Image.asset(AppImages.logo, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.darkText,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Iconsax.star1,
                      color: AppColors.starYellow,
                      size: 14.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      ratingValue,
                      style: AppTextStyles.caption(
                        color: AppColors.darkText,
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      ' ($ratingCount)',
                      style: AppTextStyles.caption(color: AppColors.greyText),
                    ),
                  ],
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: onFollow,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999.r),
              ),
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 18.w,
                vertical: 10.h,
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              context.tr.tripDetailsFollow,
              style: AppTextStyles.bodyMedium(
                color: AppColors.primary,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityRateCard extends StatelessWidget {
  const _ActivityRateCard({required this.rates});

  final List<TripActivityRate> rates;

  @override
  Widget build(BuildContext context) {
    return TripDetailsInfoCard(
      withShadow: false,
      borderRadius: 16.r,
      padding: EdgeInsetsDirectional.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr.tripDetailsActivityRateTitle,
            style: AppTextStyles.subtitle(color: AppColors.darkText),
          ),
          SizedBox(height: 12.h),
          ...rates.map(
            (r) => Padding(
              padding: EdgeInsetsDirectional.only(bottom: 10.h),
              child: _RatePillRow(
                label: r.label.isNotEmpty ? r.label : r.key,
                score: r.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatePillRow extends StatelessWidget {
  const _RatePillRow({required this.label, required this.score});

  final String label;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 14.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySmall(color: AppColors.darkText),
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            '$score/10',
            style: AppTextStyles.bodyMedium(
              color: AppColors.starYellow,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _TripDetailsQuickLinks extends StatelessWidget {
  const _TripDetailsQuickLinks({
    required this.onVisa,
    required this.onInstructions,
    required this.onSafety,
    required this.onTerms,
    required this.onCancellation,
  });

  final VoidCallback onVisa;
  final VoidCallback onInstructions;
  final VoidCallback onSafety;
  final VoidCallback onTerms;
  final VoidCallback onCancellation;

  @override
  Widget build(BuildContext context) {
    final items = <(IconData, String, VoidCallback)>[
      (Iconsax.document_text, context.tr.tripDetailsVisaDetailsTitle, onVisa),
      (Iconsax.clipboard_text, context.tr.tripDetailsTripInstructionsTitle, onInstructions),
      (Iconsax.shield_tick, context.tr.tripDetailsSafetyProceduresTitle, onSafety),
      (Iconsax.document, context.tr.tripDetailsPolicyTerms, onTerms),
      (Iconsax.close_circle, context.tr.tripDetailsPolicyCancellation, onCancellation),
    ];

    return Column(
      children: items
          .map(
            (e) => Padding(
              padding: EdgeInsetsDirectional.only(bottom: 10.h),
              child: _QuickLinkTile(icon: e.$1, title: e.$2, onTap: e.$3),
            ),
          )
          .toList(),
    );
  }
}

class _QuickLinkTile extends StatelessWidget {
  const _QuickLinkTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardBg,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 14.w,
            vertical: 14.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 34.r,
                height: 34.r,
                decoration: BoxDecoration(
                  color: AppColors.lightBg,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Icon(icon, size: 18.sp, color: AppColors.darkText),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodyMedium(color: AppColors.darkText),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 22.sp,
                color: AppColors.greyText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccommodationItemCard extends StatelessWidget {
  const _AccommodationItemCard({
    required this.hotelName,
    required this.hotelLocation,
    required this.imageUrls,
    required this.onMapTap,
  });

  final String hotelName;
  final String hotelLocation;
  final List<String> imageUrls;
  final VoidCallback onMapTap;

  @override
  Widget build(BuildContext context) {
    return TripDetailsInfoCard(
      withShadow: false,
      borderRadius: 16.r,
      padding: EdgeInsetsDirectional.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr.tripDetailsAccommodationHotelNameLabel,
                      style: AppTextStyles.caption(color: AppColors.greyText),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      hotelName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.darkText,
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      context.tr.tripDetailsAccommodationHotelLocationLabel,
                      style: AppTextStyles.caption(color: AppColors.greyText),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      hotelLocation,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmall(color: AppColors.greyText),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Material(
                color: AppColors.lightBg,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onMapTap,
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Icon(
                      Iconsax.location,
                      color: AppColors.success,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (imageUrls.isNotEmpty) ...[
            SizedBox(height: 14.h),
            SizedBox(
              height: 86.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: imageUrls.length,
                separatorBuilder: (_, __) => SizedBox(width: 10.w),
                itemBuilder: (_, i) => Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => AppImageGalleryScreen.open(
                      context,
                      imageUrls: imageUrls,
                      initialIndex: i,
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: AppCachedNetworkImage(
                        imageUrl: imageUrls[i],
                        width: 120.w,
                        height: 86.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

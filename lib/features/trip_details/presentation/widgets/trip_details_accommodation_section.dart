import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_images.dart';
import 'package:trip_marche/core/config/styles/font_utils.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'package:trip_marche/features/trip_details/presentation/cubit/trip_details_cubit.dart';
import 'package:trip_marche/features/trip_details/presentation/view/trip_details_list_views.dart';

import 'trip_accommodation_card.dart';
import 'trip_details_info_card.dart';

// Accommodation card — Figma-fixed typography (no .sp on these styles).
const Color _kAccommodationTitleValueLight = Color(0xFF000000);

class TripDetailsAccommodationSection extends StatelessWidget {
  const TripDetailsAccommodationSection({super.key, required this.trip});

  final TripDetails trip;

  @override
  Widget build(BuildContext context) {
    final accommodations = trip.accommodations;

    final displayedAccommodations = accommodations.take(2).toList();
    final hasMore = accommodations.length > 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (accommodations.isNotEmpty)
          TripDetailsInfoCard(
            withShadow: true,
            borderRadius: 20,
            padding: const EdgeInsetsDirectional.all(20),
            borderColor: AppColors.border(context).withValues(alpha: 0.35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.tripDetailsAccommodationTitle,
                  style: TextStyle(
                    fontFamily: AppFont.fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                    letterSpacing: 0,
                    color: AppColors.isDark(context)
                        ? AppColors.darkText(context)
                        : _kAccommodationTitleValueLight,
                  ),
                ),
                const SizedBox(height: 12),
                for (var i = 0; i < displayedAccommodations.length; i++) ...[
                  if (i > 0) const SizedBox(height: 14),
                  TripAccommodationCard(
                    accommodation: displayedAccommodations[i],
                  ),
                ],
                if (hasMore) ...[
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => TripAllAccommodationView(
                              accommodations: accommodations,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        context.tr.tripDetailsSeeAllAccommodation,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppFont.fontFamily,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                          letterSpacing: 0,
                          color: AppColors.tripDetailsDepartureIconPurple,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

class TripDetailsCompanyCard extends StatelessWidget {
  const TripDetailsCompanyCard({
    super.key,
    required this.companyName,
    required this.ratingValue,
    required this.ratingCount,
    required this.onFollow,
    required this.vendorId,
    this.avatarUrl,
    this.onTap,
  });

  final String companyName;
  final String ratingValue;
  final String ratingCount;
  final VoidCallback onFollow;
  final int vendorId;
  final String? avatarUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isFollowing = context.select<TripDetailsCubit, bool>(
      (cubit) => cubit.isFollowingForVendor(vendorId),
    );
    final isBusy = context.select<TripDetailsCubit, bool>(
      (cubit) => cubit.isFollowBusy(vendorId),
    );

    return TripDetailsInfoCard(
      withShadow: false,
      borderRadius: 16.r,
      padding: EdgeInsetsDirectional.all(14.r),
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
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
                                errorWidget: (_, __, ___) => Image.asset(
                                  AppImages.logo,
                                  fit: BoxFit.cover,
                                ),
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
                              color: AppColors.darkText(context),
                            ).copyWith(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Iconsax.star1,
                                color: AppColors.starYellow,
                                size: 14.sp,
                              ),
                              SizedBox(width: 6.w),
                              Flexible(
                                child: Text(
                                  ratingValue,
                                  style: AppTextStyles.caption(
                                    color: AppColors.darkText(context),
                                  ).copyWith(fontWeight: FontWeight.w700),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  ' ($ratingCount)',
                                  style: AppTextStyles.caption(
                                    color: AppColors.greyText(context),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          OutlinedButton(
            onPressed: isBusy ? null : onFollow,
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
            child: isBusy
                ? SizedBox(
                    width: 16.w,
                    height: 16.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  )
                : Text(
                    isFollowing
                        ? context.tr.companyProfileFollowing
                        : context.tr.tripDetailsFollow,
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

class TripDetailsActivityRateCard extends StatelessWidget {
  const TripDetailsActivityRateCard({super.key, required this.rates});

  final List<TripActivityRate> rates;

  @override
  Widget build(BuildContext context) {
    final displayedRates = rates.take(4).toList();
    final hasMore = rates.length > 4;

    return TripDetailsInfoCard(
      withShadow: false,
      borderRadius: 16.r,
      padding: EdgeInsetsDirectional.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr.tripDetailsActivityRateTitle,
            style: AppTextStyles.subtitle(color: AppColors.darkText(context)),
          ),
          SizedBox(height: 8.h),
          ...displayedRates.map(
            (r) => Padding(
              padding: EdgeInsetsDirectional.only(bottom: 10.h),
              child: _RatePillRow(
                label: r.label.isNotEmpty ? r.label : r.key,
                score: r.value,
              ),
            ),
          ),
          if (hasMore) ...[
            SizedBox(height: 8.h),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => TripAllActivitiesView(rates: rates),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  context.tr.tripDetailsSeeAllActivities,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFont.fontFamily,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    letterSpacing: 0,
                    color: AppColors.tripDetailsDepartureIconPurple,
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

class _RatePillRow extends StatelessWidget {
  const _RatePillRow({required this.label, required this.score});

  final String label;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.cardBg(context),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySmall(
                color: AppColors.darkText(context),
              ),
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

class TripDetailsQuickLinks extends StatelessWidget {
  const TripDetailsQuickLinks({
    super.key,
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
      (
        Iconsax.clipboard_text,
        context.tr.tripDetailsTripInstructionsTitle,
        onInstructions,
      ),
      (
        Iconsax.shield_tick,
        context.tr.tripDetailsSafetyProceduresTitle,
        onSafety,
      ),
      (Iconsax.document, context.tr.tripDetailsPolicyTerms, onTerms),
      (
        Iconsax.close_circle,
        context.tr.tripDetailsPolicyCancellation,
        onCancellation,
      ),
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
      color: AppColors.cardBg(context),
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 14.w,
            vertical: 6.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.border(context)),
          ),
          child: Row(
            children: [
              Container(
                width: 34.r,
                height: 34.r,
                decoration: BoxDecoration(
                  color: AppColors.lightBg(context),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.border(context)),
                ),
                child: Icon(
                  icon,
                  size: 18.sp,
                  color: AppColors.darkText(context),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.darkText(context),
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 22.sp,
                color: AppColors.greyText(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

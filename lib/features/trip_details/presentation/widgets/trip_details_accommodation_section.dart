import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/config/styles/styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import 'trip_details_info_card.dart';

class TripDetailsAccommodationSection extends StatelessWidget {
  const TripDetailsAccommodationSection({super.key});

  static const _hotelImageUrls = <String>[
    'https://images.unsplash.com/photo-1501117716987-c8e1ecb2101f?w=600',
    'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=600',
    'https://images.unsplash.com/photo-1560067174-8943bd6d4cd7?w=600',
  ];

  static const _reviewImageUrls = <String>[
    'https://images.unsplash.com/photo-1528909514045-2fa4ac7a08ba?w=400',
    'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=400',
    'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=400',
    'https://images.unsplash.com/photo-1528127269322-539801943592?w=400',
    'https://images.unsplash.com/photo-1526772662000-3f88f10405ff?w=400',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.tripDetailsAccommodationTitle,
          style: TextStyles.textViewBold14,
        ),
        SizedBox(height: 14.h),
        _AccommodationItemCard(
          hotelName: context.tr.tripDetailsHotelName,
          hotelLocation: context.tr.tripDetailsHotelAddress,
          imageUrls: _hotelImageUrls,
          onMapTap: () {},
        ),
        SizedBox(height: 14.h),
        _AccommodationItemCard(
          hotelName: context.tr.tripDetailsHotelName,
          hotelLocation: context.tr.tripDetailsHotelAddress,
          imageUrls: _hotelImageUrls,
          onMapTap: () {},
        ),
        SizedBox(height: 10.h),
        Center(
          child: TextButton(
            onPressed: () {},
            child: Text(
              context.tr.tripDetailsSeeAllAccommodation,
              style: AppTextStyles.bodyMedium(
                color: AppColors.primary,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(height: 24.h),
        const _ActivityRateCard(),
        SizedBox(height: 14.h),
        const _TripDetailsQuickLinks(),
        SizedBox(height: 24.h),
        _SectionHeader(
          title: context.tr.tripDetailsReviewsTitle,
          actionText: context.tr.tripDetailsViewAll,
          onAction: () {},
        ),
        SizedBox(height: 12.h),
        _ReviewCard(
          name: 'Emma Thompson',
          country: context.tr.tripDetailsReviewCountry,
          rating: 5,
          comment: context.tr.tripDetailsReviewSampleBody,
          imageUrls: _reviewImageUrls,
        ),
        SizedBox(height: 24.h),
        Text(
          context.tr.tripDetailsCompanySectionTitle,
          style: TextStyles.textViewBold14,
        ),
        SizedBox(height: 12.h),
        _CompanyCard(
          companyName: context.tr.tripDetailsCompanyName,
          ratingValue: context.tr.tripDetailsCompanyRatingValue,
          ratingCount: context.tr.tripDetailsCompanyRatingCount,
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

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.name,
    required this.country,
    required this.rating,
    required this.comment,
    required this.imageUrls,
  });

  final String name;
  final String country;
  final int rating;
  final String comment;
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return TripDetailsInfoCard(
      withShadow: false,
      borderRadius: 16.r,
      padding: EdgeInsetsDirectional.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.lightBg,
                child: Text(
                  name.isNotEmpty ? name[0] : '',
                  style: AppTextStyles.bodyMedium(color: AppColors.primary),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.darkText,
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text('🇪🇸', style: TextStyle(fontSize: 14.sp)),
                        SizedBox(width: 6.w),
                        Text(
                          country,
                          style: AppTextStyles.caption(color: AppColors.greyText),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: List.generate(
                        rating,
                        (_) => Padding(
                          padding: EdgeInsetsDirectional.only(end: 2.w),
                          child: Icon(
                            Iconsax.star1,
                            color: AppColors.starYellow,
                            size: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            comment,
            style: AppTextStyles.body(color: AppColors.secondaryText),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 52.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              separatorBuilder: (_, __) => SizedBox(width: 8.w),
              itemBuilder: (_, i) => ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: AppCachedNetworkImage(
                  imageUrl: imageUrls[i],
                  width: 60.w,
                  height: 52.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompanyCard extends StatelessWidget {
  const _CompanyCard({
    required this.companyName,
    required this.ratingValue,
    required this.ratingCount,
    required this.onFollow,
  });

  final String companyName;
  final String ratingValue;
  final String ratingCount;
  final VoidCallback onFollow;

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
            child: Container(
              width: 56.r,
              height: 56.r,
              decoration: BoxDecoration(
                color: AppColors.lightBg,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Image.asset(AppImages.logo, fit: BoxFit.cover),
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
                      style: AppTextStyles.caption(color: AppColors.darkText)
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '($ratingCount)',
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
              style: AppTextStyles.bodyMedium(color: AppColors.primary)
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityRateCard extends StatelessWidget {
  const _ActivityRateCard();

  @override
  Widget build(BuildContext context) {
    final rows = [
      (context.tr.tripDetailsActivityRateLuxury, 9),
      (context.tr.tripDetailsActivityRateShopping, 6),
      (context.tr.tripDetailsActivityRateNightOutings, 8),
    ];

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
          ...rows.map(
            (r) => Padding(
              padding: EdgeInsetsDirectional.only(bottom: 10.h),
              child: _RatePillRow(label: r.$1, score: r.$2),
            ),
          ),
          SizedBox(height: 2.h),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                context.tr.tripDetailsSeeAllActivities,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.primary,
                ).copyWith(fontWeight: FontWeight.w600),
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
      padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
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
  const _TripDetailsQuickLinks();

  @override
  Widget build(BuildContext context) {
    final items = [
      (Iconsax.document_text, context.tr.tripDetailsVisaDetailsTitle),
      (Iconsax.clipboard_text, context.tr.tripDetailsTripInstructionsTitle),
      (Iconsax.shield_tick, context.tr.tripDetailsSafetyProceduresTitle),
      (Iconsax.document, context.tr.tripDetailsPolicyTerms),
      (Iconsax.close_circle, context.tr.tripDetailsPolicyCancellation),
    ];

    return Column(
      children: items
          .map(
            (e) => Padding(
              padding: EdgeInsetsDirectional.only(bottom: 10.h),
              child: _QuickLinkTile(icon: e.$1, title: e.$2, onTap: () {}),
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
      color: AppColors.white,
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
                Iconsax.arrow_right_3,
                size: 16.sp,
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
          SizedBox(height: 14.h),
          SizedBox(
            height: 86.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              separatorBuilder: (_, __) => SizedBox(width: 10.w),
              itemBuilder: (_, i) => ClipRRect(
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
        ],
      ),
    );
  }
}


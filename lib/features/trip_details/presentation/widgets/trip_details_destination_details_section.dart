import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'trip_details_info_card.dart';

class TripDetailsDestinationDetailsSection extends StatelessWidget {
  const TripDetailsDestinationDetailsSection({super.key, required this.trip});

  final TripDetails trip;

  static final Color _cardBorder = AppColors.border.withValues(alpha: 0.35);

  List<_CarouselDestination> _carouselDestinations() {
    final out = <_CarouselDestination>[];
    final seen = <int>{};
    for (final d in trip.destinations) {
      if (seen.add(d.id)) {
        out.add(_CarouselDestination(name: d.name, imageUrl: d.coverImage));
      }
    }
    if (out.isEmpty && trip.destination != null) {
      final p = trip.destination!;
      out.add(_CarouselDestination(name: p.name, imageUrl: p.image));
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    final visa = trip.visaDetails?.trim();
    final carousel = _carouselDestinations();

    final destCardSize = 132.w;
    final destCardRadius = 16.r;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (carousel.isNotEmpty) ...[
          Text(
            context.tr.tripDetailsDestinationsTitle,
            style: AppTextStyles.heading3(color: AppColors.darkText).copyWith(
              height: 1.1,
              letterSpacing: 0,
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            height: destCardSize,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: carousel.length,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (context, i) {
                final d = carousel[i];
                return _DestinationPhotoCard(
                  name: d.name,
                  imageUrl: d.imageUrl,
                  size: destCardSize,
                  borderRadius: destCardRadius,
                );
              },
            ),
          ),
          SizedBox(height: 24.h),
        ],
        if (visa != null && visa.isNotEmpty) ...[
          TripDetailsInfoCard(
            withShadow: false,
            borderRadius: 16.r,
            padding: EdgeInsetsDirectional.all(16.w),
            borderColor: _cardBorder,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.tripDetailsVisaAndEntryTitle,
                  style: AppTextStyles.subtitle(color: AppColors.darkText)
                      .copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 6.h),
                SelectableText(
                  visa,
                  style: AppTextStyles.caption(
                    color: AppColors.tripDetailsSecondaryGrey,
                  ).copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.45,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],
        const _DestinationDetailsGridCard(),
      ],
    );
  }
}

class _CarouselDestination {
  const _CarouselDestination({required this.name, this.imageUrl});

  final String name;
  final String? imageUrl;
}

class _DestinationPhotoCard extends StatelessWidget {
  const _DestinationPhotoCard({
    required this.name,
    required this.imageUrl,
    required this.size,
    required this.borderRadius,
  });

  final String name;
  final String? imageUrl;
  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppCachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: size,
              height: size,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.scrim.withValues(alpha: 0),
                    AppColors.scrim.withValues(alpha: 0.55),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              start: 12.w,
              end: 12.w,
              bottom: 12.h,
              child: Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyMedium(color: AppColors.onImage)
                    .copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  letterSpacing: 0,
                  shadows: [
                    Shadow(
                      color: AppColors.scrim.withValues(alpha: 0.4),
                      blurRadius: 8.r,
                      offset: Offset(0, 1.h),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DestinationDetailsGridCard extends StatelessWidget {
  const _DestinationDetailsGridCard();

  static final Color _cardBorder = AppColors.border.withValues(alpha: 0.35);

  @override
  Widget build(BuildContext context) {
    final items = <_DestinationDetailsItemData>[
      _DestinationDetailsItemData(
        icon: Iconsax.global,
        title: context.tr.tripDetailsDestinationVisaLabel,
        subtitle: context.tr.tripDetailsDestinationVisaValue,
      ),
      _DestinationDetailsItemData(
        icon: Iconsax.health,
        title: context.tr.tripDetailsDestinationRequiredVaccinesLabel,
        subtitle: context.tr.tripDetailsDestinationRequiredVaccinesValue,
      ),
      _DestinationDetailsItemData(
        icon: Iconsax.clock,
        title: context.tr.tripDetailsDestinationTimeLabel,
        subtitle: context.tr.tripDetailsDestinationTimeValue,
      ),
      _DestinationDetailsItemData(
        icon: Iconsax.translate,
        title: context.tr.tripDetailsDestinationLanguageLabel,
        subtitle: context.tr.tripDetailsDestinationLanguageValue,
      ),
      _DestinationDetailsItemData(
        icon: Icons.euro_rounded,
        title: context.tr.tripDetailsDestinationCurrencyLabel,
        subtitle: context.tr.tripDetailsDestinationCurrencyValue,
      ),
      _DestinationDetailsItemData(
        icon: Icons.thermostat_outlined,
        title: context.tr.tripDetailsDestinationTemperatureLabel,
        subtitle: context.tr.tripDetailsDestinationTemperatureValue,
      ),
      _DestinationDetailsItemData(
        icon: Iconsax.bus,
        title: context.tr.tripDetailsDestinationPublicTransportationLabel,
        subtitle: context.tr.tripDetailsDestinationPublicTransportationValue,
      ),
      _DestinationDetailsItemData(
        icon: Icons.local_taxi_rounded,
        title: context.tr.tripDetailsDestinationTaxiAppsLabel,
        subtitle: context.tr.tripDetailsDestinationTaxiAppsValue,
      ),
    ];

    return TripDetailsInfoCard(
      withShadow: true,
      borderRadius: 24.r,
      padding: EdgeInsetsDirectional.all(16.w),
      borderColor: _cardBorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.tr.tripDetailsDestinationDetailsTitle,
            style: AppTextStyles.heading3(color: AppColors.darkText).copyWith(
              height: 1.1,
              letterSpacing: 0,
            ),
          ),
          SizedBox(height: 8.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 24.h,
              mainAxisExtent: 60.h,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) =>
                _DestinationDetailsItem(data: items[index]),
          ),
        ],
      ),
    );
  }
}

class _DestinationDetailsItemData {
  const _DestinationDetailsItemData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
}

class _DestinationDetailsItem extends StatelessWidget {
  const _DestinationDetailsItem({required this.data});

  final _DestinationDetailsItemData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 32.w,
          height: 32.w,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.tripDetailsDestinationIconTileBg,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Icon(
                data.icon,
                size: 16.sp,
                color: AppColors.tripDetailsDestinationIconPurple,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.caption(color: AppColors.darkText).copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  letterSpacing: 0,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                data.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    AppTextStyles.caption(color: AppColors.greyText).copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

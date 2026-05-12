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

  List<_CarouselDestination> _carouselDestinations() {
    final out = <_CarouselDestination>[];
    final seen = <int>{};
    final fallbackDescription = trip.overview.isNotEmpty
        ? trip.overview
        : trip.description;
    for (final d in trip.destinations) {
      if (seen.add(d.id)) {
        out.add(
          _CarouselDestination(
            name: d.name,
            description: d.description.isNotEmpty
                ? d.description
                : fallbackDescription,
            imageUrl: d.coverImage,
          ),
        );
      }
    }
    if (out.isEmpty && trip.destination != null) {
      final p = trip.destination!;
      out.add(
        _CarouselDestination(
          name: p.name,
          description: fallbackDescription,
          imageUrl: p.image,
        ),
      );
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    final carousel = _carouselDestinations();

    final destCardSize = 132.w;
    final destCardHeight = destCardSize + 48.h;
    final destCardRadius = 16.r;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (carousel.isNotEmpty) ...[
          Text(
            context.tr.tripDetailsDestinationsTitle,
            style: AppTextStyles.heading3(color: AppColors.darkText(context)).copyWith(
              height: 1.1,
              letterSpacing: 0,
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            height: destCardHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              reverse: Directionality.of(context) == TextDirection.rtl,
              padding: EdgeInsets.zero,
              itemCount: carousel.length > 8 ? 8 : carousel.length,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (context, i) {
                final d = carousel[i];
                return _DestinationPhotoCard(
                  name: d.name,
                  description: d.description,
                  imageUrl: d.imageUrl,
                  size: destCardSize,
                  borderRadius: destCardRadius,
                );
              },
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
  const _CarouselDestination({
    required this.name,
    this.description = '',
    this.imageUrl,
  });

  final String name;
  final String description;
  final String? imageUrl;
}

class _DestinationPhotoCard extends StatelessWidget {
  const _DestinationPhotoCard({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.size,
    required this.borderRadius,
  });

  final String name;
  final String description;
  final String? imageUrl;
  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (imageUrl == null) return;
        showDialog<void>(
          context: context,
          builder: (_) => GestureDetector(
            onTap: () => Navigator.pop(context),
            child: InteractiveViewer(
              child: Center(
                child: AppCachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      },
      child: SizedBox(
        width: size,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
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
                        style:
                            AppTextStyles.bodyMedium(color: AppColors.onImage)
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
            ),
            SizedBox(height: 8.h),
            Text(
              description.trim(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.caption(
                color: AppColors.secondaryText(context),
              ).copyWith(
                fontSize: 12.sp,
                height: 1.25,
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
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

  @override
  Widget build(BuildContext context) {
    final cardBorder = AppColors.border(context).withValues(alpha: 0.35);
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
      borderColor: cardBorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.tr.tripDetailsDestinationDetailsTitle,
            style: AppTextStyles.heading3(color: AppColors.darkText(context)).copyWith(
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
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 14.h,
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
              color: AppColors.tripDetailsDestinationIconTileBg(context),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Icon(
                data.icon,
                size: 16.sp,
                color: AppColors.tripDetailsDestinationIconPurple(context),
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
                style: AppTextStyles.caption(color: AppColors.darkText(context)).copyWith(
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
                    AppTextStyles.caption(color: AppColors.greyText(context)).copyWith(
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

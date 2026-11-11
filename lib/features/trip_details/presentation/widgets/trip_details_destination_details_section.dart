import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import 'package:trip_marche/core/widgets/app_modal_bottom_sheet.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'trip_details_info_card.dart';

class TripDetailsDestinationDetailsSection extends StatelessWidget {
  const TripDetailsDestinationDetailsSection({super.key, required this.trip});

  final TripDetails trip;

  List<_CarouselDestination> _carouselDestinations() {
    if (trip.journeyHighlights.isNotEmpty) {
      return trip.journeyHighlights
          .map(
            (highlight) => _CarouselDestination(
              name: highlight.name,
              description: highlight.description,
              imageUrl: highlight.imageUrl,
            ),
          )
          .toList();
    }
    final out = <_CarouselDestination>[];
    final seen = <int>{};
    final fallbackDescription = trip.overview.isNotEmpty
        ? trip.overview
        : trip.description;
    if (trip.stops.isNotEmpty) {
      return trip.stops.map((stop) {
        String? image = stop.coverImage;
        for (final destination in trip.destinations) {
          if (image != null) break;
          if (destination.name.toLowerCase() == stop.city.toLowerCase()) {
            image = destination.coverImage;
            break;
          }
        }
        if (image == null &&
            trip.destination?.name.toLowerCase() == stop.city.toLowerCase()) {
          image = trip.destination?.image;
        }
        return _CarouselDestination(
          name: stop.city,
          description: stop.description,
          imageUrl: image,
        );
      }).toList();
    }
    if (trip.primaryDestinationName.isNotEmpty && trip.destination == null) {
      out.add(
        _CarouselDestination(
          name: trip.primaryDestinationName,
          description: fallbackDescription,
        ),
      );
    }
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
    final destCardHeight = destCardSize;
    final destCardRadius = 16.r;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (carousel.isNotEmpty) ...[
          Text(
            context.tr.tripDetailsDestinationsTitle,
            style: AppTextStyles.heading3(
              color: AppColors.darkText(context),
            ).copyWith(height: 1.1, letterSpacing: 0),
          ),
          SizedBox(height: 10.h),
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
        ],
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

  void _showDetailSheet(BuildContext context) {
    showAppModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBg(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.w, 10.h, 20.w, 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 55.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.border(context),
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              if (imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: AppCachedNetworkImage(
                    imageUrl: imageUrl,
                    width: double.infinity,
                    height: 220.h,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(height: 16.h),
              Text(
                name,
                textAlign: TextAlign.start,
                style:
                    AppTextStyles.heading3(
                      color: AppColors.darkText(context),
                    ).copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
              ),
              if (description.trim().isNotEmpty) ...[
                SizedBox(height: 10.h),
                Text(
                  description.trim(),
                  textAlign: TextAlign.start,
                  style: AppTextStyles.body(
                    color: AppColors.secondaryText(context),
                  ).copyWith(fontSize: 14.sp, height: 1.5),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDetailSheet(context),
      child: ClipRRect(
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
      ),
    );
  }
}

class TripDetailsDestinationDetailsGridCard extends StatelessWidget {
  const TripDetailsDestinationDetailsGridCard({super.key, required this.trip});
  final TripDetails trip;

  @override
  Widget build(BuildContext context) {
    final information = trip.destinationInformation.isNotEmpty
        ? trip.destinationInformation
        : [
            if (trip.visaDetails?.trim().isNotEmpty ?? false)
              TripDestinationInformation(visa: trip.visaDetails!),
          ];
    if (information.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        for (final info in information) _informationCard(context, info),
      ],
    );
  }

  Widget _informationCard(
    BuildContext context,
    TripDestinationInformation info,
  ) {
    final items = <_DestinationDetailsItemData>[
      _DestinationDetailsItemData(
        icon: Iconsax.ticket,
        title: context.tr.tripDetailsDestinationVisaLabel,
        subtitle: info.visa,
      ),
      _DestinationDetailsItemData(
        icon: Iconsax.health4,
        title: context.tr.tripDetailsDestinationRequiredVaccinesLabel,
        subtitle: info.vaccinations,
      ),
      _DestinationDetailsItemData(
        icon: Iconsax.clock,
        title: context.tr.tripDetailsDestinationTimeLabel,
        subtitle: info.timeZone,
      ),
      _DestinationDetailsItemData(
        icon: Iconsax.global,
        title: context.tr.tripDetailsDestinationLanguageLabel,
        subtitle: info.language,
      ),
      _DestinationDetailsItemData(
        icon: Icons.payments_outlined,
        title: context.tr.tripDetailsDestinationCurrencyLabel,
        subtitle: info.currency,
      ),
      _DestinationDetailsItemData(
        icon: Icons.thermostat_outlined,
        title: context.tr.tripDetailsDestinationTemperatureLabel,
        subtitle: info.temperature,
      ),
      _DestinationDetailsItemData(
        icon: Iconsax.bus,
        title: context.tr.tripDetailsDestinationPublicTransportationLabel,
        subtitle: info.publicTransportation,
      ),
      _DestinationDetailsItemData(
        icon: Icons.local_taxi_rounded,
        title: context.tr.tripDetailsDestinationTaxiAppsLabel,
        subtitle: info.taxiApps,
      ),
    ].where((item) => item.subtitle.trim().isNotEmpty).toList();
    if (items.isEmpty && info.notes.trim().isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: TripDetailsInfoCard(
        withShadow: true,
        borderRadius: 24.r,
        padding: EdgeInsetsDirectional.all(16.w),
        borderColor: AppColors.border(context).withValues(alpha: 0.35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              info.destination.isNotEmpty
                  ? info.destination
                  : context.tr.tripDetailsDestinationDetailsTitle,
              style: AppTextStyles.heading3(color: AppColors.darkText(context)),
            ),
            for (final item in items)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: _DestinationDetailsItem(data: item),
              ),
            if (info.notes.trim().isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: SelectableText(
                  info.notes,
                  style: AppTextStyles.body(color: AppColors.greyText(context)),
                ),
              ),
          ],
        ),
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
                style: AppTextStyles.caption(color: AppColors.darkText(context))
                    .copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      letterSpacing: 0,
                    ),
              ),
              SizedBox(height: 2.h),
              Text(
                data.subtitle,
                style: AppTextStyles.caption(color: AppColors.greyText(context))
                    .copyWith(
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

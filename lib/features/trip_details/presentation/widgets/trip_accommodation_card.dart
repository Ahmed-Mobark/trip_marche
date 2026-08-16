import 'dart:math' show min;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/styles/font_utils.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import 'package:trip_marche/core/widgets/app_image_gallery_screen.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';

import 'google_maps_link_button.dart';

const Color _kAccommodationTitleValueLight = Color(0xFF000000);

class TripAccommodationCard extends StatelessWidget {
  const TripAccommodationCard({super.key, required this.accommodation});

  final TripAccommodation accommodation;

  Color _valueColor(BuildContext context) => AppColors.isDark(context)
      ? AppColors.darkText(context)
      : _kAccommodationTitleValueLight;

  @override
  Widget build(BuildContext context) {
    final hotelName = accommodation.name;
    final hotelLocation = accommodation.address;
    final imageUrls = accommodation.images;
    final lat = accommodation.lat;
    final lng = accommodation.lng;

    final hotelNameStyle = TextStyle(
      fontFamily: AppFont.fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.15,
      letterSpacing: 0,
      color: _valueColor(context),
    );
    final locationStyle = TextStyle(
      fontFamily: AppFont.fontFamily,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      height: 1.15,
      letterSpacing: 0,
      color: AppColors.white,
    );

    final thumbs = imageUrls.length;
    final visible = min(3, thumbs);
    final hasMapTarget =
        (lat != null && lng != null) || hotelLocation.trim().isNotEmpty;

    // Extract city name from address (e.g. "Corniche Rd, Hurghada, Red Sea" → "Hurghada")
    final addressParts = hotelLocation
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    final cityName = addressParts.length > 1
        ? addressParts[1]
        : (addressParts.isNotEmpty ? addressParts[0] : '');

    return Container(
      padding: EdgeInsetsDirectional.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.cardBg(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.softBorder(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (cityName.isNotEmpty) ...[
            Container(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 8.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.tripDetailsHeroCompanyAccent,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(cityName, style: locationStyle),
            ),
            const SizedBox(height: 6),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  hotelName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: hotelNameStyle,
                ),
              ),
              if (hasMapTarget) ...[
                const SizedBox(width: 8),
                GoogleMapsLinkButton(
                  label: hotelLocation.isNotEmpty ? hotelLocation : hotelName,
                  lat: lat,
                  lng: lng,
                ),
              ],
            ],
          ),
          if (visible > 0) ...[
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < visible; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  Expanded(
                    child: _AccommodationGalleryThumb(
                      imageUrl: imageUrls[i],
                      imageUrls: imageUrls,
                      index: i,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _AccommodationGalleryThumb extends StatelessWidget {
  const _AccommodationGalleryThumb({
    required this.imageUrl,
    required this.imageUrls,
    required this.index,
  });

  final String imageUrl;
  final List<String> imageUrls;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => AppImageGalleryScreen.open(
          context,
          imageUrls: imageUrls,
          initialIndex: index,
        ),
        borderRadius: BorderRadius.circular(11),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(11),
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: AppCachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

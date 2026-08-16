import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/styles/font_utils.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'google_maps_link_button.dart';
import 'trip_details_info_card.dart';

class TripDetailsPostStatsSections extends StatelessWidget {
  const TripDetailsPostStatsSections({super.key, required this.trip});

  final TripDetails trip;

  @override
  Widget build(BuildContext context) {
    final inclusions = trip.inclusions
        .map((e) => e.label)
        .where((s) => s.isNotEmpty)
        .toList();

    final overviewBorder = AppColors.border(context).withValues(alpha: 0.35);

    return Column(
      children: [
        const SizedBox(height: 12),
        TripDetailsInfoCard(
          padding: EdgeInsetsDirectional.all(20.w),
          borderRadius: 16.r,
          borderColor: overviewBorder,
          withShadow: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.tripDetailsOverviewTitle,
                style: AppTextStyles.body(color: AppColors.darkText(context))
                    .copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
              ),
              SizedBox(height: 8.h),
              Text(
                trip.overview.isNotEmpty ? trip.overview : trip.description,
                style:
                    AppTextStyles.body(
                      color: AppColors.tripDetailsSecondaryGrey(context),
                    ).copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        if (inclusions.isNotEmpty)
          TripDetailsInfoCard(
            padding: const EdgeInsetsDirectional.only(
              start: 20,
              end: 20,
              top: 20,
              bottom: 20,
            ),
            borderRadius: 24,
            borderColor: AppColors.border(context).withValues(alpha: 0.32),
            withShadow: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr.tripDetailsWhatsIncludedTitle,
                  style: TextStyle(
                    fontFamily: AppFont.fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.0,
                    letterSpacing: 0,
                    color: AppColors.darkText(context),
                  ),
                ),
                const SizedBox(height: 8),
                _IncludedGrid(items: inclusions),
              ],
            ),
          ),
        if (inclusions.isNotEmpty) SizedBox(height: 12.h),
      ],
    );
  }
}

class _IncludedGrid extends StatelessWidget {
  const _IncludedGrid({required this.items});

  final List<String> items;

  /// Figma: tight rows; gutter 8 vertical, 16 horizontal; flat cells (wide aspect).
  static const double _mainAxisSpacing = 6;
  static const double _crossAxisSpacing = 12;

  /// Wide cells; tall enough for two lines at 14px (Figma-tight rows via [mainAxisSpacing]).
  static const double _childAspectRatio = 4.5;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: _mainAxisSpacing,
        crossAxisSpacing: _crossAxisSpacing,
        childAspectRatio: _childAspectRatio,
      ),
      itemBuilder: (context, i) {
        return _IncludedItem(text: items[i]);
      },
    );
  }
}

class _IncludedItem extends StatelessWidget {
  const _IncludedItem({required this.text});

  final String text;

  static const double _iconSize = 16;
  static const double _iconTextGap = 8;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.check,
          size: _iconSize,
          color: AppColors.tripDetailsInclusionCheck,
        ),
        const SizedBox(width: _iconTextGap),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: AppFont.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.2,
              letterSpacing: 0,
              color: AppColors.darkText(context),
            ),
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class TripDetailsDepartureDetailsCard extends StatelessWidget {
  const TripDetailsDepartureDetailsCard({super.key, required this.trip});

  final TripDetails trip;

  @override
  Widget build(BuildContext context) {
    final meetingLocation = trip.meeting.location.trim();
    final meetingTime = trip.meeting.time.trim();
    final returnLocation = trip.returnPoint.location.trim();
    final returnTime = trip.returnPoint.time.trim();

    final meetingLines = meetingLocation
        .split('\n')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final hasMeeting = meetingLines.isNotEmpty || meetingTime.isNotEmpty;
    final hasReturn = returnLocation.isNotEmpty || returnTime.isNotEmpty;

    if (!hasMeeting && !hasReturn) {
      return const SizedBox.shrink();
    }

    return TripDetailsInfoCard(
      padding: EdgeInsetsDirectional.all(20.w),
      borderRadius: 20.r,
      borderColor: AppColors.border(context).withValues(alpha: 0.35),
      withShadow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Departure & Return',
            style: TextStyle(
              fontFamily: AppFont.fontFamily,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              height: 1.1,
              letterSpacing: 0,
              color: AppColors.darkText(context),
            ),
          ),
          if (hasMeeting) ...[
            if (meetingLines.length > 1) ...[
              for (var i = 0; i < meetingLines.length; i++) ...[
                SizedBox(height: 16.h),
                _DeparturePointRow(
                  icon: Iconsax.location,
                  label: '${context.tr.tripDetailsMeetingLocationLabel} ${i + 1}',
                  address: meetingLines[i],
                  time: meetingTime,
                  lat: trip.meeting.lat,
                  lng: trip.meeting.lng,
                ),
              ],
            ] else ...[
              SizedBox(height: 16.h),
              _DeparturePointRow(
                icon: Iconsax.location,
                label: meetingLines.isNotEmpty
                    ? '${context.tr.tripDetailsMeetingLocationLabel} 1'
                    : context.tr.tripDetailsMeetingLocationLabel,
                address: meetingLines.isNotEmpty ? meetingLines.first : '',
                time: meetingTime,
                lat: trip.meeting.lat,
                lng: trip.meeting.lng,
              ),
            ],
          ],
          if (hasReturn) ...[
            SizedBox(height: 16.h),
            _DeparturePointRow(
              icon: Iconsax.routing_2,
              label: context.tr.tripDetailsReturnLocationLabel,
              address: returnLocation,
              time: returnTime,
              lat: trip.returnPoint.lat,
              lng: trip.returnPoint.lng,
            ),
          ],
        ],
      ),
    );
  }
}

class _DeparturePointRow extends StatelessWidget {
  const _DeparturePointRow({
    required this.icon,
    required this.label,
    required this.address,
    required this.time,
    this.lat,
    this.lng,
  });

  final IconData icon;
  final String label;
  final String address;
  final String time;
  final double? lat;
  final double? lng;

  @override
  Widget build(BuildContext context) {
    final hasCoords = lat != null && lng != null;
    final hasLabel = address.trim().isNotEmpty;
    final hasMapsTarget = hasCoords || hasLabel;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Icon(
            icon,
            color: AppColors.tripDetailsDepartureIconPurple,
            size: 22.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (label.isNotEmpty)
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: AppFont.fontFamily,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    letterSpacing: 0,
                    color: AppColors.greyText(context),
                  ),
                ),
              if (address.isNotEmpty) ...[
                SizedBox(height: 2.h),
                Text(
                  address,
                  style: TextStyle(
                    fontFamily: AppFont.fontFamily,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                    letterSpacing: 0,
                    color: AppColors.darkText(context),
                  ),
                ),
              ],
              if (time.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(
                  time,
                  style: TextStyle(
                    fontFamily: AppFont.fontFamily,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    letterSpacing: 0,
                    color: AppColors.tripDetailsDepartureIconPurple,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (hasMapsTarget) ...[
          SizedBox(width: 10.w),
          GoogleMapsLinkButton(
            label: address,
            lat: lat,
            lng: lng,
            size: 38.r,
          ),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/styles/font_utils.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
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
                style: AppTextStyles.body(color: AppColors.darkText(context)).copyWith(
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
        SizedBox(height: 16.h),
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
        if (inclusions.isNotEmpty) SizedBox(height: 16.h),
        TripDetailsInfoCard(
          padding: const EdgeInsetsDirectional.only(
            start: 16,
            end: 16,
            top: 16,
            bottom: 16,
          ),
          borderRadius: 14,
          borderColor: AppColors.tripDetailsHairline(context),
          withShadow: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.tr.tripDetailsDepartureDetailsTitle,
                style: TextStyle(
                  fontFamily: AppFont.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                  letterSpacing: 0,
                  color: AppColors.darkText(context),
                ),
              ),
              const SizedBox(height: 12),
              _LocationRow(
                icon: Iconsax.location,
                label: context.tr.tripDetailsMeetingLocationLabel,
                value: trip.meeting.location,
                trailing: trip.meeting.lat != null && trip.meeting.lng != null
                    ? _MapButton(onTap: () {})
                    : null,
              ),
              const SizedBox(height: 12),
              _LocationRow(
                icon: Iconsax.routing_2,
                label: context.tr.tripDetailsReturnLocationLabel,
                value: trip.returnPoint.location,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _TimeRow(
                      icon: Iconsax.profile_2user,
                      label: context.tr.tripDetailsMeetingTimeLabel,
                      value: trip.meeting.time,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _TimeRow(
                      icon: Iconsax.clock,
                      label: context.tr.tripDetailsReturnTimeLabel,
                      value: trip.returnPoint.time,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
  static const double _childAspectRatio = 3.45;

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

class _LocationRow extends StatelessWidget {
  const _LocationRow({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: AppColors.tripDetailsDepartureIconPurple,
          size: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: AppFont.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.15,
                  letterSpacing: 0,
                  color: AppColors.greyText(context),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontFamily: AppFont.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  letterSpacing: 0,
                  color: AppColors.darkText(context),
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) ...[const SizedBox(width: 8), trailing!],
      ],
    );
  }
}

class _TimeRow extends StatelessWidget {
  const _TimeRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: AppColors.tripDetailsDepartureIconPurple,
          size: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: AppFont.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.15,
                  letterSpacing: 0,
                  color: AppColors.greyText(context),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontFamily: AppFont.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  letterSpacing: 0,
                  color: AppColors.darkText(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MapButton extends StatelessWidget {
  const _MapButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.isDark(context)
                ? AppColors.inputBg(context)
                : AppColors.tripDetailsMapButtonBg,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.tripDetailsHairline(context)),
          ),
          child: Icon(
            Icons.map_rounded,
            color: AppColors.tripDetailsMapIconBlue,
            size: 18,
          ),
        ),
      ),
    );
  }
}

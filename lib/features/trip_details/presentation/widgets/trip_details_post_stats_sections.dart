import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
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
    final inclusions = trip.inclusions.map((e) => e.label).where((s) => s.isNotEmpty).toList();

    final overviewBorder =
        AppColors.border.withValues(alpha: 0.42);

    return Column(
      children: [
        SizedBox(height: 24.h),
        TripDetailsInfoCard(
          padding: EdgeInsetsDirectional.all(24.w),
          borderRadius: 18.r,
          borderColor: overviewBorder,
          withShadow: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.tripDetailsOverviewTitle,
                style: AppTextStyles.body(
                  color: AppColors.darkText,
                ).copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                trip.overview.isNotEmpty ? trip.overview : trip.description,
                style: AppTextStyles.body(
                  color: AppColors.tripDetailsSecondaryGrey,
                ).copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        if (inclusions.isNotEmpty)
          TripDetailsInfoCard(
            padding: EdgeInsetsDirectional.all(24.w),
            borderRadius: 26.r,
            borderColor: AppColors.border.withValues(alpha: 0.32),
            withShadow: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.tripDetailsWhatsIncludedTitle,
                  style: AppTextStyles.body(
                    color: AppColors.darkText,
                  ).copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 20.h),
                _IncludedGrid(items: inclusions),
              ],
            ),
          ),
        if (inclusions.isNotEmpty) SizedBox(height: 20.h),
        TripDetailsInfoCard(
          padding: EdgeInsetsDirectional.all(20.w),
          borderRadius: 24.r,
          borderColor: AppColors.border.withValues(alpha: 0.28),
          withShadow: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.tripDetailsDepartureDetailsTitle,
                style: AppTextStyles.body(
                  color: AppColors.darkText,
                ).copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 18.h),
              _LocationRow(
                icon: Iconsax.location,
                label: context.tr.tripDetailsMeetingLocationLabel,
                value: trip.meeting.location,
                trailing: trip.meeting.lat != null && trip.meeting.lng != null
                    ? _MapButton(onTap: () {})
                    : null,
              ),
              SizedBox(height: 20.h),
              _LocationRow(
                icon: Iconsax.routing_2,
                label: context.tr.tripDetailsReturnLocationLabel,
                value: trip.returnPoint.location,
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: _TimeRow(
                      icon: Iconsax.profile_2user,
                      label: context.tr.tripDetailsMeetingTimeLabel,
                      value: trip.meeting.time,
                    ),
                  ),
                  SizedBox(width: 24.w),
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

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 28.w,
        childAspectRatio: 3.15,
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

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.check_outlined,
          size: 17.sp,
          color: AppColors.tripDetailsInclusionCheck,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.body(
              color: AppColors.darkText,
            ).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              height: 1.35,
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
          size: 24.sp,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTextStyles.caption(
                  color: AppColors.tripDetailsSecondaryGrey,
                ).copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.25,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.darkText,
                ).copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) ...[SizedBox(width: 12.w), trailing!],
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
          size: 24.sp,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTextStyles.caption(
                  color: AppColors.tripDetailsSecondaryGrey,
                ).copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.25,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.darkText,
                ).copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.35,
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
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          width: 40.r,
          height: 40.r,
          decoration: BoxDecoration(
            color: AppColors.tripDetailsMapButtonBg,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: AppColors.border.withValues(alpha: 0.18),
            ),
          ),
          child: Icon(
            Icons.map_rounded,
            color: AppColors.tripDetailsMapIconBlue,
            size: 22.sp,
          ),
        ),
      ),
    );
  }
}

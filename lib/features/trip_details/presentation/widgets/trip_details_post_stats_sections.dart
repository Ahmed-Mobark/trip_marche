import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_details_info_card.dart';

class TripDetailsPostStatsSections extends StatelessWidget {
  const TripDetailsPostStatsSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        TripDetailsInfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.tripDetailsOverviewTitle,
                style: AppTextStyles.body(
                  color: AppColors.darkText,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.h),
              Text(
                context.tr.tripDetailsOverviewBody,
                style: AppTextStyles.body(
                  color: AppColors.greyText,
                ).copyWith(height: 1.45),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        TripDetailsInfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.tripDetailsWhatsIncludedTitle,
                style: AppTextStyles.body(
                  color: AppColors.darkText,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
              // SizedBox(height: 16.h),
              const _IncludedGrid(),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        TripDetailsInfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.tripDetailsDepartureDetailsTitle,
                style: AppTextStyles.body(
                  color: AppColors.darkText,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 16.h),
              _LocationRow(
                icon: Iconsax.location,
                label: context.tr.tripDetailsMeetingLocationLabel,
                value: context.tr.tripDetailsMeetingLocationValue,
                trailing: _MapButton(onTap: () {}),
              ),
              SizedBox(height: 18.h),
              _LocationRow(
                icon: Iconsax.routing_2,
                label: context.tr.tripDetailsReturnLocationLabel,
                value: context.tr.tripDetailsReturnLocationValue,
              ),
              SizedBox(height: 18.h),
              Row(
                children: [
                  Expanded(
                    child: _TimeRow(
                      icon: Iconsax.clock,
                      label: context.tr.tripDetailsMeetingTimeLabel,
                      value: context.tr.tripDetailsMeetingTimeValue,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: _TimeRow(
                      icon: Iconsax.clock,
                      label: context.tr.tripDetailsReturnTimeLabel,
                      value: context.tr.tripDetailsReturnTimeValue,
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
  const _IncludedGrid();

  @override
  Widget build(BuildContext context) {
    final items = [
      context.tr.tripDetailsIncludedFlightTickets,
      context.tr.tripDetailsIncludedHotelStay,
      context.tr.tripDetailsIncludedBreakfast,
      context.tr.tripDetailsIncludedAirportTransfer,
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 19.w,
        childAspectRatio: 3.0,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check, size: 22.sp, color: AppColors.success),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium(
              color: AppColors.darkText,
            ).copyWith(fontWeight: FontWeight.w500, fontSize: 15.sp),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary, size: 24.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.body(color: AppColors.greyText)),
              SizedBox(height: 4.h),
              Text(value, style: AppTextStyles.body(color: AppColors.darkText)),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary, size: 24.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.body(color: AppColors.greyText)),
              SizedBox(height: 4.h),
              Text(value, style: AppTextStyles.body(color: AppColors.darkText)),
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
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: 44.r,
          height: 44.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 12.r,
                offset: Offset(0, 6.h),
              ),
            ],
          ),
          child: Icon(Iconsax.map_1, color: AppColors.primary, size: 22.sp),
        ),
      ),
    );
  }
}

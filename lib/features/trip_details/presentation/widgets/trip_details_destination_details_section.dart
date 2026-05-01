import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/config/styles/styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/theme/app_colors.dart';
import 'trip_details_info_card.dart';

class TripDetailsDestinationDetailsSection extends StatelessWidget {
  const TripDetailsDestinationDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.tripDetailsDestinationDetailsTitle,
          style: TextStyles.textViewBold14,
        ),
        SizedBox(height: 14.h),
        const _DestinationDetailsCard(),
      ],
    );
  }
}

class _DestinationDetailsCard extends StatelessWidget {
  const _DestinationDetailsCard();

  @override
  Widget build(BuildContext context) {
    final items = <_DestinationDetailsItemData>[
      _DestinationDetailsItemData(
        icon: Iconsax.ticket,
        label: context.tr.tripDetailsDestinationVisaLabel,
        value: context.tr.tripDetailsDestinationVisaValue,
      ),
      _DestinationDetailsItemData(
        icon: Iconsax.health,
        label: context.tr.tripDetailsDestinationRequiredVaccinesLabel,
        value: context.tr.tripDetailsDestinationRequiredVaccinesValue,
      ),
      _DestinationDetailsItemData(
        icon: Iconsax.clock,
        label: context.tr.tripDetailsDestinationTimeLabel,
        value: context.tr.tripDetailsDestinationTimeValue,
      ),
      _DestinationDetailsItemData(
        icon: Iconsax.language_circle,
        label: context.tr.tripDetailsDestinationLanguageLabel,
        value: context.tr.tripDetailsDestinationLanguageValue,
      ),
      _DestinationDetailsItemData(
        icon: Iconsax.dollar_circle,
        label: context.tr.tripDetailsDestinationCurrencyLabel,
        value: context.tr.tripDetailsDestinationCurrencyValue,
      ),
      _DestinationDetailsItemData(
        icon: Iconsax.cloud_sunny,
        label: context.tr.tripDetailsDestinationTemperatureLabel,
        value: context.tr.tripDetailsDestinationTemperatureValue,
      ),
      _DestinationDetailsItemData(
        icon: Iconsax.bus,
        label: context.tr.tripDetailsDestinationPublicTransportationLabel,
        value: context.tr.tripDetailsDestinationPublicTransportationValue,
      ),
      _DestinationDetailsItemData(
        icon: Iconsax.car,
        label: context.tr.tripDetailsDestinationTaxiAppsLabel,
        value: context.tr.tripDetailsDestinationTaxiAppsValue,
      ),
    ];

    return TripDetailsInfoCard(
      withShadow: false,
      borderRadius: 16.r,
      padding: EdgeInsetsDirectional.all(16.r),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 3.3,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) =>
            _DestinationDetailsItem(data: items[index]),
      ),
    );
  }
}

class _DestinationDetailsItemData {
  const _DestinationDetailsItemData({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}

class _DestinationDetailsItem extends StatelessWidget {
  const _DestinationDetailsItem({required this.data});
  final _DestinationDetailsItemData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28.r,
          height: 28.r,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(data.icon, size: 16.sp, color: AppColors.primary),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                data.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.caption(color: AppColors.greyText),
              ),
              SizedBox(height: 4.h),
              Text(
                data.value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.darkText,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

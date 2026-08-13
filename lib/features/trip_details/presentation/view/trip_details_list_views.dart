import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'package:trip_marche/features/trip_details/presentation/trip_details_ui_formatters.dart';

class TripAllActivitiesView extends StatelessWidget {
  const TripAllActivitiesView({
    super.key,
    required this.activities,
    required this.currency,
  });

  final List<TripDetailsActivity> activities;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg(context),
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBg(context),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.darkText(context),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          context.tr.tripDetailsSeeAllActivities,
          style: AppTextStyles.subtitle(color: AppColors.darkText(context)),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 24.h),
        itemCount: activities.length,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          final activity = activities[index];
          return Container(
            padding: EdgeInsetsDirectional.all(14.w),
            decoration: BoxDecoration(
              color: AppColors.cardBg(context),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: AppColors.softBorder(context)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    activity.label,
                    style: AppTextStyles.bodyMedium(
                      color: AppColors.darkText(context),
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  TripDetailsUiFormatters.formatAmount(
                    activity.price,
                    currency: currency,
                  ),
                  style: AppTextStyles.bodyMedium(color: AppColors.primary)
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TripAllAccommodationView extends StatelessWidget {
  const TripAllAccommodationView({super.key, required this.accommodations});

  final List<TripAccommodation> accommodations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg(context),
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBg(context),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.darkText(context),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          context.tr.tripDetailsSeeAllAccommodation,
          style: AppTextStyles.subtitle(color: AppColors.darkText(context)),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 24.h),
        itemCount: accommodations.length,
        separatorBuilder: (_, __) => SizedBox(height: 14.h),
        itemBuilder: (context, index) {
          final hotel = accommodations[index];
          final imageUrl =
              hotel.images.isNotEmpty ? hotel.images.first : null;
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
                if (imageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: AppCachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                if (imageUrl != null) SizedBox(height: 12.h),
                Text(
                  hotel.name,
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.darkText(context),
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
                if (hotel.address.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Iconsax.location,
                        size: 14.sp,
                        color: AppColors.greyText(context),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          hotel.address,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.greyText(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

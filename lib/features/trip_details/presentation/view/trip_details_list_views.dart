import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_accommodation_card.dart';

class TripAllActivitiesView extends StatelessWidget {
  const TripAllActivitiesView({super.key, required this.rates});

  final List<TripActivityRate> rates;

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
        itemCount: rates.length,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          final rate = rates[index];
          return Container(
            width: double.infinity,
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 14.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.cardBg(context),
              borderRadius: BorderRadius.circular(999.r),
              border: Border.all(color: AppColors.border(context)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    rate.label.isNotEmpty ? rate.label : rate.key,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmall(
                      color: AppColors.darkText(context),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  '${rate.value}/10',
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.starYellow,
                  ).copyWith(fontWeight: FontWeight.w700),
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
          return TripAccommodationCard(accommodation: hotel);
        },
      ),
    );
  }
}

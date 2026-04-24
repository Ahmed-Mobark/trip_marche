import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_details_info_card.dart';

class TripDetailsProgramSection extends StatelessWidget {
  const TripDetailsProgramSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 20.h),
      child: TripDetailsInfoCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr.tripDetailsProgramTitle,
              style: TextStyles.textViewBold14,
            ),
            SizedBox(height: 16.h),
            _DayCard(
              dayLabel: context.tr.tripDetailsProgramDay1,
              city: context.tr.tripDetailsProgramCity1,
              mealCodes: const ['B', 'L', 'D'],
              items: [
                context.tr.tripDetailsProgramDay1Item1,
                context.tr.tripDetailsProgramDay1Item2,
                context.tr.tripDetailsProgramDay1Item3,
                context.tr.tripDetailsProgramDay1Item4,
              ],
            ),
            SizedBox(height: 14.h),
            _DayCard(
              dayLabel: context.tr.tripDetailsProgramDay2,
              city: context.tr.tripDetailsProgramCity2,
              mealCodes: const ['B', 'D'],
              items: [
                context.tr.tripDetailsProgramDay2Item1,
                context.tr.tripDetailsProgramDay2Item2,
                context.tr.tripDetailsProgramDay2Item3,
              ],
            ),
            SizedBox(height: 18.h),
            Center(
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                ),
                child: Text(
                  context.tr.tripDetailsProgramSeeAll,
                  style: AppTextStyles.subtitle(
                    color: AppColors.primary,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  const _DayCard({
    required this.dayLabel,
    required this.city,
    required this.mealCodes,
    required this.items,
  });

  final String dayLabel;
  final String city;
  final List<String> mealCodes;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.7)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 18.w,
              vertical: 14.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.lightBg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.border.withValues(alpha: 0.7),
                ),
              ),
            ),
            child: Text(dayLabel, style: TextStyles.textViewSemiBold16),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: 18.w,
              end: 18.w,
              top: 18.h,
              bottom: 18.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(city, style: TextStyles.textViewSemiBold16),
                    ),
                    SizedBox(width: 12.w),
                    _MealsBadgeRow(codes: mealCodes),
                  ],
                ),
                SizedBox(height: 12.h),
                ...items.map(
                  (t) => Padding(
                    padding: EdgeInsetsDirectional.only(top: 10.h),
                    child: _ChecklistRow(text: t),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MealsBadgeRow extends StatelessWidget {
  const _MealsBadgeRow({required this.codes});

  final List<String> codes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 5.w,
            vertical: 2.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.lightBg,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.7)),
          ),
          child: Text(
            context.tr.tripDetailsProgramMealsLabel,
            style: TextStyles.textViewBold10,
          ),
        ),
        SizedBox(width: 6.w),
        ...codes.map(
          (c) => Padding(
            padding: EdgeInsetsDirectional.only(start: 6.w),
            child: _MealCodeChip(code: c),
          ),
        ),
      ],
    );
  }
}

class _MealCodeChip extends StatelessWidget {
  const _MealCodeChip({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.r,
      height: 24.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(code, style: TextStyles.textViewBold10),
    );
  }
}

class _ChecklistRow extends StatelessWidget {
  const _ChecklistRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Iconsax.tick_circle,
          size: 20.sp,
          color: AppColors.warning.withValues(alpha: 0.95),
        ),
        SizedBox(width: 12.w),
        Expanded(child: Text(text, style: TextStyles.textViewRegular14)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import '../cubit/trip_details_cubit.dart';
import '../cubit/trip_details_state.dart';
import 'trip_details_info_card.dart';

class TripDetailsProgramSection extends StatelessWidget {
  const TripDetailsProgramSection({super.key, required this.trip});

  final TripDetails trip;

  static List<String> _mealCodes(TripDayMeals meals) {
    final c = <String>[];
    if (meals.breakfast) {
      c.add('B');
    }
    if (meals.lunch) {
      c.add('L');
    }
    if (meals.dinner) {
      c.add('D');
    }
    return c;
  }

  @override
  Widget build(BuildContext context) {
    final days = trip.days;
    if (days.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsetsDirectional.only(top: 20.h),
      child: TripDetailsInfoCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr.tripDetailsProgramTitle,
              style: AppTextStyles.body(
                color: AppColors.darkText,
              ).copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 16.h),
            BlocBuilder<TripDetailsCubit, TripDetailsState>(
              buildWhen: (p, n) => p.expandedDayIndex != n.expandedDayIndex,
              builder: (context, state) {
                return Column(
                  children: [
                    for (var i = 0; i < days.length; i++) ...[
                      if (i > 0) SizedBox(height: 14.h),
                      _DayCard(
                        dayLabel:
                            '${context.tr.tripDetailsProgramDayPrefix} ${days[i].dayNumber}',
                        city: days[i].title,
                        mealCodes: _mealCodes(days[i].meals),
                        items: days[i].items,
                        expanded: state.expandedDayIndex == i,
                        onHeaderTap: () => context
                            .read<TripDetailsCubit>()
                            .toggleExpandedDay(i),
                      ),
                    ],
                  ],
                );
              },
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
    required this.expanded,
    required this.onHeaderTap,
  });

  final String dayLabel;
  final String city;
  final List<String> mealCodes;
  final List<String> items;
  final bool expanded;
  final VoidCallback onHeaderTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.7)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onHeaderTap,
            borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
            child: Container(
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
              child: Row(
                children: [
                  Expanded(
                    child: Text(dayLabel, style: TextStyles.textViewSemiBold16),
                  ),
                  Icon(
                    expanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
                    size: 18.sp,
                    color: AppColors.greyText,
                  ),
                ],
              ),
            ),
          ),
          if (expanded)
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

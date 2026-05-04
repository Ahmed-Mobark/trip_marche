import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
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

    final collapsible = days.length > 1;
    final programBorder = AppColors.border.withValues(alpha: 0.32);

    return Padding(
      padding: EdgeInsetsDirectional.only(top: 24.h),
      child: TripDetailsInfoCard(
        padding: EdgeInsetsDirectional.all(20.w),
        borderRadius: 24.r,
        borderColor: programBorder,
        withShadow: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr.tripDetailsProgramTitle,
              style: AppTextStyles.body(
                color: AppColors.darkText,
              ).copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            SizedBox(height: 14.h),
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
                        collapsible: collapsible,
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
    required this.collapsible,
    required this.onHeaderTap,
  });

  final String dayLabel;
  final String city;
  final List<String> mealCodes;
  final List<String> items;
  final bool expanded;
  final bool collapsible;
  final VoidCallback onHeaderTap;

  static final Color _innerBorder =
      AppColors.border.withValues(alpha: 0.4);

  @override
  Widget build(BuildContext context) {
    final radius = 16.r;

    final header = Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.tripDetailsProgramDayHeaderBar,
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
        border: Border(
          bottom: BorderSide(color: _innerBorder),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              dayLabel,
              style: AppTextStyles.subtitle(
                color: AppColors.darkText,
              ).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ),
          if (collapsible)
            Icon(
              expanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
              size: 18.sp,
              color: AppColors.tripDetailsSecondaryGrey,
            ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: _innerBorder),
      ),
      child: Column(
        children: [
          if (collapsible)
            InkWell(
              onTap: onHeaderTap,
              borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
              child: header,
            )
          else
            header,
          if (expanded || !collapsible)
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 16.w,
                end: 16.w,
                top: 16.h,
                bottom: 20.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          city,
                          style: AppTextStyles.subtitle(
                            color: AppColors.darkText,
                          ).copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      _MealsBadgeRow(codes: mealCodes),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  for (var i = 0; i < items.length; i++) ...[
                    if (i > 0) SizedBox(height: 14.h),
                    _ChecklistRow(text: items[i]),
                  ],
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          context.tr.tripDetailsProgramMealsLabel,
          style: AppTextStyles.caption(
            color: AppColors.tripDetailsSecondaryGrey,
          ).copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
        ),
        SizedBox(width: 8.w),
        for (var i = 0; i < codes.length; i++) ...[
          if (i > 0) SizedBox(width: 6.w),
          _MealCodeChip(code: codes[i]),
        ],
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
        color: AppColors.tripDetailsProgramOrange,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        code,
        style: AppTextStyles.small(
          color: AppColors.onImage,
        ).copyWith(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
    );
  }
}

class _ChecklistRow extends StatelessWidget {
  const _ChecklistRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 20.r,
          height: 20.r,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.tripDetailsProgramOrange,
          ),
          child: Icon(
            Icons.check,
            size: 12.sp,
            color: AppColors.onImage,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium(
              color: AppColors.darkText,
            ).copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}

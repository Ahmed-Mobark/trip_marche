import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/styles/font_utils.dart';
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

    final collapsible = days.length > 1;

    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 12),
      child: TripDetailsInfoCard(
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
              context.tr.tripDetailsProgramTitle,
              style: TextStyle(
                fontFamily: AppFont.fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.0,
                letterSpacing: 0,
                color: AppColors.darkText(context),
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<TripDetailsCubit, TripDetailsState>(
              buildWhen: (p, n) => p.expandedDayIndex != n.expandedDayIndex,
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < days.length; i++) ...[
                      if (i > 0) const SizedBox(height: 10),
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

  static const double _radius = 12;

  @override
  Widget build(BuildContext context) {
    final header = Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.only(
        start: 16,
        end: 16,
        top: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.tripDetailsProgramHeaderBg(context),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(_radius),
        ),
        border: Border(
          bottom: BorderSide(color: AppColors.tripDetailsHairline(context)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              dayLabel,
              style: TextStyle(
                fontFamily: AppFont.fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 1.15,
                letterSpacing: 0,
                color: AppColors.darkText(context),
              ),
            ),
          ),
          if (collapsible)
            Icon(
              expanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
              size: 16,
              color: AppColors.greyText(context),
            ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg(context),
        borderRadius: BorderRadius.circular(_radius),
        border: Border.all(color: AppColors.tripDetailsHairline(context)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (collapsible)
            InkWell(
              onTap: onHeaderTap,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(_radius),
              ),
              child: header,
            )
          else
            header,
          if (expanded || !collapsible)
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 16,
                end: 16,
                top: 16,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          city,
                          style: TextStyle(
                            fontFamily: AppFont.fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            height: 1.15,
                            letterSpacing: 0,
                            color: AppColors.darkText(context),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _MealsBadgeRow(codes: mealCodes),
                    ],
                  ),
                  const SizedBox(height: 12),
                  for (var i = 0; i < items.length; i++) ...[
                    if (i > 0) const SizedBox(height: 8),
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
        Container(
          padding: const EdgeInsetsDirectional.only(
            start: 6,
            end: 6,
            top: 3,
            bottom: 3,
          ),
          decoration: BoxDecoration(
            color: AppColors.tripDetailsProgramHeaderBg(context),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            context.tr.tripDetailsProgramMealsLabel,
            style: TextStyle(
              fontFamily: AppFont.fontFamily,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              height: 1.15,
              letterSpacing: 0,
              color: AppColors.darkText(context),
            ),
          ),
        ),
        const SizedBox(width: 6),
        for (var i = 0; i < codes.length; i++) ...[
          if (i > 0) const SizedBox(width: 4),
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
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.tripDetailsProgramOrange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: AppFont.fontFamily,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          height: 1,
          letterSpacing: 0,
          color: AppColors.onImage,
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
          width: 18,
          height: 18,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.tripDetailsProgramOrange,
          ),
          child: const Icon(
            Icons.check,
            size: 10,
            color: AppColors.onImage,
          ),
        ),
        const SizedBox(width: 8),
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
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/bookings_cubit.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_cubit.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_state.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_tab.dart';
import 'package:trip_marche/features/my_trips/presentation/my_trips_figma_tokens.dart';

/// Figma: three equal pill tabs — selected purple + white label; unselected white + grey border.
class MyTripsScreenTabs extends StatelessWidget {
  const MyTripsScreenTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTripsShellCubit, MyTripsShellState>(
      builder: (context, state) {
        final shellCubit = context.read<MyTripsShellCubit>();
        final bookingsCubit = context.read<BookingsCubit>();
        return Padding(
          padding: EdgeInsetsDirectional.only(
            start: MyTripsFigmaTokens.padH,
            end: MyTripsFigmaTokens.padH,
            bottom: MyTripsFigmaTokens.tabRowTop,
            top: MyTripsFigmaTokens.tabRowTop,
          ),
          child: Row(
            children: [
              Expanded(
                child: _TabPill(
                  label: context.tr.myTripsTabActive,
                  selected: state.tab == MyTripsShellTab.active,
                  onTap: () {
                    shellCubit.selectTab(MyTripsShellTab.active);
                    bookingsCubit.changeStatus(MyTripsShellTab.active);
                  },
                ),
              ),
              SizedBox(width: MyTripsFigmaTokens.tabGap),
              Expanded(
                child: _TabPill(
                  label: context.tr.myTripsTabPastNew,
                  selected: state.tab == MyTripsShellTab.past,
                  onTap: () {
                    shellCubit.selectTab(MyTripsShellTab.past);
                    bookingsCubit.changeStatus(MyTripsShellTab.past);
                  },
                ),
              ),
              SizedBox(width: MyTripsFigmaTokens.tabGap),
              Expanded(
                child: _TabPill(
                  label: context.tr.myTripsTabCanceled,
                  selected: state.tab == MyTripsShellTab.canceled,
                  onTap: () {
                    shellCubit.selectTab(MyTripsShellTab.canceled);
                    bookingsCubit.changeStatus(MyTripsShellTab.canceled);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TabPill extends StatelessWidget {
  const _TabPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          MyTripsFigmaTokens.searchRadiusPill,
        ),
        child: Container(
          height: MyTripsFigmaTokens.tabHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected
                ? AppColors.myTripsPrimary
                : AppColors.myTripsOutlineButtonFill(context),
            borderRadius: BorderRadius.circular(
              MyTripsFigmaTokens.searchRadiusPill,
            ),
            border: Border.all(
              color: selected
                  ? AppColors.myTripsPrimary
                  : AppColors.myTripsBorderFigma,
              width: 1.w,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: MyTripsFigmaTokens.tabPadH),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: MyTripsFigmaTokens.text(
              fontSize: MyTripsFigmaTokens.tabFontSize,
              fontWeight: FontWeight.w600,
              height: MyTripsFigmaTokens.tabLineHeight,
              color: selected ? AppColors.white : AppColors.myTripsMetaGrey,
            ),
          ),
        ),
      ),
    );
  }
}

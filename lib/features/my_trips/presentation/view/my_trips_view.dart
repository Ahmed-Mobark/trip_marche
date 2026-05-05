import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_cubit.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_state.dart';
import 'package:trip_marche/features/my_trips/presentation/my_trips_figma_tokens.dart';
import 'package:trip_marche/features/my_trips/presentation/widgets/my_trips_screen_tabs.dart';
import 'package:trip_marche/features/my_trips/presentation/widgets/my_trips_screen_trip_card.dart';

/// Static My Trips UI — [MyTripsShellCubit] only (local dummy rows, no APIs).
class MyTripsView extends StatelessWidget {
  const MyTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MyTripsShellCubit>(),
      child: const _MyTripsViewBody(),
    );
  }
}

class _MyTripsViewBody extends StatelessWidget {
  const _MyTripsViewBody();

  static double get _searchBarHeight => 44.h;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTripsShellCubit, MyTripsShellState>(
      builder: (context, state) {
        final cubit = context.read<MyTripsShellCubit>();
        final q = state.searchQuery.trim().toLowerCase();
        final trips = q.isEmpty
            ? state.trips
            : state.trips
                .where((t) => t.title.toLowerCase().contains(q))
                .toList();

        return Scaffold(
          backgroundColor: AppColors.primary,
          body: Stack(
            fit: StackFit.expand,
            children: [
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: MyTripsFigmaTokens.padH,
                        end: MyTripsFigmaTokens.padH,
                        top: MyTripsFigmaTokens.headerPadTop,
                        bottom: MyTripsFigmaTokens.headerPadBottom,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          context.tr.myTripsTitle,
                          style: MyTripsFigmaTokens.text(
                            fontSize: MyTripsFigmaTokens.headerTitleSize,
                            fontWeight: FontWeight.w700,
                            height: MyTripsFigmaTokens.headerTitleLineHeight,
                            color: AppColors.onImage,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(MyTripsFigmaTokens.sheetTopRadius),
                        ),
                      ),
                      child: CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: ClampingScrollPhysics(),
                        ),
                        slivers: [
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: MyTripsFigmaTokens.padH,
                                end: MyTripsFigmaTokens.padH,
                                top: MyTripsFigmaTokens.searchBlockTop,
                              ),
                              child: _SearchField(
                                onChanged: cubit.setSearchQuery,
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: MyTripsScreenTabs(),
                          ),
                          SliverPadding(
                            padding: EdgeInsetsDirectional.only(
                              start: MyTripsFigmaTokens.padH,
                              end: MyTripsFigmaTokens.padH,
                              top: MyTripsFigmaTokens.listPadTop,
                              bottom: MyTripsFigmaTokens.listPadBottom,
                            ),
                            sliver: SliverList.separated(
                              itemCount: trips.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: MyTripsFigmaTokens.cardSeparator),
                              itemBuilder: (context, index) {
                                return MyTripsScreenTripCard(
                                  trip: trips[index],
                                  tab: state.tab,
                                  onPrimaryTap: () {},
                                  onSecondaryTap: () {},
                                  onBottomTap: () {},
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(MyTripsFigmaTokens.searchRadiusPill),
      borderSide: BorderSide(
        color: AppColors.myTripsBorderFigma,
        width: 1.w,
      ),
    );

    return SizedBox(
      height: _MyTripsViewBody._searchBarHeight,
      child: TextField(
        onChanged: onChanged,
        style: MyTripsFigmaTokens.text(
          fontSize: MyTripsFigmaTokens.searchFontSize,
          fontWeight: FontWeight.w400,
          height: MyTripsFigmaTokens.searchLineHeight,
          color: AppColors.darkText,
        ),
        cursorColor: AppColors.myTripsPrimary,
        decoration: InputDecoration(
          isDense: true,
          hintText: context.tr.myTripsSearchHint,
          hintStyle: MyTripsFigmaTokens.text(
            fontSize: MyTripsFigmaTokens.searchFontSize,
            fontWeight: FontWeight.w400,
            height: MyTripsFigmaTokens.searchLineHeight,
            color: AppColors.catalogMetaMuted,
          ),
          prefixIcon: Icon(
            Iconsax.search_normal_1,
            size: MyTripsFigmaTokens.searchIconSize,
            color: AppColors.catalogMetaMuted,
          ),
          filled: true,
          fillColor: AppColors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: MyTripsFigmaTokens.searchContentPadH,
            vertical: MyTripsFigmaTokens.searchContentPadV,
          ),
          border: border,
          enabledBorder: border,
          focusedBorder: border,
        ),
      ),
    );
  }
}

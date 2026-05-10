import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/widgets/app_trip_search_text_field.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_cubit.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_state.dart';
import 'package:trip_marche/features/my_trips/presentation/my_trips_figma_tokens.dart';
import 'package:trip_marche/features/my_trips/presentation/widgets/my_trips_screen_tabs.dart';
import 'package:trip_marche/features/my_trips/presentation/widgets/my_trips_screen_trip_card.dart';

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

class _MyTripsViewBody extends StatefulWidget {
  const _MyTripsViewBody();

  @override
  State<_MyTripsViewBody> createState() => _MyTripsViewBodyState();
}

class _MyTripsViewBodyState extends State<_MyTripsViewBody> {
  late final TextEditingController _searchCtrl;

  @override
  void initState() {
    super.initState();
    _searchCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

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
                decoration: BoxDecoration(gradient: AppColors.primaryGradient),
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
                          style:
                              AppTextStyles.heading2(
                                color: AppColors.onImage,
                              ).copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.cardBg(context),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(
                            MyTripsFigmaTokens.sheetTopRadius,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: MyTripsFigmaTokens.padH,
                              end: MyTripsFigmaTokens.padH,
                              top: MyTripsFigmaTokens.searchBlockTop,
                            ),
                            child: AppTripSearchTextField(
                              controller: _searchCtrl,
                              hintText: context.tr.myTripsSearchHint,
                              onChanged: cubit.setSearchQuery,
                              onClear: () {
                                _searchCtrl.clear();
                                cubit.setSearchQuery('');
                              },
                            ),
                          ),
                          const MyTripsScreenTabs(),

                          Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsetsDirectional.only(
                                start: MyTripsFigmaTokens.padH,
                                end: MyTripsFigmaTokens.padH,
                                top: MyTripsFigmaTokens.listPadTop,
                                bottom: MyTripsFigmaTokens.listPadBottom,
                              ),
                              itemCount: trips.length,
                              separatorBuilder: (_, __) => SizedBox(
                                height: MyTripsFigmaTokens.cardSeparator,
                              ),
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

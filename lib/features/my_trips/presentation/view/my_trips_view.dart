import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/widgets/app_trip_search_text_field.dart';
import 'package:trip_marche/features/my_trips/domain/entities/booking_entity.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/bookings_cubit.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/bookings_state.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_cubit.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_state.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_tab.dart';
import 'package:trip_marche/features/my_trips/presentation/my_trips_figma_tokens.dart';
import 'package:trip_marche/features/my_trips/presentation/widgets/my_trips_screen_trip_card.dart';
import 'package:trip_marche/features/my_trips/presentation/widgets/my_trips_screen_tabs.dart';
import 'package:trip_marche/features/trip_details/presentation/view/trip_details_view.dart';

class MyTripsView extends StatelessWidget {
  const MyTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<MyTripsShellCubit>()),
        BlocProvider(create: (_) => sl<BookingsCubit>()),
      ],
      child: const _MyTripsViewBody(),
    );
  }
}

BookingStatusCategory _categoryForTab(MyTripsShellTab tab) {
  switch (tab) {
    case MyTripsShellTab.active:
      return BookingStatusCategory.active;
    case MyTripsShellTab.past:
      return BookingStatusCategory.past;
    case MyTripsShellTab.canceled:
      return BookingStatusCategory.cancelled;
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
    context.read<BookingsCubit>().loadInitial();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onBookingTap(Booking booking) {
    sl<AppNavigator>().push(
      screen: TripDetailsView(tripId: booking.trip.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTripsShellCubit, MyTripsShellState>(
      builder: (context, shellState) {
        final shellCubit = context.read<MyTripsShellCubit>();
        final category = _categoryForTab(shellState.tab);
        final q = shellState.searchQuery.trim().toLowerCase();

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
                          style: AppTextStyles.heading2(
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
                              onChanged: shellCubit.setSearchQuery,
                              onClear: () {
                                _searchCtrl.clear();
                                shellCubit.setSearchQuery('');
                              },
                            ),
                          ),
                          const MyTripsScreenTabs(),
                          Expanded(
                            child: BlocBuilder<BookingsCubit, BookingsState>(
                              builder: (context, bookingsState) {
                                return _BookingsList(
                                  state: bookingsState,
                                  category: category,
                                  tab: shellState.tab,
                                  query: q,
                                  onBookingTap: _onBookingTap,
                                  onRetry: () =>
                                      context.read<BookingsCubit>().loadInitial(),
                                  onRefresh: () =>
                                      context.read<BookingsCubit>().refresh(),
                                  onLoadMore: () =>
                                      context.read<BookingsCubit>().loadMore(),
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

class _BookingsList extends StatelessWidget {
  const _BookingsList({
    required this.state,
    required this.category,
    required this.tab,
    required this.query,
    required this.onBookingTap,
    required this.onRetry,
    required this.onRefresh,
    required this.onLoadMore,
  });

  final BookingsState state;
  final BookingStatusCategory category;
  final MyTripsShellTab tab;
  final String query;
  final void Function(Booking) onBookingTap;
  final VoidCallback onRetry;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;

  List<Booking> get _filtered {
    final inTab = state.bookings
        .where((b) => b.statusCategory == category)
        .toList();
    if (query.isEmpty) {
      return inTab;
    }
    return inTab.where((b) {
      final q = query;
      return b.trip.title.toLowerCase().contains(q) ||
          b.trip.fromLocation.toLowerCase().contains(q) ||
          b.reference.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (state.status == BookingsStatus.loading && state.bookings.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == BookingsStatus.failure && state.bookings.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(MyTripsFigmaTokens.padH),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.errorMessage ?? context.tr.myTripsEmptyDescription,
                textAlign: TextAlign.center,
                style: MyTripsFigmaTokens.text(
                  fontSize: MyTripsFigmaTokens.metaFontSize,
                  color: AppColors.greyText(context),
                ),
              ),
              SizedBox(height: 12.h),
              ElevatedButton(
                onPressed: onRetry,
                child: Text(context.tr.myTripsExploreTrips),
              ),
            ],
          ),
        ),
      );
    }

    final items = _filtered;
    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(MyTripsFigmaTokens.padH),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.tr.myTripsEmptyTitle,
                style: AppTextStyles.subtitle(
                  color: AppColors.darkText(context),
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                context.tr.myTripsEmptyDescription,
                textAlign: TextAlign.center,
                style: MyTripsFigmaTokens.text(
                  fontSize: MyTripsFigmaTokens.metaFontSize,
                  color: AppColors.greyText(context),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              notification.metrics.extentAfter < 120.h &&
              state.hasMore) {
            onLoadMore();
          }
          return false;
        },
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsetsDirectional.only(
            start: MyTripsFigmaTokens.padH,
            end: MyTripsFigmaTokens.padH,
            top: MyTripsFigmaTokens.listPadTop,
            bottom: MyTripsFigmaTokens.listPadBottom,
          ),
          itemCount: items.length + (state.hasMore ? 1 : 0),
          separatorBuilder: (_, __) =>
              SizedBox(height: MyTripsFigmaTokens.cardSeparator),
          itemBuilder: (context, index) {
            if (index >= items.length) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final booking = items[index];
            return MyTripsScreenTripCard(
              trip: _toRowModel(booking),
              tab: tab,
              onPrimaryTap: () => onBookingTap(booking),
              onSecondaryTap: () => onBookingTap(booking),
              onBottomTap: () => onBookingTap(booking),
            );
          },
        ),
      ),
    );
  }
}

MyTripRowUiModel _toRowModel(Booking booking) {
  return MyTripRowUiModel(
    id: booking.id,
    title: booking.trip.title,
    rating: 0.0,
    reviewCount: 0,
    locationLabel: booking.trip.fromLocation,
    dateRange: booking.dates.range,
    imageUrl: booking.trip.coverImage,
    isWishlisted: false,
    useDownloadPdfWhenActive: false,
  );
}

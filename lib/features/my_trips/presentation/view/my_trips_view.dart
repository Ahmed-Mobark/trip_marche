import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/toast/app_toast.dart';
import 'package:trip_marche/core/widgets/app_trip_search_text_field.dart';
import 'package:trip_marche/features/my_trips/domain/entities/booking_entity.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/bookings_cubit.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/bookings_state.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_cubit.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_state.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_tab.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/booking_pdf_cubit.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/booking_pdf_state.dart';
import 'package:trip_marche/features/my_trips/presentation/my_trips_figma_tokens.dart';
import 'package:trip_marche/features/my_trips/presentation/view/booking_pdf_viewer_screen.dart';
import 'package:trip_marche/features/my_trips/presentation/widgets/my_trips_screen_trip_card.dart';
import 'package:trip_marche/features/my_trips/presentation/widgets/my_trips_screen_tabs.dart';
import 'package:trip_marche/features/trip_details/presentation/view/trip_details_view.dart';
import 'package:trip_marche/features/trip_details/presentation/trip_wishlist_pop_result.dart';

class MyTripsView extends StatelessWidget {
  const MyTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<MyTripsShellCubit>()),
        BlocProvider(create: (_) => sl<BookingsCubit>()),
        BlocProvider(create: (_) => sl<BookingPdfCubit>()),
      ],
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
    final bookingsCubit = context.read<BookingsCubit>();
    final shellCubit = context.read<MyTripsShellCubit>();

    for (final b in bookingsCubit.state.bookings) {
      debugPrint(
        '[MyTrips] Initial favorite for trip ${b.trip.id} (${b.trip.title}) = ${shellCubit.isWishlisted(b.trip.id)}',
      );
    }

    bookingsCubit.loadInitial();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _onBookingTap(Booking booking) async {
    final shellCubit = context.read<MyTripsShellCubit>();
    debugPrint('[MyTrips] Tap trip ${booking.trip.id} (${booking.trip.title})');

    final result = await sl<AppNavigator>().push<TripWishlistPopResult>(
      screen: TripDetailsView(
        tripId: booking.trip.id,
        initialIsWishlisted: shellCubit.isWishlisted(booking.trip.id),
      ),
    );

    if (result == null || !mounted) {
      return;
    }

    debugPrint(
      '[MyTrips] Returned from trip details tripId=${result.tripId} isWishlisted=${result.isWishlisted}',
    );
    shellCubit.applyWishlistStateFromDetails(
      result.tripId,
      result.isWishlisted,
    );
  }

  Future<void> _onBookingPdfTap(Booking booking) async {
    final pdfCubit = context.read<BookingPdfCubit>();
    await pdfCubit.fetchAndOpen(booking.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTripsShellCubit, MyTripsShellState>(
      builder: (context, shellState) {
      final bookingsCubit = context.read<BookingsCubit>();

      return BlocListener<BookingPdfCubit, BookingPdfState>(
        listener: (context, pdfState) {
          if (pdfState.status == BookingPdfStatus.success &&
              pdfState.filePath != null) {
            sl<AppNavigator>().push(
              screen: BookingPdfViewerScreen(
                filePath: pdfState.filePath!,
                title: 'Booking Details',
              ),
            );
            context.read<BookingPdfCubit>().reset();
          } else if (pdfState.status == BookingPdfStatus.failure &&
              pdfState.errorMessage != null) {
            appToast(
              context: context,
              type: ToastType.error,
              message: pdfState.errorMessage!,
            );
            context.read<BookingPdfCubit>().reset();
          }
        },
        child: Scaffold(
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
                              onChanged: (q) => bookingsCubit.updateSearch(q),
                              onClear: () {
                                _searchCtrl.clear();
                                bookingsCubit.updateSearch('');
                              },
                            ),
                          ),
                          const MyTripsScreenTabs(),
                          Expanded(
                            child: BlocBuilder<BookingsCubit, BookingsState>(
                              builder: (context, bookingsState) {
                                return _BookingsList(
                                  state: bookingsState,
                                  tab: shellState.tab,
                                  onBookingTap: _onBookingTap,
                                  onBookingPdfTap: _onBookingPdfTap,
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
        ),
      );
    },
  );
}
}

class _BookingsList extends StatelessWidget {
  const _BookingsList({
    required this.state,
    required this.tab,
    required this.onBookingTap,
    required this.onBookingPdfTap,
    required this.onRetry,
    required this.onRefresh,
    required this.onLoadMore,
  });

  final BookingsState state;
  final MyTripsShellTab tab;
  final void Function(Booking) onBookingTap;
  final void Function(Booking) onBookingPdfTap;
  final VoidCallback onRetry;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;

  List<Booking> get _filtered => state.bookings;

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

    return BlocBuilder<MyTripsShellCubit, MyTripsShellState>(
      builder: (context, shellState) {
        final shellCubit = context.read<MyTripsShellCubit>();

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
                final isFav = shellCubit.isWishlisted(booking.trip.id);

                debugPrint(
                  '[MyTrips] Render trip ${booking.trip.id} (${booking.trip.title}) isWishlisted=$isFav',
                );

                return BlocBuilder<BookingPdfCubit, BookingPdfState>(
                  builder: (context, pdfState) {
                    final isPdfLoading =
                        pdfState.isLoadingFor(booking.id);
                    return MyTripsScreenTripCard(
                      trip: _toRowModel(booking, isFav),
                      tab: tab,
                      onPrimaryTap: () => onBookingTap(booking),
                      onSecondaryTap: () => onBookingPdfTap(booking),
                      onBottomTap: isPdfLoading
                          ? null
                          : () => onBookingPdfTap(booking),
                      isPdfLoading: isPdfLoading,
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

MyTripRowUiModel _toRowModel(Booking booking, bool isWishlisted) {
  return MyTripRowUiModel(
    id: booking.id,
    title: booking.trip.title,
    rating: 0.0,
    reviewCount: 0,
    locationLabel: booking.trip.fromLocation,
    dateRange: booking.dates.range,
    imageUrl: booking.trip.coverImage,
    isWishlisted: isWishlisted,
    useDownloadPdfWhenActive: false,
  );
}

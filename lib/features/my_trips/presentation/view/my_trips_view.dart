import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_images.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/toast/app_toast.dart';
import 'package:trip_marche/core/widgets/app_button.dart';
import 'package:trip_marche/core/widgets/app_trip_search_text_field.dart';
import 'package:trip_marche/core/widgets/custom_loading.dart';
import 'package:trip_marche/features/booking/presentation/view/payment_webview_screen.dart';
import 'package:trip_marche/features/my_trips/domain/entities/booking_entity.dart';
import 'package:trip_marche/features/my_trips/domain/usecases/retry_booking_payment_usecase.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/booking_pdf_cubit.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/booking_pdf_state.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/bookings_cubit.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/bookings_state.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_cubit.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_state.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_tab.dart';
import 'package:trip_marche/features/my_trips/presentation/my_trips_figma_tokens.dart';
import 'package:trip_marche/features/my_trips/presentation/view/booking_pdf_viewer_screen.dart';
import 'package:trip_marche/features/my_trips/presentation/widgets/my_trips_screen_tabs.dart';
import 'package:trip_marche/features/my_trips/presentation/widgets/my_trips_screen_trip_card.dart';
import 'package:trip_marche/features/nav_bar/presentation/view/main_nav_view.dart';
import 'package:trip_marche/features/profile/presentation/view/add_vendor_review_view.dart';
import 'package:trip_marche/features/trip_details/presentation/trip_wishlist_pop_result.dart';
import 'package:trip_marche/features/trip_details/presentation/view/trip_details_view.dart';

class MyTripsView extends StatefulWidget {
  const MyTripsView({super.key});

  @override
  State<MyTripsView> createState() => MyTripsViewState();
}

class MyTripsViewState extends State<MyTripsView> {
  final GlobalKey<MyTripsViewBodyState> _bodyKey =
      GlobalKey<MyTripsViewBodyState>();

  Future<void> refreshFromNavBarTap() async {
    await _bodyKey.currentState?.refreshFromNavBarTap();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<MyTripsShellCubit>()),
        BlocProvider(create: (_) => sl<BookingsCubit>()),
        BlocProvider(create: (_) => sl<BookingPdfCubit>()),
      ],
      child: _MyTripsViewBody(key: _bodyKey),
    );
  }
}

class _MyTripsViewBody extends StatefulWidget {
  const _MyTripsViewBody({super.key});

  @override
  State<_MyTripsViewBody> createState() => MyTripsViewBodyState();
}

class MyTripsViewBodyState extends State<_MyTripsViewBody> {
  late final TextEditingController _searchCtrl;
  int? _payingBookingId;

  Future<void> refreshFromNavBarTap() async {
    await context.read<BookingsCubit>().refresh();
  }

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
        pendingBookingId: booking.requiresPayment ? booking.id : null,
        pendingPaymentAmountText: booking.requiresPayment
            ? _paymentAmountText(booking)
            : null,
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

  Future<void> _onRateTripTap(Booking booking) async {
    final vendorId = booking.trip.vendorId;
    debugPrint('[MyTrips] Rate button clicked');
    debugPrint('[MyTrips] TripId: ${booking.trip.id}');
    debugPrint('[MyTrips] VendorId: $vendorId');
    if (vendorId == null) {
      debugPrint(
        '[MyTrips] vendorId is null for trip ${booking.trip.id}, cannot navigate to AddVendorReviewView',
      );
      return;
    }
    log('========== RATE CLICK ==========');
    log('TripId: ${booking.trip.id}');
    log('VendorId: ${booking.trip.vendorId}');

    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => AddVendorReviewView(
          tripId: booking.trip.id,
          vendorId: vendorId,
          title: booking.trip.title,
          imageUrl: booking.trip.coverImage ?? '',
          routeText: booking.trip.fromLocation,
          dateRangeText: booking.dates.range,
        ),
      ),
    );

    if (result == true && mounted) {
      context.read<BookingsCubit>().refresh();
    }
  }

  Future<void> _onBookingPdfTap(Booking booking) async {
    final pdfCubit = context.read<BookingPdfCubit>();
    await pdfCubit.fetchAndOpen(booking.id);
  }

  String _paymentAmountText(Booking booking) {
    final amount = booking.paymentDetail.totalAmountBase.toStringAsFixed(0);
    return '$amount ${booking.baseCurrency}';
  }

  Future<void> _onPayNowTap(Booking booking) async {
    if (_payingBookingId != null) {
      return;
    }
    setState(() => _payingBookingId = booking.id);
    final result = await sl<RetryBookingPaymentUseCase>()(booking.id);
    if (!mounted) {
      return;
    }
    setState(() => _payingBookingId = null);

    result.fold(
      (failure) {
        appToast(
          context: context,
          type: ToastType.error,
          message: failure.message,
        );
      },
      (checkoutUrl) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PaymentWebViewScreen(
              url: checkoutUrl,
              onPaymentComplete: () {
                context.read<BookingsCubit>().refresh();
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTripsShellCubit, MyTripsShellState>(
      builder: (context, shellState) {
        final shellCubit = context.read<MyTripsShellCubit>();
        final bookingsCubit = context.read<BookingsCubit>();

        return MultiBlocListener(
          listeners: [
            BlocListener<BookingPdfCubit, BookingPdfState>(
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
            ),
            BlocListener<BookingsCubit, BookingsState>(
              listenWhen: (previous, current) =>
                  current.status == BookingsStatus.success &&
                  previous.bookings != current.bookings,
              listener: (context, bookingsState) {
                debugPrint(
                  '[MyTrips] Bookings loaded, syncing favoriteStatus for ${bookingsState.bookings.length} bookings',
                );
                shellCubit.syncFavoriteStatusFromBookings(
                  bookingsState.bookings,
                );
              },
            ),
          ],
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
                                    onRateTripTap: _onRateTripTap,
                                    onBookingPdfTap: _onBookingPdfTap,
                                    onPayNowTap: _onPayNowTap,
                                    payingBookingId: _payingBookingId,
                                    onRetry: () => context
                                        .read<BookingsCubit>()
                                        .loadInitial(),
                                    onRefresh: () =>
                                        context.read<BookingsCubit>().refresh(),
                                    onLoadMore: () => context
                                        .read<BookingsCubit>()
                                        .loadMore(),
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
    required this.onRateTripTap,
    required this.onBookingPdfTap,
    required this.onPayNowTap,
    required this.payingBookingId,
    required this.onRetry,
    required this.onRefresh,
    required this.onLoadMore,
  });

  final BookingsState state;
  final MyTripsShellTab tab;
  final void Function(Booking) onBookingTap;
  final void Function(Booking) onRateTripTap;
  final void Function(Booking) onBookingPdfTap;
  final void Function(Booking) onPayNowTap;
  final int? payingBookingId;
  final VoidCallback onRetry;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;

  List<Booking> get _filtered => state.bookings;

  @override
  Widget build(BuildContext context) {
    if (state.status == BookingsStatus.loading && state.bookings.isEmpty) {
      return const Center(child: CustomLoading(top: 40, bottom: 40));
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
              SizedBox(
                width: 140.w,
                height: 140.w,
                child: Image.asset(AppImages.emptyTrips),
              ),
              SizedBox(height: 16.h),
              Text(
                context.tr.myTripsEmptyTitle,
                style: AppTextStyles.subtitle(
                  color: AppColors.darkText(context),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                context.tr.myTripsEmptyDescription,
                textAlign: TextAlign.center,
                style: MyTripsFigmaTokens.text(
                  fontSize: MyTripsFigmaTokens.metaFontSize,
                  color: AppColors.greyText(context),
                ),
              ),
              SizedBox(height: 16.h),
              AppButton(
                heigh: 48.h,
                onTap: () => sl<AppNavigator>().pushAndRemoveUntil(
                  screen: MainNavView(initialIndex: 0),
                ),

                radius: 40.w,
                style: AppTextStyles.body(
                  color: AppColors.white,
                ).copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600),
                text: context.tr.myTripsExploreTrips,
              ),
              SizedBox(height: 8.h),
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
                    child: Center(child: CustomLoading(size: 42)),
                  );
                }
                final booking = items[index];
                final isFav = shellCubit.isWishlisted(booking.trip.id);

                debugPrint(
                  '[MyTrips] Render trip ${booking.trip.id} (${booking.trip.title}) isFavorite=$isFav',
                );

                return GestureDetector(
                  onTap: () => onBookingTap(booking),
                  behavior: HitTestBehavior.opaque,
                  child: BlocBuilder<BookingPdfCubit, BookingPdfState>(
                    builder: (context, pdfState) {
                      final isPdfLoading = pdfState.isLoadingFor(booking.id);
                      final isPayLoading = payingBookingId == booking.id;
                      return MyTripsScreenTripCard(
                        trip: _toRowModel(booking, isFav, context),
                        tab: tab,
                        onPrimaryTap: () => onBookingTap(booking),
                        onSecondaryTap: tab == MyTripsShellTab.past
                            ? (booking.trip.isRated
                                  ? null
                                  : () => onRateTripTap(booking))
                            : () => onBookingTap(booking),
                        onBottomTap: isPdfLoading || isPayLoading
                            ? null
                            : booking.requiresPayment
                            ? () => onPayNowTap(booking)
                            : () => onBookingPdfTap(booking),
                        isPdfLoading: isPdfLoading || isPayLoading,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

MyTripRowUiModel _toRowModel(
  Booking booking,
  bool isFavorite,
  BuildContext context,
) {
  final fromLoc = booking.trip.fromLocation.trim();
  final locLabel = fromLoc.isEmpty
      ? ''
      : (fromLoc.toLowerCase().startsWith('from') || fromLoc.startsWith('من')
            ? fromLoc
            : '${context.tr.myTripsFromPrefix} $fromLoc');

  return MyTripRowUiModel(
    id: booking.id,
    tripId: booking.trip.id,
    title: booking.trip.title,
    rating: booking.trip.rating,
    reviewCount: booking.trip.reviewCount,
    locationLabel: locLabel,
    dateRange: booking.dates.range,
    imageUrl: booking.trip.coverImage,
    isFavorite: isFavorite,
    useDownloadPdfWhenActive: false,
    requiresPayment: booking.requiresPayment,
    paymentStatus: booking.paymentStatus,
    paymentAmountText:
        '${booking.paymentDetail.totalAmountBase.toStringAsFixed(0)} ${booking.baseCurrency}',
    isRated: booking.trip.isRated,
    vendorId: booking.trip.vendorId,
  );
}

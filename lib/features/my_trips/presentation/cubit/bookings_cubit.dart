import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/features/my_trips/domain/entities/booking_entity.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_tab.dart';
import '../../domain/usecases/fetch_bookings_usecase.dart';
import 'bookings_state.dart';

class BookingsCubit extends Cubit<BookingsState> {
  BookingsCubit(this._fetchBookings) : super(const BookingsState());

  final FetchBookingsUseCase _fetchBookings;

  static const int _perPage = 10;
  bool _isFetching = false;
  Timer? _searchDebounce;
  String _currentStatus = 'active';
  String _currentSearch = '';

  String _statusForTab(MyTripsShellTab tab) {
    switch (tab) {
      case MyTripsShellTab.active:
        return 'active';
      case MyTripsShellTab.past:
        return 'previous';
      case MyTripsShellTab.canceled:
        return 'closed';
    }
  }

  Future<void> loadInitial({
    MyTripsShellTab? tab,
    String search = '',
  }) async {
    _currentStatus = _statusForTab(tab ?? MyTripsShellTab.active);
    _currentSearch = search.trim();
    _searchDebounce?.cancel();
    await _fetch(page: 1, reset: true);
  }

  Future<void> changeStatus(MyTripsShellTab tab, {String? search}) async {
    final newStatus = _statusForTab(tab);
    final trimmedSearch = (search ?? _currentSearch).trim();
    if (newStatus == _currentStatus &&
        trimmedSearch == _currentSearch &&
        state.bookings.isNotEmpty) {
      return;
    }
    _currentStatus = newStatus;
    _currentSearch = trimmedSearch;
    _searchDebounce?.cancel();
    await _fetch(page: 1, reset: true);
  }

  Future<void> updateSearch(String search) async {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      _currentSearch = search.trim();
      _fetch(page: 1, reset: true);
    });
  }

  Future<void> refresh() async {
    _searchDebounce?.cancel();
    await _fetch(page: 1, reset: false);
  }

  Future<void> loadMore() async {
    if (!state.hasMore ||
        _isFetching ||
        state.status == BookingsStatus.loading ||
        state.status == BookingsStatus.loadingMore ||
        state.meta == null) {
      return;
    }

    emit(state.copyWith(status: BookingsStatus.loadingMore));

    final result = await _fetchBookings(
      page: state.nextPage,
      status: _currentStatus,
      search: _currentSearch,
      perPage: _perPage,
    );

    result.fold(
      (_) => emit(state.copyWith(status: BookingsStatus.success)),
      (page) {
        final seenIds = state.bookings.map((e) => e.id).toSet();
        final uniqueNew = page.bookings
            .where((e) => !seenIds.contains(e.id))
            .toList();
        emit(
          state.copyWith(
            status: BookingsStatus.success,
            bookings: [...state.bookings, ...uniqueNew],
            meta: page.meta,
          ),
        );
      },
    );
  }

  Future<void> _fetch({required int page, bool reset = false}) async {
    if (_isFetching) {
      return;
    }
    _isFetching = true;
    try {
      if (reset) {
        emit(
          state.copyWith(
            status: BookingsStatus.loading,
            bookings: const [],
            meta: null,
            clearErrorMessage: true,
          ),
        );
      }

      final result = await _fetchBookings(
        page: page,
        status: _currentStatus,
        search: _currentSearch,
        perPage: _perPage,
      );
      result.fold(
        (failure) => emit(
          state.copyWith(
            status: BookingsStatus.failure,
            errorMessage: failure.message,
          ),
        ),
        (page) {
          final seenIds = reset ? <int>{} : state.bookings.map((e) => e.id).toSet();
          final uniqueNew = page.bookings
              .where((e) => !seenIds.contains(e.id))
              .toList();
          emit(
            state.copyWith(
              status: BookingsStatus.success,
              bookings: reset
                  ? uniqueNew
                  : [...state.bookings, ...uniqueNew],
              meta: page.meta,
              clearErrorMessage: true,
            ),
          );
        },
      );
    } finally {
      _isFetching = false;
    }
  }

  /// Splits the in-memory bookings into the requested tab locally.
  List<Booking> bookingsForCategory(BookingStatusCategory category) {
    return state.bookings
        .where((b) => b.statusCategory == category)
        .toList();
  }
}

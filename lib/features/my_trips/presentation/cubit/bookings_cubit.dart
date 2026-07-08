import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/features/my_trips/domain/entities/booking_entity.dart';
import '../../domain/usecases/fetch_bookings_usecase.dart';
import 'bookings_state.dart';

class BookingsCubit extends Cubit<BookingsState> {
  BookingsCubit(this._fetchBookings) : super(const BookingsState());

  final FetchBookingsUseCase _fetchBookings;

  static const int _perPage = 15;
  bool _isFetching = false;

  /// Loads the first page and replaces the current list.
  Future<void> loadInitial() async {
    if (_isFetching) {
      return;
    }
    _isFetching = true;
    try {
      emit(
        state.copyWith(
          status: BookingsStatus.loading,
          bookings: const [],
          meta: null,
          clearErrorMessage: true,
        ),
      );

      final result = await _fetchBookings(page: 1, perPage: _perPage);
      result.fold(
        (failure) => emit(
          state.copyWith(
            status: BookingsStatus.failure,
            errorMessage: failure.message,
          ),
        ),
        (page) => emit(
          state.copyWith(
            status: BookingsStatus.success,
            bookings: page.bookings,
            meta: page.meta,
            clearErrorMessage: true,
          ),
        ),
      );
    } finally {
      _isFetching = false;
    }
  }

  /// Pull-to-refresh: reloads page 1. Single request, no per-tab calls.
  Future<void> refresh() async {
    if (_isFetching) {
      return;
    }
    _isFetching = true;
    try {
      emit(state.copyWith(clearErrorMessage: true));
      final result = await _fetchBookings(page: 1, perPage: _perPage);
      result.fold(
        (failure) => emit(
          state.copyWith(
            status: BookingsStatus.failure,
            errorMessage: failure.message,
          ),
        ),
        (page) => emit(
          state.copyWith(
            status: BookingsStatus.success,
            bookings: page.bookings,
            meta: page.meta,
            clearErrorMessage: true,
          ),
        ),
      );
    } finally {
      _isFetching = false;
    }
  }

  /// Infinite scroll: appends the next page to the existing list.
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

  /// Splits the in-memory bookings into the requested tab locally.
  List<Booking> bookingsForCategory(BookingStatusCategory category) {
    return state.bookings
        .where((b) => b.statusCategory == category)
        .toList();
  }
}

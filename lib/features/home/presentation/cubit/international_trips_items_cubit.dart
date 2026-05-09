import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/features/wishlist/domain/repositories/trip_wishlist_repository.dart';

import '../../data/models/home_section_response.dart';
import '../../data/models/international_trips_items_response.dart';
import '../../domain/repositories/home_repository.dart';
import 'international_trips_items_state.dart';

List<TripModel> _patchTripsWishlisted(
  List<TripModel> trips,
  int tripId,
  bool isWishlisted,
) {
  return trips
      .map((t) => t.id == tripId ? t.copyWith(isWishlisted: isWishlisted) : t)
      .toList();
}

class InternationalTripsItemsCubit extends Cubit<InternationalTripsItemsState> {
  InternationalTripsItemsCubit(this._homeRepository, this._wishlistRepository)
    : super(const InternationalTripsItemsState());

  final HomeRepository _homeRepository;
  final TripWishlistRepository _wishlistRepository;
  final Set<int> _wishlistBusy = {};
  Timer? _searchDebounce;

  static const Duration _searchDebounceDuration = Duration(milliseconds: 500);
  static const int _defaultPerPage = 15;

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }

  void onSearchTextChanged(String raw) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_searchDebounceDuration, () {
      final q = raw.trim();
      if (isClosed || q == state.appliedSearchQuery) {
        return;
      }
      emit(state.copyWith(appliedSearchQuery: q));
      loadInitial();
    });
  }

  void flushSearchNow(String raw) {
    _searchDebounce?.cancel();
    final q = raw.trim();
    if (isClosed) {
      return;
    }
    if (q != state.appliedSearchQuery) {
      emit(state.copyWith(appliedSearchQuery: q));
    }
    loadInitial();
  }

  Future<void> loadInitial() async {
    emit(
      state.copyWith(
        status: InternationalTripsItemsStatus.loading,
        trips: const [],
      ),
    );

    final result = await _homeRepository.getInternationalTripsItems(
      page: 1,
      perPage: _defaultPerPage,
      search: state.appliedSearchQuery,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: InternationalTripsItemsStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (data) {
        final response = InternationalTripsItemsResponse.fromJson(data);
        emit(
          state.copyWith(
            status: InternationalTripsItemsStatus.success,
            trips: response.trips,
            meta: response.meta,
          ),
        );
      },
    );
  }

  Future<void> refresh() async {
    if (state.status != InternationalTripsItemsStatus.success) {
      await loadInitial();
      return;
    }

    final perPage = state.meta?.perPage ?? _defaultPerPage;
    final result = await _homeRepository.getInternationalTripsItems(
      page: 1,
      perPage: perPage,
      search: state.appliedSearchQuery,
    );

    result.fold((_) {}, (data) {
      final response = InternationalTripsItemsResponse.fromJson(data);
      emit(
        state.copyWith(
          status: InternationalTripsItemsStatus.success,
          trips: response.trips,
          meta: response.meta,
        ),
      );
    });
  }

  Future<void> loadMore() async {
    if (!state.hasMore ||
        state.status == InternationalTripsItemsStatus.loadingMore ||
        state.status == InternationalTripsItemsStatus.loading ||
        state.status != InternationalTripsItemsStatus.success) {
      return;
    }

    emit(state.copyWith(status: InternationalTripsItemsStatus.loadingMore));

    final perPage = state.meta?.perPage ?? _defaultPerPage;
    final result = await _homeRepository.getInternationalTripsItems(
      page: state.nextPage,
      perPage: perPage,
      search: state.appliedSearchQuery,
    );

    result.fold(
      (_) {
        emit(state.copyWith(status: InternationalTripsItemsStatus.success));
      },
      (data) {
        final response = InternationalTripsItemsResponse.fromJson(data);
        emit(
          state.copyWith(
            status: InternationalTripsItemsStatus.success,
            trips: [...state.trips, ...response.trips],
            meta: response.meta,
          ),
        );
      },
    );
  }

  Future<void> toggleTripWishlist(int tripId) async {
    if (tripId <= 0 || _wishlistBusy.contains(tripId) || state.trips.isEmpty) {
      return;
    }
    TripModel? trip;
    for (final t in state.trips) {
      if (t.id == tripId) {
        trip = t;
        break;
      }
    }
    if (trip == null) {
      return;
    }

    final previous = trip.isWishlisted;
    _wishlistBusy.add(tripId);
    emit(
      state.copyWith(
        trips: _patchTripsWishlisted(state.trips, tripId, !previous),
        clearWishlistError: true,
      ),
    );

    final result = await _wishlistRepository.toggleWishlist(tripId);
    _wishlistBusy.remove(tripId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            trips: _patchTripsWishlisted(state.trips, tripId, previous),
            wishlistErrorMessage: failure.message,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            trips: _patchTripsWishlisted(
              state.trips,
              tripId,
              success.isWishlisted,
            ),
          ),
        );
      },
    );
  }

  void clearWishlistError() {
    emit(state.copyWith(clearWishlistError: true));
  }

  void syncWishlistFromOtherList(int tripId, bool isWishlisted) {
    if (state.trips.isEmpty) {
      return;
    }
    if (!state.trips.any((t) => t.id == tripId)) {
      return;
    }
    emit(
      state.copyWith(
        trips: _patchTripsWishlisted(state.trips, tripId, isWishlisted),
      ),
    );
  }
}

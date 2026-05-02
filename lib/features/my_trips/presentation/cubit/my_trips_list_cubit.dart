import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';
import 'package:trip_marche/features/wishlist/domain/usecases/toggle_wishlist_usecase.dart';
import '../../domain/usecases/fetch_trips_catalog_usecase.dart';
import 'my_trips_list_state.dart';

class MyTripsListCubit extends Cubit<MyTripsListState> {
  MyTripsListCubit(this._fetchTrips, this._toggleWishlist)
      : super(const MyTripsListState());

  final FetchTripsCatalogUseCase _fetchTrips;
  final ToggleWishlistUseCase _toggleWishlist;
  final Set<int> _wishlistBusy = {};

  static const int _perPage = 10;

  String? _search;
  int? _destinationId;

  void setFilters({String? search, int? destinationId}) {
    final trimmed = search?.trim();
    _search = (trimmed == null || trimmed.isEmpty) ? null : trimmed;
    _destinationId = destinationId;
  }

  Future<void> loadInitial() async {
    emit(
      state.copyWith(
        status: MyTripsListStatus.loading,
        trips: [],
        meta: null,
        clearErrorMessage: true,
      ),
    );

    final result = await _fetchTrips(
      page: 1,
      perPage: _perPage,
      search: _search,
      destinationId: _destinationId,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: MyTripsListStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (page) {
        emit(
          state.copyWith(
            status: MyTripsListStatus.success,
            trips: page.trips,
            meta: page.meta,
            clearErrorMessage: true,
          ),
        );
      },
    );
  }

  Future<void> refresh() async {
    if (state.status == MyTripsListStatus.loading) {
      return;
    }
    emit(state.copyWith(clearErrorMessage: true));
    final result = await _fetchTrips(
      page: 1,
      perPage: _perPage,
      search: _search,
      destinationId: _destinationId,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: MyTripsListStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (page) {
        emit(
          state.copyWith(
            status: MyTripsListStatus.success,
            trips: page.trips,
            meta: page.meta,
            clearErrorMessage: true,
          ),
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore ||
        state.status == MyTripsListStatus.loadingMore ||
        state.status == MyTripsListStatus.loading ||
        state.meta == null) {
      return;
    }

    emit(state.copyWith(status: MyTripsListStatus.loadingMore));

    final result = await _fetchTrips(
      page: state.nextPage,
      perPage: _perPage,
      search: _search,
      destinationId: _destinationId,
    );

    result.fold(
      (_) {
        emit(state.copyWith(status: MyTripsListStatus.success));
      },
      (page) {
        emit(
          state.copyWith(
            status: MyTripsListStatus.success,
            trips: [...state.trips, ...page.trips],
            meta: page.meta,
          ),
        );
      },
    );
  }

  Future<void> toggleTripWishlist(int tripId) async {
    if (tripId <= 0 || _wishlistBusy.contains(tripId) || state.trips.isEmpty) {
      return;
    }

    WishlistTripItem? trip;
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
        trips: state.trips
            .map(
              (t) => t.id == tripId
                  ? t.copyWith(isWishlisted: !previous)
                  : t,
            )
            .toList(),
        clearWishlistError: true,
      ),
    );

    final result = await _toggleWishlist(tripId);
    _wishlistBusy.remove(tripId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            trips: state.trips
                .map(
                  (t) => t.id == tripId
                      ? t.copyWith(isWishlisted: previous)
                      : t,
                )
                .toList(),
            wishlistErrorMessage: failure.message,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            trips: state.trips
                .map(
                  (t) => t.id == tripId
                      ? t.copyWith(isWishlisted: success.isWishlisted)
                      : t,
                )
                .toList(),
          ),
        );
      },
    );
  }

  void applyWishlistStateFromDetails(int tripId, bool isWishlisted) {
    if (tripId <= 0 || state.trips.isEmpty) {
      return;
    }
    if (!state.trips.any((t) => t.id == tripId)) {
      return;
    }
    emit(
      state.copyWith(
        trips: state.trips
            .map(
              (t) =>
                  t.id == tripId ? t.copyWith(isWishlisted: isWishlisted) : t,
            )
            .toList(),
      ),
    );
  }

  void clearWishlistError() {
    emit(state.copyWith(clearWishlistError: true));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/features/my_trips/domain/entities/trips_catalog_filters.dart';
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
  bool _isFetching = false;

  static const int _perPage = 10;

  TripsCatalogFilters _filters = const TripsCatalogFilters();

  TripsCatalogFilters get activeFilters => _filters;

  void setFilters({
    String? search,
    String? type,
    String? country,
    String? departureCountry,
    String? departureCity,
    int? destinationId,
    List<int>? destinations,
    String? destinationCountry,
    int? categoryId,
    List<int>? categories,
    int? airlineId,
    List<int>? airlines,
    int? vendorId,
    int? agencyId,
    int? minVendorRating,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    String? duration,
    int? minDuration,
    int? maxDuration,
    String? groupSize,
    int? citiesCount,
    int? countriesCount,
    String? season,
    int? tripMonth,
    int? tripYear,
    String? visaType,
    int? includeFlight,
    int? hotelsOnly,
    int? fiveStarOnly,
    int? acceptsCoupons,
    int? freeCancellation,
    String? flag,
    String? sort,
  }) {
    final trimmedSearch = search?.trim();
    _filters = TripsCatalogFilters(
      search: (trimmedSearch == null || trimmedSearch.isEmpty)
          ? null
          : trimmedSearch,
      type: type,
      country: country,
      departureCountry: departureCountry,
      departureCity: departureCity,
      destinationId: destinationId,
      destinations: destinations,
      destinationCountry: destinationCountry,
      categoryId: categoryId,
      categories: categories,
      airlineId: airlineId,
      airlines: airlines,
      vendorId: vendorId,
      agencyId: agencyId,
      minVendorRating: minVendorRating,
      minPrice: minPrice,
      maxPrice: maxPrice,
      minRating: minRating,
      duration: duration,
      minDuration: minDuration,
      maxDuration: maxDuration,
      groupSize: groupSize,
      citiesCount: citiesCount,
      countriesCount: countriesCount,
      season: season,
      tripMonth: tripMonth,
      tripYear: tripYear,
      visaType: visaType,
      includeFlight: includeFlight,
      hotelsOnly: hotelsOnly,
      fiveStarOnly: fiveStarOnly,
      acceptsCoupons: acceptsCoupons,
      freeCancellation: freeCancellation,
      flag: flag,
      sort: sort,
    );
  }

  Future<void> applyFilters(TripsCatalogFilters filters) async {
    final oldKey = _filters.toRequestBody().toString();
    final newKey = filters.toRequestBody().toString();
    if (oldKey == newKey) {
      return;
    }
    _filters = filters;
    await loadInitial();
  }

  /// Updates only the search term (keeps all other active filters) and reloads.
  Future<void> applySearchQuery(String raw) async {
    await applyFilters(_filters.withSearch(raw));
  }

  Future<void> resetFilters() async {
    _filters = const TripsCatalogFilters();
    await loadInitial();
  }

  Future<void> loadInitial() async {
    if (_isFetching) {
      return;
    }
    _isFetching = true;
    try {
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
        filters: _filters,
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
    } finally {
      _isFetching = false;
    }
  }

  Future<void> refresh() async {
    if (state.status == MyTripsListStatus.loading || _isFetching) {
      return;
    }
    _isFetching = true;
    try {
      emit(state.copyWith(clearErrorMessage: true));
      final result = await _fetchTrips(
        page: 1,
        perPage: _perPage,
        filters: _filters,
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
    } finally {
      _isFetching = false;
    }
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
      filters: _filters,
    );

    result.fold(
      (_) {
        emit(state.copyWith(status: MyTripsListStatus.success));
      },
      (page) {
        final seenIds = state.trips.map((e) => e.id).toSet();
        final uniqueNew = page.trips.where((e) => !seenIds.contains(e.id)).toList();
        emit(
          state.copyWith(
            status: MyTripsListStatus.success,
            trips: [...state.trips, ...uniqueNew],
            meta: page.meta,
          ),
        );
      },
    );
  }

  Future<void> loadMoreFilteredTrips() => loadMore();

  Future<void> refreshFilteredTrips() => refresh();

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

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/features/wishlist/domain/repositories/trip_wishlist_repository.dart';
import '../../data/models/home_section_response.dart';
import '../../data/models/special_trips_response.dart';
import '../../domain/repositories/home_repository.dart';
import 'special_trips_state.dart';

List<TripModel> _patchTripsWishlisted(
  List<TripModel> trips,
  int tripId,
  bool isWishlisted,
) {
  return trips
      .map(
        (t) => t.id == tripId ? t.copyWith(isWishlisted: isWishlisted) : t,
      )
      .toList();
}

class SpecialTripsCubit extends Cubit<SpecialTripsState> {
  SpecialTripsCubit(this._homeRepository, this._wishlistRepository)
      : super(const SpecialTripsState());

  final HomeRepository _homeRepository;
  final TripWishlistRepository _wishlistRepository;
  final Set<int> _wishlistBusy = {};

  /// Load first page of special trips for given category
  Future<void> loadTrips(int categoryId) async {
    emit(
      state.copyWith(
        status: SpecialTripsStatus.loading,
        categoryId: categoryId,
      ),
    );

    final result = await _homeRepository.getSpecialTrips(
      categoryId: categoryId,
      page: 1,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: SpecialTripsStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (data) {
        final response = SpecialTripsResponse.fromJson(data);
        emit(
          state.copyWith(
            status: SpecialTripsStatus.success,
            trips: response.trips,
            meta: response.meta,
          ),
        );
      },
    );
  }

  /// Load next page (horizontal pagination)
  Future<void> loadMore() async {
    if (!state.hasMore ||
        state.status == SpecialTripsStatus.loadingMore ||
        state.categoryId == null) {
      return;
    }

    emit(state.copyWith(status: SpecialTripsStatus.loadingMore));

    final result = await _homeRepository.getSpecialTrips(
      categoryId: state.categoryId!,
      page: state.nextPage,
    );

    result.fold(
      (failure) {
        // Revert to success so user can retry
        emit(state.copyWith(status: SpecialTripsStatus.success));
      },
      (data) {
        final response = SpecialTripsResponse.fromJson(data);
        emit(
          state.copyWith(
            status: SpecialTripsStatus.success,
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

  /// Keeps special-trip hearts in sync when the same trip is favorited in home sections.
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

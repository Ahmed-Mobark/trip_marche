import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';
import '../../domain/usecases/fetch_wishlist_usecase.dart';
import '../../domain/usecases/toggle_wishlist_usecase.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit(this._fetchWishlist, this._toggleWishlist)
      : super(const WishlistState());

  final FetchWishlistUseCase _fetchWishlist;
  final ToggleWishlistUseCase _toggleWishlist;
  final Set<int> _wishlistBusy = {};

  static const int _perPage = 10;

  WishlistPaginationMeta? _metaAfterRemove(WishlistPaginationMeta? m) {
    if (m == null) {
      return null;
    }
    final total = (m.total - 1).clamp(0, 1 << 30);
    return WishlistPaginationMeta(
      currentPage: m.currentPage,
      lastPage: m.lastPage,
      perPage: m.perPage,
      total: total,
    );
  }

  /// Updates or removes a row when the user returns from trip details.
  void applyWishlistStateFromDetails(int tripId, bool isWishlisted) {
    if (tripId <= 0 || state.trips.isEmpty) {
      return;
    }
    if (!state.trips.any((t) => t.id == tripId)) {
      return;
    }
    if (!isWishlisted) {
      emit(
        state.copyWith(
          trips: state.trips.where((t) => t.id != tripId).toList(),
          meta: _metaAfterRemove(state.meta),
        ),
      );
    } else {
      emit(
        state.copyWith(
          trips: state.trips
              .map(
                (t) =>
                    t.id == tripId ? t.copyWith(isWishlisted: true) : t,
              )
              .toList(),
        ),
      );
    }
  }

  Future<void> loadInitial() async {
    emit(
      state.copyWith(
        status: WishlistPageStatus.loading,
        trips: [],
        meta: null,
        clearErrorMessage: true,
      ),
    );

    final result = await _fetchWishlist(
      currentPage: 1,
      perPage: _perPage,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: WishlistPageStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (page) {
        emit(
          state.copyWith(
            status: WishlistPageStatus.success,
            trips: page.trips,
            meta: page.meta,
            clearErrorMessage: true,
          ),
        );
      },
    );
  }

  Future<void> refresh() async {
    if (state.status == WishlistPageStatus.loading) {
      return;
    }
    emit(state.copyWith(clearErrorMessage: true));
    final result = await _fetchWishlist(
      currentPage: 1,
      perPage: _perPage,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: WishlistPageStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (page) {
        emit(
          state.copyWith(
            status: WishlistPageStatus.success,
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
        state.status == WishlistPageStatus.loadingMore ||
        state.status == WishlistPageStatus.loading ||
        state.meta == null) {
      return;
    }

    emit(state.copyWith(status: WishlistPageStatus.loadingMore));

    final result = await _fetchWishlist(
      currentPage: state.nextPage,
      perPage: _perPage,
    );

    result.fold(
      (_) {
        emit(state.copyWith(status: WishlistPageStatus.success));
      },
      (page) {
        emit(
          state.copyWith(
            status: WishlistPageStatus.success,
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
        if (!success.isWishlisted) {
          emit(
            state.copyWith(
              trips:
                  state.trips.where((t) => t.id != tripId).toList(),
              meta: _metaAfterRemove(state.meta),
            ),
          );
        } else {
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
        }
      },
    );
  }

  void clearWishlistError() {
    emit(state.copyWith(clearWishlistError: true));
  }
}

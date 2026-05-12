import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trip_marche/features/trip_details/domain/usecases/get_trip_details_usecase.dart';
import 'package:trip_marche/features/wishlist/domain/repositories/trip_wishlist_repository.dart';
import 'trip_details_state.dart';
import 'wishlist_feedback.dart';

class TripDetailsCubit extends Cubit<TripDetailsState> {
  TripDetailsCubit(
    this._wishlistRepository,
    this._getTripDetails, {
    required this.tripId,
    bool initialIsWishlisted = false,
  }) : super(
          TripDetailsState(
            isFavorite: initialIsWishlisted,
            loadStatus: TripDetailsLoadStatus.initial,
          ),
        );

  final TripWishlistRepository _wishlistRepository;
  final GetTripDetailsUseCase _getTripDetails;
  final int tripId;

  Future<void> loadTrip() async {
    if (tripId <= 0) {
      emit(
        state.copyWith(
          loadStatus: TripDetailsLoadStatus.failure,
          loadError: 'Invalid trip',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        loadStatus: TripDetailsLoadStatus.loading,
        clearLoadError: true,
        clearTrip: true,
      ),
    );

    final result = await _getTripDetails(tripId);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            loadStatus: TripDetailsLoadStatus.failure,
            loadError: failure.message,
            clearTrip: true,
          ),
        );
      },
      (trip) {
        emit(
          state.copyWith(
            loadStatus: TripDetailsLoadStatus.success,
            trip: trip,
            isFavorite: trip.isWishlisted,
            clearTrip: false,
            clearLoadError: true,
            expandedDayIndices: trip.days.isEmpty ? const <int>{} : const {0},
          ),
        );
      },
    );
  }

  /// Local-only toggle when [tripId] is not available (e.g. placeholder screens).
  void toggleFavorite() => emit(state.copyWith(isFavorite: !state.isFavorite));

  Future<void> toggleWishlist() async {
    if (state.wishlistToggling) {
      return;
    }
    if (tripId <= 0) {
      toggleFavorite();
      return;
    }

    final previous = state.isFavorite;
    final optimistic = !previous;
    emit(
      state.copyWith(
        isFavorite: optimistic,
        wishlistToggling: true,
        clearWishlistFeedback: true,
      ),
    );

    final result = await _wishlistRepository.toggleWishlist(tripId);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isFavorite: previous,
            wishlistToggling: false,
            wishlistFeedback: WishlistFeedback(
              message: failure.message,
              isError: true,
            ),
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            isFavorite: success.isWishlisted,
            wishlistToggling: false,
            clearWishlistFeedback: true,
          ),
        );
      },
    );
  }

  void clearWishlistFeedback() {
    emit(state.copyWith(clearWishlistFeedback: true));
  }

  void toggleExpandedDay(int index) {
    final next = Set<int>.from(state.expandedDayIndices);
    if (next.contains(index)) {
      next.remove(index);
    } else {
      next.add(index);
    }
    emit(state.copyWith(expandedDayIndices: next));
  }

  void toggleActivity(String id) {
    final next = Set<String>.from(state.addedActivityIds);
    if (next.contains(id)) {
      next.remove(id);
    } else {
      next.add(id);
    }
    emit(state.copyWith(addedActivityIds: next));
  }
}

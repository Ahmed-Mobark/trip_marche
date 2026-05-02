import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trip_marche/features/wishlist/domain/repositories/trip_wishlist_repository.dart';
import 'trip_details_state.dart';
import 'wishlist_feedback.dart';

class TripDetailsCubit extends Cubit<TripDetailsState> {
  TripDetailsCubit(
    this._wishlistRepository, {
    required this.tripId,
    bool initialIsWishlisted = false,
  }) : super(TripDetailsState(isFavorite: initialIsWishlisted));

  final TripWishlistRepository _wishlistRepository;
  final int tripId;

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
    emit(
      state.copyWith(
        expandedDayIndex: state.expandedDayIndex == index ? -1 : index,
      ),
    );
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

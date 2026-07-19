import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/features/my_trips/domain/entities/booking_entity.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_state.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_tab.dart';
import 'package:trip_marche/features/wishlist/domain/usecases/toggle_wishlist_usecase.dart';

class MyTripsShellCubit extends Cubit<MyTripsShellState> {
  MyTripsShellCubit(this._toggleWishlist) : super(const MyTripsShellState());

  final ToggleWishlistUseCase _toggleWishlist;
  final Set<int> _wishlistBusy = {};

  void selectTab(MyTripsShellTab tab) => emit(state.copyWith(tab: tab));

  void setSearchQuery(String query) =>
      emit(state.copyWith(searchQuery: query));

  bool isWishlisted(int tripId) => state.favoriteStatus[tripId] ?? false;

  Future<void> toggleWishlist(int tripId) async {
    debugPrint('[MyTripsShell] toggleWishlist called, tripId=$tripId');
    if (tripId <= 0 || _wishlistBusy.contains(tripId)) {
      debugPrint('[MyTripsShell] toggleWishlist early return, tripId=$tripId');
      return;
    }

    final previous = isWishlisted(tripId);
    debugPrint('[MyTripsShell] toggleWishlist tripId=$tripId, previous=$previous');
    _wishlistBusy.add(tripId);

    final updated = Map<int, bool>.from(state.favoriteStatus);
    updated[tripId] = !previous;

    emit(state.copyWith(
      favoriteStatus: updated,
      clearWishlistError: true,
    ));

    debugPrint(
      '[MyTripsShell] toggleWishlist optimistic update tripId=$tripId, newLocal=${!previous}',
    );

    final result = await _toggleWishlist(tripId);
    _wishlistBusy.remove(tripId);

    result.fold(
      (failure) {
        final reverted = Map<int, bool>.from(state.favoriteStatus);
        reverted[tripId] = previous;
        emit(state.copyWith(
          favoriteStatus: reverted,
          wishlistErrorMessage: failure.message,
        ));
        debugPrint(
          '[MyTripsShell] toggleWishlist API FAILED tripId=$tripId, reverted to=$previous, error=${failure.message}',
        );
      },
      (success) {
        final confirmed = Map<int, bool>.from(state.favoriteStatus);
        confirmed[tripId] = success.isWishlisted;
        emit(state.copyWith(
          favoriteStatus: confirmed,
          clearWishlistError: true,
        ));
        debugPrint(
          '[MyTripsShell] toggleWishlist API SUCCESS tripId=$tripId, confirmed=${success.isWishlisted}',
        );
      },
    );
    debugPrint(
      '[MyTripsShell] toggleWishlist final tripId=$tripId, finalValue=${isWishlisted(tripId)}',
    );
  }

  void applyWishlistStateFromDetails(int tripId, bool isWishlisted) {
    if (tripId <= 0) {
      return;
    }
    final updated = Map<int, bool>.from(state.favoriteStatus);
    updated[tripId] = isWishlisted;
    emit(state.copyWith(favoriteStatus: updated));
  }

  void syncFavoriteStatusFromBookings(List<Booking> bookings) {
    final updated = Map<int, bool>.from(state.favoriteStatus);
    for (final b in bookings) {
      final fav = b.trip.isFavorite;
      debugPrint('[MyTripsShell] sync tripId=${b.trip.id} isFavorite=$fav');
      updated[b.trip.id] = fav;
    }
    emit(state.copyWith(favoriteStatus: updated));
  }

  void clearWishlistError() {
    emit(state.copyWith(clearWishlistError: true));
  }
}

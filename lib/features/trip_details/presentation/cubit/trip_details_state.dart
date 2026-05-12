import 'package:equatable/equatable.dart';

import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'wishlist_feedback.dart';

enum TripDetailsLoadStatus { initial, loading, success, failure }

class TripDetailsState extends Equatable {
  const TripDetailsState({
    this.loadStatus = TripDetailsLoadStatus.initial,
    this.trip,
    this.loadError,
    this.isFavorite = false,
    this.wishlistToggling = false,
    this.wishlistFeedback,
    this.expandedDayIndices = const <int>{0},
    this.addedActivityIds = const <String>{},
  });

  final TripDetailsLoadStatus loadStatus;
  final TripDetails? trip;
  final String? loadError;
  final bool isFavorite;
  final bool wishlistToggling;
  final WishlistFeedback? wishlistFeedback;
  final Set<int> expandedDayIndices;
  final Set<String> addedActivityIds;

  TripDetailsState copyWith({
    TripDetailsLoadStatus? loadStatus,
    TripDetails? trip,
    String? loadError,
    bool clearTrip = false,
    bool? isFavorite,
    bool? wishlistToggling,
    WishlistFeedback? wishlistFeedback,
    bool clearWishlistFeedback = false,
    Set<int>? expandedDayIndices,
    Set<String>? addedActivityIds,
    bool clearLoadError = false,
  }) {
    return TripDetailsState(
      loadStatus: loadStatus ?? this.loadStatus,
      trip: clearTrip ? null : (trip ?? this.trip),
      loadError: clearLoadError ? null : (loadError ?? this.loadError),
      isFavorite: isFavorite ?? this.isFavorite,
      wishlistToggling: wishlistToggling ?? this.wishlistToggling,
      wishlistFeedback: clearWishlistFeedback
          ? null
          : (wishlistFeedback ?? this.wishlistFeedback),
      expandedDayIndices: expandedDayIndices ?? this.expandedDayIndices,
      addedActivityIds: addedActivityIds ?? this.addedActivityIds,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        trip,
        loadError,
        isFavorite,
        wishlistToggling,
        wishlistFeedback,
        expandedDayIndices,
        addedActivityIds,
      ];
}

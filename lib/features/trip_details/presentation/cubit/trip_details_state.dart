import 'package:equatable/equatable.dart';

import 'wishlist_feedback.dart';

class TripDetailsState extends Equatable {
  const TripDetailsState({
    this.isFavorite = false,
    this.wishlistToggling = false,
    this.wishlistFeedback,
    this.expandedDayIndex = -1,
    this.addedActivityIds = const <String>{},
  });

  final bool isFavorite;
  final bool wishlistToggling;
  final WishlistFeedback? wishlistFeedback;
  final int expandedDayIndex;
  final Set<String> addedActivityIds;

  TripDetailsState copyWith({
    bool? isFavorite,
    bool? wishlistToggling,
    WishlistFeedback? wishlistFeedback,
    bool clearWishlistFeedback = false,
    int? expandedDayIndex,
    Set<String>? addedActivityIds,
  }) {
    return TripDetailsState(
      isFavorite: isFavorite ?? this.isFavorite,
      wishlistToggling: wishlistToggling ?? this.wishlistToggling,
      wishlistFeedback: clearWishlistFeedback
          ? null
          : (wishlistFeedback ?? this.wishlistFeedback),
      expandedDayIndex: expandedDayIndex ?? this.expandedDayIndex,
      addedActivityIds: addedActivityIds ?? this.addedActivityIds,
    );
  }

  @override
  List<Object?> get props => [
        isFavorite,
        wishlistToggling,
        wishlistFeedback,
        expandedDayIndex,
        addedActivityIds,
      ];
}

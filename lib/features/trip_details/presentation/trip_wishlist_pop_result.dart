/// Returned when [TripDetailsView] is popped so parent screens can sync hearts.
class TripWishlistPopResult {
  const TripWishlistPopResult({
    required this.tripId,
    required this.isWishlisted,
  });

  final int tripId;
  final bool isWishlisted;
}

import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';

/// Implemented in `features/wishlist/data/repositories/wishlist_repository_impl.dart`.
abstract class TripWishlistRepository {
  Future<Either<Failure, WishlistTripsPage>> fetchWishlist({
    required int currentPage,
    int perPage = 10,
  });

  Future<Either<Failure, WishlistToggleResult>> toggleWishlist(int tripId);
}

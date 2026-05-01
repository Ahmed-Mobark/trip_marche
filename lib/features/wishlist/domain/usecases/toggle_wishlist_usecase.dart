import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';
import 'package:trip_marche/features/wishlist/domain/repositories/trip_wishlist_repository.dart';

class ToggleWishlistUseCase {
  const ToggleWishlistUseCase(this._repository);

  final TripWishlistRepository _repository;

  Future<Either<Failure, WishlistToggleResult>> call(int tripId) {
    return _repository.toggleWishlist(tripId);
  }
}

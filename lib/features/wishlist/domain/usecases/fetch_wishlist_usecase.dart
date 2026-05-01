import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';
import 'package:trip_marche/features/wishlist/domain/repositories/trip_wishlist_repository.dart';

class FetchWishlistUseCase {
  const FetchWishlistUseCase(this._repository);

  final TripWishlistRepository _repository;

  Future<Either<Failure, WishlistTripsPage>> call({
    required int currentPage,
    int perPage = 10,
  }) {
    return _repository.fetchWishlist(
      currentPage: currentPage,
      perPage: perPage,
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/core/network/network_service/repository_helper.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';
import 'package:trip_marche/features/wishlist/domain/repositories/trip_wishlist_repository.dart';
import '../datasources/wishlist_remote_data_source.dart';

class TripWishlistRepositoryImpl
    with RepositoryHelper
    implements TripWishlistRepository {
  TripWishlistRepositoryImpl(this._remote);

  final WishlistRemoteDataSource _remote;

  @override
  Future<Either<Failure, WishlistTripsPage>> fetchWishlist({
    required int currentPage,
    int perPage = 10,
  }) {
    return handleEither(() async {
      final model = await _remote.fetchWishlist(
        currentPage: currentPage,
        perPage: perPage,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, WishlistToggleResult>> toggleWishlist(int tripId) {
    return handleEither(() async {
      final model = await _remote.toggleWishlist(tripId);
      return model.toEntity();
    });
  }
}

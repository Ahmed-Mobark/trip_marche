import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/core/network/network_service/repository_helper.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';
import '../datasources/trips_catalog_remote_data_source.dart';
import '../../domain/repositories/trips_catalog_repository.dart';

class TripsCatalogRepositoryImpl
    with RepositoryHelper
    implements TripsCatalogRepository {
  TripsCatalogRepositoryImpl(this._remote);

  final TripsCatalogRemoteDataSource _remote;

  @override
  Future<Either<Failure, WishlistTripsPage>> fetchTrips({
    required int page,
    int perPage = 10,
    String? search,
    int? destinationId,
  }) {
    return handleEither(() async {
      final model = await _remote.fetchTrips(
        page: page,
        perPage: perPage,
        search: search,
        destinationId: destinationId,
      );
      return model.toEntity();
    });
  }
}

import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/my_trips/domain/entities/trips_catalog_filters.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';
import '../repositories/trips_catalog_repository.dart';

class FetchTripsCatalogUseCase {
  const FetchTripsCatalogUseCase(this._repository);

  final TripsCatalogRepository _repository;

  Future<Either<Failure, WishlistTripsPage>> call({
    required int page,
    int perPage = 10,
    TripsCatalogFilters? filters,
  }) {
    return _repository.fetchTrips(
      page: page,
      perPage: perPage,
      filters: filters,
    );
  }
}

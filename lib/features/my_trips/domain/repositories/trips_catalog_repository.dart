import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/my_trips/domain/entities/trips_catalog_filters.dart';
import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';

/// Paginated trips list (POST [/trips]).
abstract class TripsCatalogRepository {
  Future<Either<Failure, WishlistTripsPage>> fetchTrips({
    required int page,
    int perPage = 10,
    TripsCatalogFilters? filters,
  });
}

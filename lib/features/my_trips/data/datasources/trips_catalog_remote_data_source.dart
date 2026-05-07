import 'package:trip_marche/core/config/app_end_points.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/my_trips/domain/entities/trips_catalog_filters.dart';
import 'package:trip_marche/features/wishlist/data/models/wishlist_page_model.dart';

abstract class TripsCatalogRemoteDataSource {
  Future<WishlistTripsPageModel> fetchTrips({
    required int page,
    int perPage = 10,
    TripsCatalogFilters? filters,
  });
}

class TripsCatalogRemoteDataSourceImpl implements TripsCatalogRemoteDataSource {
  TripsCatalogRemoteDataSourceImpl(this._api);

  final ApiBaseHelper _api;

  @override
  Future<WishlistTripsPageModel> fetchTrips({
    required int page,
    int perPage = 10,
    TripsCatalogFilters? filters,
  }) async {
    final body = <String, dynamic>{
      ...?filters?.toRequestBody(),
      'page': page,
      'per_page': perPage,
    };

    final response = await _api.post<Map<String, dynamic>>(
      url: AppEndpoints.trips,
      body: body,
    );
    return WishlistTripsPageModel.fromJson(response);
  }
}

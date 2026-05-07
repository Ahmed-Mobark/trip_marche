import 'package:trip_marche/core/config/app_end_points.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/wishlist/data/models/wishlist_page_model.dart';

abstract class TripsCatalogRemoteDataSource {
  Future<WishlistTripsPageModel> fetchTrips({
    required int page,
    int perPage = 10,
    String? search,
    int? destinationId,
  });
}

class TripsCatalogRemoteDataSourceImpl implements TripsCatalogRemoteDataSource {
  TripsCatalogRemoteDataSourceImpl(this._api);

  final ApiBaseHelper _api;

  @override
  Future<WishlistTripsPageModel> fetchTrips({
    required int page,
    int perPage = 10,
    String? search,
    int? destinationId,
  }) async {
    final body = <String, dynamic>{
      'page': page,
      'per_page': perPage,
    };
    if (search != null && search.trim().isNotEmpty) {
      body['search'] = search.trim();
    }
    if (destinationId != null) {
      body['destination_id'] = destinationId;
    }

    final response = await _api.post<Map<String, dynamic>>(
      url: AppEndpoints.trips,
      body: body,
    );
    return WishlistTripsPageModel.fromJson(response);
  }
}

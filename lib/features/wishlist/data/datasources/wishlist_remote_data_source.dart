import 'package:trip_marche/core/config/app_end_points.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import '../models/wishlist_page_model.dart';
import '../models/wishlist_toggle_response.dart';

abstract class WishlistRemoteDataSource {
  Future<WishlistTripsPageModel> fetchWishlist({
    required int currentPage,
    int perPage = 10,
  });

  Future<WishlistToggleResponse> toggleWishlist(int tripId);
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  WishlistRemoteDataSourceImpl(this._api);

  final ApiBaseHelper _api;

  @override
  Future<WishlistTripsPageModel> fetchWishlist({
    required int currentPage,
    int perPage = 10,
  }) async {
    final response = await _api.get<Map<String, dynamic>>(
      url: AppEndpoints.wishlist,
      queryParameters: {
        'current_page': currentPage,
        'per_page': perPage,
      },
    );
    return WishlistTripsPageModel.fromJson(response);
  }

  @override
  Future<WishlistToggleResponse> toggleWishlist(int tripId) async {
    final response = await _api.post<Map<String, dynamic>>(
      url: AppEndpoints.wishlistToggle(tripId),
    );
    return WishlistToggleResponse.fromJson(response);
  }
}

import '../../../../core/config/app_end_points.dart';
import '../../../../core/network/network_service/api_basehelper.dart';

abstract class HomeRemoteDataSource {
  Future<Map<String, dynamic>> getHomeSections();
  Future<Map<String, dynamic>> getHomeBanners();
  Future<Map<String, dynamic>> getHomeCategories();
  Future<Map<String, dynamic>> getSpecialTrips({
    required int categoryId,
    int page = 1,
    int perPage = 5,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiBaseHelper _apiHelper;

  HomeRemoteDataSourceImpl(this._apiHelper);

  @override
  Future<Map<String, dynamic>> getHomeSections() async {
    final response = await _apiHelper.get<Map<String, dynamic>>(
      url: AppEndpoints.homeSections,
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> getHomeBanners() async {
    final response = await _apiHelper.get<Map<String, dynamic>>(
      url: AppEndpoints.homeBanners,
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> getHomeCategories() async {
    final response = await _apiHelper.get<Map<String, dynamic>>(
      url: AppEndpoints.homeCategories,
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> getSpecialTrips({
    required int categoryId,
    int page = 1,
    int perPage = 5,
  }) async {
    final response = await _apiHelper.get<Map<String, dynamic>>(
      url: AppEndpoints.homeSpecialTrips,
      queryParameters: {
        'category_id': categoryId,
        'page': page,
        'per_page': perPage,
      },
    );
    return response;
  }
}

import 'package:trip_marche/core/config/app_end_points.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/my_trips/data/models/booking_model.dart';

abstract class BookingsRemoteDataSource {
  Future<BookingsPageModel> fetchBookings({
    required int page,
    int perPage = 15,
  });
}

class BookingsRemoteDataSourceImpl implements BookingsRemoteDataSource {
  BookingsRemoteDataSourceImpl(this._api);

  final ApiBaseHelper _api;

  @override
  Future<BookingsPageModel> fetchBookings({
    required int page,
    int perPage = 15,
  }) async {
    final response = await _api.get<Map<String, dynamic>>(
      url: AppEndpoints.bookings,
      queryParameters: {
        'page': page,
        'per_page': perPage,
      },
    );
    return BookingsPageModel.fromJson(response);
  }
}

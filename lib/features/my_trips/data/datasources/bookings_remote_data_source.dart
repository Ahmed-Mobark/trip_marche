import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:trip_marche/core/config/app_end_points.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/my_trips/data/models/booking_model.dart';

abstract class BookingsRemoteDataSource {
  Future<BookingsPageModel> fetchBookings({
    required int page,
    required String status,
    String search = '',
    int perPage = 10,
  });

  Future<Uint8List> fetchBookingPdf(int bookingId);
}

class BookingsRemoteDataSourceImpl implements BookingsRemoteDataSource {
  BookingsRemoteDataSourceImpl(this._api);

  final ApiBaseHelper _api;

  @override
  Future<BookingsPageModel> fetchBookings({
    required int page,
    required String status,
    String search = '',
    int perPage = 10,
  }) async {
    final response = await _api.get<Map<String, dynamic>>(
      url: AppEndpoints.bookings,
      queryParameters: {
        'page': page,
        'status': status,
        'search': search,
        'per_page': perPage,
      },
    );
    return BookingsPageModel.fromJson(response);
  }

  @override
  Future<Uint8List> fetchBookingPdf(int bookingId) async {
    final response = await _api.get<Uint8List>(
      url: AppEndpoints.bookingsPdf(bookingId),
      options: Options(responseType: ResponseType.bytes),
    );
    return response;
  }
}

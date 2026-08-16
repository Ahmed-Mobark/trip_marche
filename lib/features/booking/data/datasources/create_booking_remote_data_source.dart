import 'package:trip_marche/core/config/app_end_points.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/booking/data/models/create_booking_request.dart';

abstract class CreateBookingRemoteDataSource {
  Future<CreateBookingResponse> createBooking(
    int tripId,
    CreateBookingRequest request,
  );
}

class CreateBookingRemoteDataSourceImpl implements CreateBookingRemoteDataSource {
  CreateBookingRemoteDataSourceImpl(this._api);

  final ApiBaseHelper _api;

  @override
  Future<CreateBookingResponse> createBooking(
    int tripId,
    CreateBookingRequest request,
  ) async {
    final response = await _api.post<Map<String, dynamic>>(
      url: AppEndpoints.createBooking(tripId),
      body: request.toJson(),
    );
    return CreateBookingResponse.fromApiResponse(response);
  }
}

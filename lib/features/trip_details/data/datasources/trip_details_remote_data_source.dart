import 'package:trip_marche/core/config/app_end_points.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/trip_details/data/models/trip_details_model.dart';

abstract class TripDetailsRemoteDataSource {
  Future<TripDetailsModel> fetchTripDetails(int tripId);
}

class TripDetailsRemoteDataSourceImpl implements TripDetailsRemoteDataSource {
  TripDetailsRemoteDataSourceImpl(this._api);

  final ApiBaseHelper _api;

  @override
  Future<TripDetailsModel> fetchTripDetails(int tripId) async {
    final response = await _api.post<Map<String, dynamic>>(
      url: AppEndpoints.tripById(tripId),
      body: const <String, dynamic>{},
    );
    return TripDetailsModel.fromApiResponse(response);
  }
}

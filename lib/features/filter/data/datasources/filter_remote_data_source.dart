import 'package:trip_marche/core/config/app_end_points.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/filter/data/models/filter_destination_model.dart';
import 'package:trip_marche/features/filter/data/models/filter_metadata_model.dart';

abstract class FilterRemoteDataSource {
  Future<List<FilterDestinationModel>> getDestinations();
  Future<FilterMetadataModel> getFilterMetadata({Map<String, dynamic>? filters});
}

class FilterRemoteDataSourceImpl implements FilterRemoteDataSource {
  const FilterRemoteDataSourceImpl(this._api);

  final ApiBaseHelper _api;

  @override
  Future<List<FilterDestinationModel>> getDestinations() async {
    final response = await _api.get<Map<String, dynamic>>(
      url: AppEndpoints.destinations,
    );
    final data = response['data'];
    if (data is! List) {
      return const [];
    }
    return data
        .whereType<Map<String, dynamic>>()
        .map(FilterDestinationModel.fromJson)
        .toList();
  }

  @override
  Future<FilterMetadataModel> getFilterMetadata({
    Map<String, dynamic>? filters,
  }) async {
    final response = await _api.get<Map<String, dynamic>>(
      url: AppEndpoints.tripsFilters,
      body: filters,
    );
    return FilterMetadataModel.fromResponse(response);
  }
}

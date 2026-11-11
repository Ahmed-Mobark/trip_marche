import 'package:trip_marche/core/config/app_end_points.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';

import '../models/help_page_model.dart';

abstract class HelpCenterRemoteDataSource {
  Future<List<HelpPageModel>> pages();
  Future<HelpPageModel> page(String slug);
}

class HelpCenterRemoteDataSourceImpl implements HelpCenterRemoteDataSource {
  HelpCenterRemoteDataSourceImpl(this._api);

  final ApiBaseHelper _api;

  @override
  Future<List<HelpPageModel>> pages() async {
    final response = await _api.get<Map<String, dynamic>>(
      url: AppEndpoints.helpPages,
    );
    final rows = response['data'];
    if (rows is! List) return [];
    return rows
        .whereType<Map<String, dynamic>>()
        .map(HelpPageModel.fromJson)
        .toList();
  }

  @override
  Future<HelpPageModel> page(String slug) async {
    final response = await _api.get<Map<String, dynamic>>(
      url: AppEndpoints.helpPage(slug),
    );
    return HelpPageModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}

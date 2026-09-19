import '../../../../core/config/app_end_points.dart';
import '../../../../core/network/network_service/api_basehelper.dart';
import '../models/currency_model.dart';

abstract class CurrencyRemoteDataSource {
  Future<List<CurrencyModel>> getCurrencies();
}

class CurrencyRemoteDataSourceImpl implements CurrencyRemoteDataSource {
  const CurrencyRemoteDataSourceImpl(this._api);

  final ApiBaseHelper _api;

  @override
  Future<List<CurrencyModel>> getCurrencies() async {
    final response = await _api.get<dynamic>(url: AppEndpoints.currencies);
    final rawData = response is List
        ? response
        : response is Map<String, dynamic> && response['data'] is List
        ? response['data'] as List
        : const <dynamic>[];

    return rawData
        .whereType<Map<String, dynamic>>()
        .map(CurrencyModel.fromJson)
        .where((currency) => currency.code.isNotEmpty)
        .toList();
  }
}

import 'package:trip_marche/core/config/app_end_points.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/payment_method/data/models/payment_method_model.dart';

abstract class PaymentMethodRemoteDataSource {
  Future<PaymentMethodsResponse> getPaymentMethods();
}

class PaymentMethodRemoteDataSourceImpl
    implements PaymentMethodRemoteDataSource {
  PaymentMethodRemoteDataSourceImpl(this._api);
  final ApiBaseHelper _api;

  @override
  Future<PaymentMethodsResponse> getPaymentMethods() async {
    final response = await _api.get<Map<String, dynamic>>(
      url: AppEndpoints.paymentMethods,
    );
    return PaymentMethodsResponse.fromJson(response);
  }
}

import 'package:trip_marche/core/config/app_end_points.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/booking/data/models/coupon_validation_model.dart';
import 'package:trip_marche/features/booking/data/models/validate_coupon_request.dart';

abstract class CouponRemoteDataSource {
  Future<CouponValidationModel> validateCoupon(ValidateCouponRequest request);
}

class CouponRemoteDataSourceImpl implements CouponRemoteDataSource {
  CouponRemoteDataSourceImpl(this._api);

  final ApiBaseHelper _api;

  @override
  Future<CouponValidationModel> validateCoupon(
    ValidateCouponRequest request,
  ) async {
    final response = await _api.post<Map<String, dynamic>>(
      url: AppEndpoints.couponsValidate,
      body: request.toJson(),
    );
    return CouponValidationModel.fromApiResponse(response);
  }
}

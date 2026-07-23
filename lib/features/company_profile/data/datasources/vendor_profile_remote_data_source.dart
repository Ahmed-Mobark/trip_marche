import 'package:trip_marche/core/config/app_end_points.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import '../models/vendor_profile_model.dart';

abstract class VendorProfileRemoteDataSource {
  Future<VendorProfileModel> getVendorProfile(int vendorId);
}

class VendorProfileRemoteDataSourceImpl
    implements VendorProfileRemoteDataSource {
  VendorProfileRemoteDataSourceImpl(this._api);

  final ApiBaseHelper _api;

  @override
  Future<VendorProfileModel> getVendorProfile(int vendorId) async {
    final response = await _api.get<Map<String, dynamic>>(
      url: AppEndpoints.vendorProfile(vendorId),
    );
    return VendorProfileModel.fromJson(response);
  }
}

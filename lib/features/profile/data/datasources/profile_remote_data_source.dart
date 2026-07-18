import '../../../../core/config/app_end_points.dart';
import '../../../../core/network/network_service/api_basehelper.dart';
import '../models/change_password_request.dart';
import '../models/profile_update_request.dart';

abstract class ProfileRemoteDataSource {
  Future<Map<String, dynamic>> getProfile();
  Future<Map<String, dynamic>> updateProfile(ProfileUpdateRequest request);
  Future<Map<String, dynamic>> changePassword(ChangePasswordRequest request);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiBaseHelper _apiHelper;

  ProfileRemoteDataSourceImpl(this._apiHelper);

  @override
  Future<Map<String, dynamic>> getProfile() async {
    final response = await _apiHelper.get<Map<String, dynamic>>(
      url: AppEndpoints.profile,
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> updateProfile(
    ProfileUpdateRequest request,
  ) async {
    final response = await _apiHelper.post<Map<String, dynamic>>(
      url: AppEndpoints.profile,
      body: request.toJson(),
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> changePassword(
    ChangePasswordRequest request,
  ) async {
    final response = await _apiHelper.post<Map<String, dynamic>>(
      url: AppEndpoints.profilePassword,
      body: request.toJson(),
    );
    return response;
  }
}

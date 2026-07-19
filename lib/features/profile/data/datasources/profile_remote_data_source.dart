import '../../../../core/config/app_end_points.dart';
import '../../../../core/network/network_service/api_basehelper.dart';
import '../models/change_password_request.dart';
import '../models/profile_update_request.dart';

abstract class ProfileRemoteDataSource {
  Future<Map<String, dynamic>> getProfile();
  Future<Map<String, dynamic>> updateProfile(ProfileUpdateRequest request);
  Future<Map<String, dynamic>> changePassword(ChangePasswordRequest request);
  Future<Map<String, dynamic>> deleteAccount();
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
    final formData = await request.toFormData();
    final response = await _apiHelper.post<Map<String, dynamic>>(
      url: AppEndpoints.profile,
      formData: formData,
      body: formData == null ? request.toJson() : null,
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

  @override
  Future<Map<String, dynamic>> deleteAccount() async {
    final response = await _apiHelper.delete<Map<String, dynamic>>(
      url: AppEndpoints.profileDelete,
    );
    return response;
  }
}

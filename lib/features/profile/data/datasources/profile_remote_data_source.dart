import '../../../../core/config/app_end_points.dart';
import '../../../../core/network/network_service/api_basehelper.dart';
import '../models/change_password_request.dart';
import '../models/follow_vendor_response.dart';
import '../models/profile_update_request.dart';
import '../models/submit_review_request.dart';

abstract class ProfileRemoteDataSource {
  Future<Map<String, dynamic>> getProfile();
  Future<Map<String, dynamic>> updateProfile(ProfileUpdateRequest request);
  Future<Map<String, dynamic>> changePassword(ChangePasswordRequest request);
  Future<Map<String, dynamic>> deleteAccount();
  Future<Map<String, dynamic>> getFollowings();
  Future<Map<String, dynamic>> getReviews();
  Future<Map<String, dynamic>> submitReviews(SubmitReviewRequest request);
  Future<FollowVendorResponse> toggleFollowVendor(int vendorId);
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

  @override
  Future<Map<String, dynamic>> getFollowings() async {
    final response = await _apiHelper.get<Map<String, dynamic>>(
      url: AppEndpoints.profileFollowing,
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> getReviews() async {
    final response = await _apiHelper.get<Map<String, dynamic>>(
      url: AppEndpoints.profileReviews,
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> submitReviews(
    SubmitReviewRequest request,
  ) async {
    final response = await _apiHelper.post<Map<String, dynamic>>(
      url: AppEndpoints.reviews,
      body: request.toJson(),
    );
    return response;
  }

  @override
  Future<FollowVendorResponse> toggleFollowVendor(int vendorId) async {
    final response = await _apiHelper.post<Map<String, dynamic>>(
      url: AppEndpoints.vendorFollow(vendorId),
    );
    return FollowVendorResponse.fromJson(response);
  }
}

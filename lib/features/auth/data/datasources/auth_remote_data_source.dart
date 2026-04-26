import '../../../../core/config/app_end_points.dart';
import '../../../../core/network/network_service/api_basehelper.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';
import '../models/reset_password_request.dart';
import '../models/verify_email_request.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> register(RegisterRequest request);
  Future<Map<String, dynamic>> login(LoginRequest request);
  Future<Map<String, dynamic>> verifyEmail(VerifyEmailRequest request);
  Future<Map<String, dynamic>> sendOtp({required String email, required String type});
  Future<Map<String, dynamic>> verifyOtp({required String email, required String code});
  Future<Map<String, dynamic>> resetPassword(ResetPasswordRequest request);
  Future<Map<String, dynamic>> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiBaseHelper _apiHelper;

  AuthRemoteDataSourceImpl(this._apiHelper);

  @override
  Future<Map<String, dynamic>> register(RegisterRequest request) async {
    final response = await _apiHelper.post<Map<String, dynamic>>(
      url: AppEndpoints.authRegister,
      body: request.toJson(),
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> login(LoginRequest request) async {
    final response = await _apiHelper.post<Map<String, dynamic>>(
      url: AppEndpoints.authLogin,
      body: request.toJson(),
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> verifyEmail(VerifyEmailRequest request) async {
    final response = await _apiHelper.post<Map<String, dynamic>>(
      url: AppEndpoints.authVerifyEmail,
      body: request.toJson(),
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> sendOtp({required String email, required String type}) async {
    final response = await _apiHelper.post<Map<String, dynamic>>(
      url: AppEndpoints.authSendOtp,
      body: {'email': email, 'type': type},
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> verifyOtp({required String email, required String code}) async {
    final response = await _apiHelper.post<Map<String, dynamic>>(
      url: AppEndpoints.authVerifyOtp,
      body: {'email': email, 'code': code},
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> resetPassword(ResetPasswordRequest request) async {
    final response = await _apiHelper.post<Map<String, dynamic>>(
      url: AppEndpoints.authResetPassword,
      body: request.toJson(),
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> logout() async {
    final response = await _apiHelper.post<Map<String, dynamic>>(
      url: AppEndpoints.authLogout,
      body: {},
    );
    return response;
  }
}

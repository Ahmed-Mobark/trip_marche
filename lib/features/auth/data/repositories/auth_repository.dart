import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/core/network/network_service/repository_helper.dart';
import 'package:trip_marche/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:trip_marche/features/auth/data/models/login_request.dart';
import 'package:trip_marche/features/auth/data/models/register_request.dart';
import 'package:trip_marche/features/auth/data/models/reset_password_request.dart';
import 'package:trip_marche/features/auth/data/models/verify_email_request.dart';

class AuthRepository with RepositoryHelper {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepository(this._remoteDataSource);

  Future<Either<Failure, Map<String, dynamic>>> register(
      RegisterRequest request) {
    return handleEither(() => _remoteDataSource.register(request));
  }

  Future<Either<Failure, Map<String, dynamic>>> login(
      LoginRequest request) {
    return handleEither(() => _remoteDataSource.login(request));
  }

  Future<Either<Failure, Map<String, dynamic>>> verifyEmail(
      VerifyEmailRequest request) {
    return handleEither(() => _remoteDataSource.verifyEmail(request));
  }

  Future<Either<Failure, Map<String, dynamic>>> sendOtp({
    required String email,
    required String type,
  }) {
    return handleEither(() => _remoteDataSource.sendOtp(email: email, type: type));
  }

  Future<Either<Failure, Map<String, dynamic>>> verifyOtp({
    required String email,
    required String code,
  }) {
    return handleEither(() => _remoteDataSource.verifyOtp(email: email, code: code));
  }

  Future<Either<Failure, Map<String, dynamic>>> resetPassword(
      ResetPasswordRequest request) {
    return handleEither(() => _remoteDataSource.resetPassword(request));
  }

  Future<Either<Failure, Map<String, dynamic>>> logout() {
    return handleEither(() => _remoteDataSource.logout());
  }
}

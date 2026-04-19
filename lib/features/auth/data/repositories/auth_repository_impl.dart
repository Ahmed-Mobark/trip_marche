import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/core/network/network_service/repository_helper.dart';
import 'package:trip_marche/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:trip_marche/features/auth/data/models/login_request.dart';
import 'package:trip_marche/features/auth/data/models/register_request.dart';
import 'package:trip_marche/features/auth/data/models/reset_password_request.dart';
import 'package:trip_marche/features/auth/data/models/verify_email_request.dart';
import 'package:trip_marche/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl with RepositoryHelper implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, Map<String, dynamic>>> register(
    RegisterRequest request,
  ) {
    return handleEither(() => _remoteDataSource.register(request));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> login(LoginRequest request) {
    return handleEither(() => _remoteDataSource.login(request));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> verifyEmail(
    VerifyEmailRequest request,
  ) {
    return handleEither(() => _remoteDataSource.verifyEmail(request));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> sendOtp({
    required String email,
    required String type,
  }) {
    return handleEither(
      () => _remoteDataSource.sendOtp(email: email, type: type),
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> verifyOtp({
    required String email,
    required String code,
  }) {
    return handleEither(
      () => _remoteDataSource.verifyOtp(email: email, code: code),
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> resetPassword(
    ResetPasswordRequest request,
  ) {
    return handleEither(() => _remoteDataSource.resetPassword(request));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> logout() {
    return handleEither(() => _remoteDataSource.logout());
  }
}

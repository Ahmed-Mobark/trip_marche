import 'package:dartz/dartz.dart';
import '../../../../core/network/network_service/failures.dart';
import '../../data/models/login_request.dart';
import '../../data/models/register_request.dart';
import '../../data/models/reset_password_request.dart';
import '../../data/models/verify_email_request.dart';

/// Auth repository contract (domain). Implemented in [AuthRepositoryImpl].
abstract class AuthRepository {
  Future<Either<Failure, Map<String, dynamic>>> register(RegisterRequest request);

  Future<Either<Failure, Map<String, dynamic>>> login(LoginRequest request);

  Future<Either<Failure, Map<String, dynamic>>> verifyEmail(
    VerifyEmailRequest request,
  );

  Future<Either<Failure, Map<String, dynamic>>> sendOtp({
    required String email,
    required String type,
  });

  Future<Either<Failure, Map<String, dynamic>>> verifyOtp({
    required String email,
    required String code,
  });

  Future<Either<Failure, Map<String, dynamic>>> resetPassword(
    ResetPasswordRequest request,
  );

  Future<Either<Failure, Map<String, dynamic>>> logout();
}

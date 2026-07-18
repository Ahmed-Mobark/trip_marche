import 'package:dartz/dartz.dart';
import '../../../../core/network/network_service/failures.dart';
import '../../data/models/change_password_request.dart';
import '../../data/models/profile_update_request.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Map<String, dynamic>>> getProfile();
  Future<Either<Failure, Map<String, dynamic>>> updateProfile(
    ProfileUpdateRequest request,
  );
  Future<Either<Failure, Map<String, dynamic>>> changePassword(
    ChangePasswordRequest request,
  );
}

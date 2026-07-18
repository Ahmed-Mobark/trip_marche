import 'package:dartz/dartz.dart';
import '../../../../core/network/network_service/failures.dart';
import '../../../../core/network/network_service/repository_helper.dart';
import '../datasources/profile_remote_data_source.dart';
import '../../domain/repositories/profile_repository.dart';
import '../models/change_password_request.dart';
import '../models/profile_update_request.dart';

class ProfileRepositoryImpl with RepositoryHelper implements ProfileRepository {
  ProfileRepositoryImpl(this._remoteDataSource);

  final ProfileRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProfile() {
    return handleEither(() => _remoteDataSource.getProfile());
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateProfile(
    ProfileUpdateRequest request,
  ) {
    return handleEither(() => _remoteDataSource.updateProfile(request));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> changePassword(
    ChangePasswordRequest request,
  ) {
    return handleEither(() => _remoteDataSource.changePassword(request));
  }
}

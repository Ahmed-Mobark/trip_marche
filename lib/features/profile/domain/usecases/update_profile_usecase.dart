import 'package:dartz/dartz.dart';
import '../../../../core/network/network_service/failures.dart';
import '../../data/models/profile_update_request.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<Either<Failure, Map<String, dynamic>>> call(
    ProfileUpdateRequest request,
  ) async {
    return _repository.updateProfile(request);
  }
}

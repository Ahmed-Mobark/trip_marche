import 'package:dartz/dartz.dart';
import '../../../../core/network/network_service/failures.dart';
import '../../data/models/change_password_request.dart';
import '../repositories/profile_repository.dart';

class ChangePasswordUseCase {
  final ProfileRepository _repository;

  ChangePasswordUseCase(this._repository);

  Future<Either<Failure, Map<String, dynamic>>> call(
    ChangePasswordRequest request,
  ) async {
    return _repository.changePassword(request);
  }
}

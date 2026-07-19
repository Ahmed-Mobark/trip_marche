import 'package:dartz/dartz.dart';
import '../../../../core/network/network_service/failures.dart';
import '../repositories/profile_repository.dart';

class DeleteAccountUseCase {
  final ProfileRepository _repository;

  DeleteAccountUseCase(this._repository);

  Future<Either<Failure, Map<String, dynamic>>> call() async {
    return _repository.deleteAccount();
  }
}

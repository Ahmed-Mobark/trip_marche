import 'package:dartz/dartz.dart';
import '../../../../core/network/network_service/failures.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<Either<Failure, Map<String, dynamic>>> call() async {
    return _repository.logout();
  }
}

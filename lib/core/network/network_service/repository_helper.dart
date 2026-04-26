import 'package:dartz/dartz.dart';
import 'exceptions.dart';
import 'failures.dart';

mixin RepositoryHelper {
  Future<Either<Failure, T>> handleEither<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }     on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message, errors: e.validationErrors));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error occurred: $e'));
    }
  }
}

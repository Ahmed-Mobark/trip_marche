import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/filter/domain/entities/filter_destination.dart';
import 'package:trip_marche/features/filter/domain/repositories/filter_repository.dart';

class GetDestinationsUseCase {
  const GetDestinationsUseCase(this._repository);

  final FilterRepository _repository;

  Future<Either<Failure, List<FilterDestination>>> call() {
    return _repository.getDestinations();
  }
}

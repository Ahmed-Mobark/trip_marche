import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/filter/domain/entities/filter_metadata.dart';
import 'package:trip_marche/features/filter/domain/repositories/filter_repository.dart';

class GetFilterMetadataUseCase {
  const GetFilterMetadataUseCase(this._repository);

  final FilterRepository _repository;

  Future<Either<Failure, FilterMetadata>> call({
    Map<String, dynamic>? filters,
  }) {
    return _repository.getFilterMetadata(filters: filters);
  }
}

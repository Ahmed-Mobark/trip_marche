import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/core/network/network_service/repository_helper.dart';
import 'package:trip_marche/features/filter/data/datasources/filter_remote_data_source.dart';
import 'package:trip_marche/features/filter/domain/entities/filter_destination.dart';
import 'package:trip_marche/features/filter/domain/entities/filter_metadata.dart';
import 'package:trip_marche/features/filter/domain/repositories/filter_repository.dart';

class FilterRepositoryImpl with RepositoryHelper implements FilterRepository {
  const FilterRepositoryImpl(this._remoteDataSource);

  final FilterRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<FilterDestination>>> getDestinations() {
    return handleEither(() async {
      final models = await _remoteDataSource.getDestinations();
      return models.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, FilterMetadata>> getFilterMetadata({
    Map<String, dynamic>? filters,
  }) {
    return handleEither(() async {
      final model = await _remoteDataSource.getFilterMetadata(filters: filters);
      return model.toEntity();
    });
  }
}

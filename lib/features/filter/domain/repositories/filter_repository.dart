import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/filter/domain/entities/filter_destination.dart';
import 'package:trip_marche/features/filter/domain/entities/filter_metadata.dart';

abstract class FilterRepository {
  Future<Either<Failure, List<FilterDestination>>> getDestinations();
  Future<Either<Failure, FilterMetadata>> getFilterMetadata({
    Map<String, dynamic>? filters,
  });
}

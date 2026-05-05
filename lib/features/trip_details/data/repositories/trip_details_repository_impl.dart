import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/core/network/network_service/repository_helper.dart';
import 'package:trip_marche/features/trip_details/data/datasources/trip_details_remote_data_source.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'package:trip_marche/features/trip_details/domain/repositories/trip_details_repository.dart';

class TripDetailsRepositoryImpl
    with RepositoryHelper
    implements TripDetailsRepository {
  TripDetailsRepositoryImpl(this._remote);

  final TripDetailsRemoteDataSource _remote;

  @override
  Future<Either<Failure, TripDetails>> getTripDetails(int tripId) =>
      handleEither(() async {
        final model = await _remote.fetchTripDetails(tripId);
        return model.toEntity();
      });
}

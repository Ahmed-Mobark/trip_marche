import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'package:trip_marche/features/trip_details/domain/repositories/trip_details_repository.dart';

class GetTripDetailsUseCase {
  const GetTripDetailsUseCase(this._repository);

  final TripDetailsRepository _repository;

  Future<Either<Failure, TripDetails>> call(int tripId) =>
      _repository.getTripDetails(tripId);
}

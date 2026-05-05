import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';

abstract class TripDetailsRepository {
  Future<Either<Failure, TripDetails>> getTripDetails(int tripId);
}

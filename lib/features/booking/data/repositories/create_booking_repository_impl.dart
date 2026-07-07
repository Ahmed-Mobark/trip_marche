import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/core/network/network_service/repository_helper.dart';
import 'package:trip_marche/features/booking/data/datasources/create_booking_remote_data_source.dart';
import 'package:trip_marche/features/booking/data/models/create_booking_request.dart';
import 'package:trip_marche/features/booking/domain/repositories/create_booking_repository.dart';

class CreateBookingRepositoryImpl with RepositoryHelper
    implements CreateBookingRepository {
  CreateBookingRepositoryImpl(this._remote);

  final CreateBookingRemoteDataSource _remote;

  @override
  Future<Either<Failure, CreateBookingResponse>> createBooking(
    int tripId,
    CreateBookingRequest request,
  ) =>
      handleEither(() async {
        final response = await _remote.createBooking(tripId, request);
        return response;
      });
}

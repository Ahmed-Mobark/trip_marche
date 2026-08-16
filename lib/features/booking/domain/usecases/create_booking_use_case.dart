import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/booking/data/models/create_booking_request.dart';
import 'package:trip_marche/features/booking/domain/repositories/create_booking_repository.dart';

class CreateBookingUseCase {
  const CreateBookingUseCase(this._repository);

  final CreateBookingRepository _repository;

  Future<Either<Failure, CreateBookingResponse>> call({
    required int tripId,
    required CreateBookingRequest request,
  }) =>
      _repository.createBooking(tripId, request);
}

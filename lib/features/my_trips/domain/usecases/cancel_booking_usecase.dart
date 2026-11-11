import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import '../entities/booking_entity.dart';
import '../repositories/bookings_repository.dart';

class CancelBookingUseCase {
  const CancelBookingUseCase(this._repository);

  final BookingsRepository _repository;

  Future<Either<Failure, Booking>> call(int bookingId) =>
      _repository.cancelBooking(bookingId);
}

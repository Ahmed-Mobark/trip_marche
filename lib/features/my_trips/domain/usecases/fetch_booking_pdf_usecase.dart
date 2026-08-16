import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/my_trips/domain/repositories/bookings_repository.dart';

class FetchBookingPdfUseCase {
  const FetchBookingPdfUseCase(this._repository);

  final BookingsRepository _repository;

  Future<Either<Failure, String>> call(int bookingId) {
    return _repository.fetchBookingPdf(bookingId);
  }
}

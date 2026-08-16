import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/my_trips/domain/entities/booking_entity.dart';
import '../repositories/bookings_repository.dart';

class FetchBookingsUseCase {
  const FetchBookingsUseCase(this._repository);

  final BookingsRepository _repository;

  Future<Either<Failure, BookingsPage>> call({
    required int page,
    required String status,
    String search = '',
    int perPage = 10,
  }) {
    return _repository.fetchBookings(
      page: page,
      status: status,
      search: search,
      perPage: perPage,
    );
  }
}

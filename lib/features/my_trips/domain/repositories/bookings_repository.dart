import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/my_trips/domain/entities/booking_entity.dart';

abstract class BookingsRepository {
  Future<Either<Failure, BookingsPage>> fetchBookings({
    required int page,
    int perPage = 15,
  });
}

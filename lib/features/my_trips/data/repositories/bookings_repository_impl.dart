import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/core/network/network_service/repository_helper.dart';
import 'package:trip_marche/features/my_trips/domain/entities/booking_entity.dart';
import 'package:trip_marche/features/my_trips/domain/repositories/bookings_repository.dart';
import '../datasources/bookings_remote_data_source.dart';

class BookingsRepositoryImpl
    with RepositoryHelper
    implements BookingsRepository {
  BookingsRepositoryImpl(this._remote);

  final BookingsRemoteDataSource _remote;

  @override
  Future<Either<Failure, BookingsPage>> fetchBookings({
    required int page,
    int perPage = 15,
  }) {
    return handleEither(() async {
      final model = await _remote.fetchBookings(
        page: page,
        perPage: perPage,
      );
      return model.toEntity();
    });
  }
}

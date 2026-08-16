import 'package:equatable/equatable.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_room.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';

class BookingFlowContext extends Equatable {
  const BookingFlowContext({
    required this.trip,
    required this.departureId,
    required this.dateRange,
    required this.adultCount,
    required this.kidCount,
    required this.babyCount,
    required this.travelersCount,
    required this.rooms,
    required this.currency,
  });

  final TripDetails trip;
  final int departureId;
  final String dateRange;
  final int adultCount;
  final int kidCount;
  final int babyCount;
  final int travelersCount;
  final List<BookingRoom> rooms;
  final String currency;

  @override
  List<Object?> get props => [
        trip,
        departureId,
        dateRange,
        adultCount,
        kidCount,
        babyCount,
        travelersCount,
        rooms,
        currency,
      ];
}

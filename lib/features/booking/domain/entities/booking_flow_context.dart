import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';

class BookingFlowContext {
  const BookingFlowContext({
    required this.trip,
    required this.dateRange,
    required this.adultCount,
    required this.kidCount,
    required this.babyCount,
    required this.travelersCount,
    required this.roomName,
    required this.roomPrice,
    required this.currency,
  });

  final TripDetails trip;
  final String dateRange;
  final int adultCount;
  final int kidCount;
  final int babyCount;
  final int travelersCount;
  final String roomName;
  final double roomPrice;
  final String currency;
}

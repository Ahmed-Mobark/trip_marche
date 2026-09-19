import 'package:equatable/equatable.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_room.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_optional_extra_selection.dart';
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
    this.optionalExtras = const [],
    this.selectedMeetingPointId,
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
  final List<BookingOptionalExtraSelection> optionalExtras;
  final int? selectedMeetingPointId;

  BookingFlowContext copyWith({int? selectedMeetingPointId}) {
    return BookingFlowContext(
      trip: trip,
      departureId: departureId,
      dateRange: dateRange,
      adultCount: adultCount,
      kidCount: kidCount,
      babyCount: babyCount,
      travelersCount: travelersCount,
      rooms: rooms,
      currency: currency,
      optionalExtras: optionalExtras,
      selectedMeetingPointId:
          selectedMeetingPointId ?? this.selectedMeetingPointId,
    );
  }

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
    optionalExtras,
    selectedMeetingPointId,
  ];
}

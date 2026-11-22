import 'booking_price_selection.dart';
import 'booking_occupancy_selection.dart';
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
    this.priceSelections = const [],
    this.selectedMeetingPointId,
    this.selectedAccommodationId,
    this.occupancies = const [],
    this.childrenWithoutBed = 0,
    this.childrenWithBed = 0,
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
  final List<BookingPriceSelection> priceSelections;
  final int? selectedMeetingPointId;
  final int? selectedAccommodationId;
  final List<BookingOccupancySelection> occupancies;
  final int childrenWithoutBed;
  final int childrenWithBed;

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
      priceSelections: priceSelections,
      selectedMeetingPointId:
          selectedMeetingPointId ?? this.selectedMeetingPointId,
      selectedAccommodationId: selectedAccommodationId,
      occupancies: occupancies,
      childrenWithoutBed: childrenWithoutBed,
      childrenWithBed: childrenWithBed,
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
    priceSelections,
    selectedMeetingPointId,
    selectedAccommodationId,
    occupancies,
    childrenWithoutBed,
    childrenWithBed,
  ];
}

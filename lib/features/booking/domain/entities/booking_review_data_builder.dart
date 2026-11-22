import 'package:flutter/widgets.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_activities.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_flow_context.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_room.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_occupancy_selection.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_review_data.dart';
import 'package:trip_marche/features/trip_details/presentation/trip_details_ui_formatters.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';

abstract final class BookingReviewDataBuilder {
  static BookingReviewData fromBookingFlow({
    required BuildContext context,
    required BookingFlowContext flowContext,
    required List<BookingActivities> activities,
  }) {
    final tr = context.tr;
    final trip = flowContext.trip;
    final currency = flowContext.currency;
    final selectedMeetingPoint = trip.meetingPoints
        .where((point) => point.id == flowContext.selectedMeetingPointId)
        .firstOrNull;

    final travelers = activities
        .map((entry) => entry.traveler)
        .toList(growable: false);

    final activitiesTotal = activities.fold<double>(
      0,
      (sum, entry) =>
          sum +
          entry.activities.fold<double>(
            0,
            (inner, activity) => inner + activity.price,
          ),
    );
    final optionalExtrasTotal = flowContext.optionalExtras.fold<double>(
      0,
      (sum, extra) => sum + extra.totalPrice,
    );

    final travelersCount = flowContext.travelersCount > 0
        ? flowContext.travelersCount
        : travelers.length;

    final selectedDeparture = trip.departures
        .where((departure) => departure.id == flowContext.departureId)
        .firstOrNull;
    final unitPrice =
        selectedDeparture?.price ?? trip.discountPrice ?? trip.price;
    final travelersTotal = flowContext.priceSelections.isNotEmpty
        ? flowContext.priceSelections.fold<double>(
            0,
            (sum, option) => sum + option.totalPrice,
          )
        : (flowContext.adultCount * unitPrice) +
              (flowContext.kidCount * (trip.kidPrice ?? 0)) +
              (flowContext.babyCount * (trip.babyPrice ?? 0));
    final matrixScope = selectedDeparture?.pricingMethod == 'hotel'
        ? 'hotel'
        : 'unified';
    final matrix = selectedDeparture == null
        ? const <TripDepartureHotelPrice>[]
        : selectedDeparture.hotelPrices.where(
            (price) =>
                price.scope == matrixScope &&
                (price.scope == 'unified' ||
                    price.accommodationId ==
                        flowContext.selectedAccommodationId),
          );
    final matrixByCategory = {
      for (final price in matrix) price.category: price.amount,
    };
    final matrixTravelerTotal =
        flowContext.occupancies.fold<double>(
          0,
          (sum, item) =>
              sum + (matrixByCategory[item.category] ?? 0) * item.travelers,
        ) +
        (matrixByCategory['child_without_bed'] ?? 0) *
            flowContext.childrenWithoutBed +
        (matrixByCategory['child_with_bed'] ?? 0) *
            flowContext.childrenWithBed +
        (matrixByCategory['infant'] ?? 0) * flowContext.babyCount;
    final roomTypesById = {for (final room in trip.roomTypes) room.id: room};
    final roomTotal = flowContext.rooms.fold<double>(0, (sum, room) {
      final roomType = roomTypesById[room.roomTypeId];
      return sum + room.persons * (roomType?.price ?? 0);
    });

    // Checkout collects the full price without tax, even for legacy trip data.
    const taxes = 0.0;

    final destinationName = trip.destination?.name.isNotEmpty == true
        ? trip.destination!.name
        : trip.country;

    final priceLabel = TripDetailsUiFormatters.formatAmount(
      unitPrice,
      currency: currency,
    );

    final durationDays = trip.hasCustomPricing && selectedDeparture != null
        ? (DateTime.parse(
                selectedDeparture.endDate,
              ).difference(DateTime.parse(selectedDeparture.startDate)).inDays +
              1)
        : trip.durationDays;
    final durationLabel = '$durationDays ${tr.tripDetailsDurationUnit}';
    final roomLabel = flowContext.rooms.isNotEmpty
        ? flowContext.rooms
              .map((r) => '${r.persons} ${tr.bookingPerson}')
              .join(', ')
        : '';

    return BookingReviewData(
      tripId: trip.id,
      trip: BookingReviewTrip(
        name: trip.title,
        description: trip.description.isNotEmpty
            ? trip.description
            : trip.overview,
        dateRange: tr.bookingReviewFromDate(
          flowContext.dateRange.replaceAll(' - ', ' to '),
        ),
        duration: durationLabel,
        participantsSummary:
            flowContext.priceSelections.isNotEmpty ||
                flowContext.occupancies.isNotEmpty
            ? tr.bookingReviewPaymentTravelers(travelersCount)
            : tr.bookingReviewParticipantsSummary(travelersCount, priceLabel),
        routeLabel: tr.bookingReviewRoutePrefix(trip.fromLocation),
        routeHighlight: destinationName,
        meetingTime: tr.bookingReviewMeetingTime(
          TripDetailsUiFormatters.clockTime(
            context,
            selectedMeetingPoint?.time ?? trip.meeting.time,
          ),
        ),
        startingTime: tr.bookingReviewStartingTime(
          TripDetailsUiFormatters.clockTime(context, trip.returnPoint.time),
        ),
        groupSize: tr.bookingReviewGroupSize(
          trip.groupSize.max > 0 ? trip.groupSize.max.toString() : '—',
        ),
        location:
            selectedMeetingPoint?.name ??
            (trip.meeting.location.isNotEmpty
                ? trip.meeting.location
                : trip.fromLocation),
        includedFeatures: trip.inclusions
            .map((inclusion) => inclusion.label)
            .where((label) => label.isNotEmpty)
            .toList(growable: false),
      ),
      travelers: travelers,
      room: BookingRoomSelection(name: roomLabel, price: roomTotal),
      selectedRooms: List<BookingRoom>.of(flowContext.rooms),
      priceSelections: List.of(flowContext.priceSelections),
      activities: activities,
      optionalExtras: List.of(flowContext.optionalExtras),
      priceBreakdown: BookingPriceBreakdown(
        travelersCount: travelersCount,
        travelersTotal: flowContext.occupancies.isNotEmpty
            ? matrixTravelerTotal
            : travelersTotal,
        roomLabel: roomLabel,
        roomTotal: roomTotal,
        activitiesTotal: activitiesTotal,
        optionalExtrasTotal: optionalExtrasTotal,
        taxes: taxes,
      ),
      currency: currency,
      departureId: flowContext.departureId,
      adultCount: flowContext.adultCount,
      kidCount: flowContext.kidCount,
      babyCount: flowContext.babyCount,
      selectedMeetingPointId: flowContext.selectedMeetingPointId,
      selectedAccommodationId: flowContext.selectedAccommodationId,
      occupancies: List<BookingOccupancySelection>.of(flowContext.occupancies),
      childrenWithoutBed: flowContext.childrenWithoutBed,
      childrenWithBed: flowContext.childrenWithBed,
    );
  }
}

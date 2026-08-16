import 'package:flutter/widgets.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_activities.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_flow_context.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_room.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_review_data.dart';
import 'package:trip_marche/features/trip_details/presentation/trip_details_ui_formatters.dart';

abstract final class BookingReviewDataBuilder {
  static BookingReviewData fromBookingFlow({
    required BuildContext context,
    required BookingFlowContext flowContext,
    required List<BookingActivities> activities,
  }) {
    final tr = context.tr;
    final trip = flowContext.trip;
    final currency = flowContext.currency;

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

    final travelersCount = flowContext.travelersCount > 0
        ? flowContext.travelersCount
        : travelers.length;

    final unitPrice = trip.discountPrice ?? trip.price;
    final travelersTotal = travelersCount * unitPrice;
    final roomTotal = flowContext.rooms.isNotEmpty
        ? flowContext.rooms.fold<double>(
            0,
            (sum, room) => sum + room.persons * unitPrice,
          )
        : 0.0;

    final taxableSubtotal = travelersTotal + roomTotal + activitiesTotal;
    final taxes = trip.taxPercent != null
        ? taxableSubtotal * (trip.taxPercent! / 100)
        : 0.0;

    final destinationName = trip.destination?.name.isNotEmpty == true
        ? trip.destination!.name
        : trip.country;

    final priceLabel = TripDetailsUiFormatters.formatAmount(
      unitPrice,
      currency: currency,
    );

    final durationLabel = '${trip.durationDays} ${tr.tripDetailsDurationUnit}';
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
        participantsSummary: tr.bookingReviewParticipantsSummary(
          travelersCount,
          priceLabel,
        ),
        routeLabel: tr.bookingReviewRoutePrefix(trip.fromLocation),
        routeHighlight: destinationName,
        meetingTime: tr.bookingReviewMeetingTime(
          TripDetailsUiFormatters.clockTime(context, trip.meeting.time),
        ),
        startingTime: tr.bookingReviewStartingTime(
          TripDetailsUiFormatters.clockTime(context, trip.returnPoint.time),
        ),
        groupSize: tr.bookingReviewGroupSize(
          '${trip.groupSize.min}-${trip.groupSize.max}',
        ),
        location: trip.meeting.location.isNotEmpty
            ? trip.meeting.location
            : trip.fromLocation,
        includedFeatures: trip.inclusions
            .map((inclusion) => inclusion.label)
            .where((label) => label.isNotEmpty)
            .toList(growable: false),
      ),
      travelers: travelers,
      room: BookingRoomSelection(
        name: roomLabel,
        price: roomTotal,
      ),
      selectedRooms: List<BookingRoom>.of(flowContext.rooms),
      activities: activities,
      priceBreakdown: BookingPriceBreakdown(
        travelersCount: travelersCount,
        travelersTotal: travelersTotal,
        roomLabel: roomLabel,
        roomTotal: roomTotal,
        activitiesTotal: activitiesTotal,
        taxes: taxes,
      ),
      currency: currency,
      departureId: flowContext.departureId,
      adultCount: flowContext.adultCount,
      kidCount: flowContext.kidCount,
      babyCount: flowContext.babyCount,
    );
  }
}

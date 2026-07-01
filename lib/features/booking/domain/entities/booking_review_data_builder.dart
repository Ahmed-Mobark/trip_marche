import 'package:flutter/widgets.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_activities.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_review_data.dart';

abstract final class BookingReviewDataBuilder {
  static const double _travelerUnitPrice = 1000;
  static const double _taxesAmount = 70;

  static BookingReviewData fromBookingFlow({
    required BuildContext context,
    required List<BookingActivities> activities,
    required String dateRange,
    required int travelersCount,
    required String roomName,
    required double roomPrice,
  }) {
    final tr = context.tr;
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

    final effectiveTravelers =
        travelersCount > 0 ? travelersCount : travelers.length;

    final formattedDateRange = dateRange.replaceAll(' - ', ' to ');

    return BookingReviewData(
      trip: BookingReviewTrip(
        name: tr.bookingReviewTripName,
        description: tr.bookingReviewTripDescription,
        dateRange: tr.bookingReviewFromDate(formattedDateRange),
        duration: tr.bookingReviewDuration,
        participantsSummary: tr.bookingReviewParticipantsSummary(
          effectiveTravelers,
          _travelerUnitPrice.toStringAsFixed(0),
        ),
        routeLabel: tr.bookingReviewRoutePrefix,
        routeHighlight: tr.bookingReviewRouteDestination,
        meetingTime: tr.bookingReviewMeetingTime,
        startingTime: tr.bookingReviewStartingTime,
        groupSize: tr.bookingReviewGroupSize,
        location: tr.bookingReviewLocation,
        includedFeatures: [
          tr.bookingReviewIncludedFreeCancellation,
          tr.bookingReviewIncludedBreakfast,
          tr.bookingReviewIncludedHotelStay,
          tr.bookingReviewIncludedAirportTransfer,
        ],
      ),
      travelers: travelers,
      room: BookingRoomSelection(name: roomName, price: roomPrice),
      activities: activities,
      priceBreakdown: BookingPriceBreakdown(
        travelersCount: effectiveTravelers,
        travelersTotal: effectiveTravelers * _travelerUnitPrice,
        roomLabel: roomName,
        roomTotal: roomPrice,
        activitiesTotal: activitiesTotal,
        taxes: _taxesAmount,
      ),
    );
  }
}

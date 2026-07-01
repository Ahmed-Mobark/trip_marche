import 'package:trip_marche/features/booking/domain/entities/booking_activities.dart';
import 'package:trip_marche/features/booking/domain/entities/traveler_contact.dart';

class BookingReviewTrip {
  const BookingReviewTrip({
    required this.name,
    required this.description,
    required this.dateRange,
    required this.duration,
    required this.participantsSummary,
    required this.routeLabel,
    required this.routeHighlight,
    required this.meetingTime,
    required this.startingTime,
    required this.groupSize,
    required this.location,
    required this.includedFeatures,
  });

  final String name;
  final String description;
  final String dateRange;
  final String duration;
  final String participantsSummary;
  final String routeLabel;
  final String routeHighlight;
  final String meetingTime;
  final String startingTime;
  final String groupSize;
  final String location;
  final List<String> includedFeatures;
}

class BookingRoomSelection {
  const BookingRoomSelection({
    required this.name,
    required this.price,
  });

  final String name;
  final double price;
}

class BookingPriceBreakdown {
  const BookingPriceBreakdown({
    required this.travelersCount,
    required this.travelersTotal,
    required this.roomLabel,
    required this.roomTotal,
    required this.activitiesTotal,
    required this.taxes,
    this.couponDiscount = 0,
  });

  final int travelersCount;
  final double travelersTotal;
  final String roomLabel;
  final double roomTotal;
  final double activitiesTotal;
  final double taxes;
  final double couponDiscount;

  double get total =>
      travelersTotal + roomTotal + activitiesTotal + taxes - couponDiscount;

  BookingPriceBreakdown copyWith({double? couponDiscount}) {
    return BookingPriceBreakdown(
      travelersCount: travelersCount,
      travelersTotal: travelersTotal,
      roomLabel: roomLabel,
      roomTotal: roomTotal,
      activitiesTotal: activitiesTotal,
      taxes: taxes,
      couponDiscount: couponDiscount ?? this.couponDiscount,
    );
  }
}

class BookingReviewData {
  const BookingReviewData({
    required this.trip,
    required this.travelers,
    required this.room,
    required this.activities,
    required this.priceBreakdown,
  });

  final BookingReviewTrip trip;
  final List<TravelerContact> travelers;
  final BookingRoomSelection room;
  final List<BookingActivities> activities;
  final BookingPriceBreakdown priceBreakdown;
}

import 'package:equatable/equatable.dart';

/// Local category used to split bookings into the My Trips tabs.
/// Mirrors [MyTripsShellTab] (active / past / canceled) but lives in the
/// domain layer to avoid a presentation -> domain dependency.
enum BookingStatusCategory { active, past, cancelled }

class BookingPaymentDetail extends Equatable {
  const BookingPaymentDetail({
    required this.baseAmount,
    required this.roomsAmount,
    required this.activitiesAmount,
    required this.discountAmount,
    required this.taxAmount,
    required this.totalAmount,
    this.couponCode,
  });

  final double baseAmount;
  final double roomsAmount;
  final double activitiesAmount;
  final double discountAmount;
  final double taxAmount;
  final double totalAmount;
  final String? couponCode;

  @override
  List<Object?> get props => [
        baseAmount,
        roomsAmount,
        activitiesAmount,
        discountAmount,
        taxAmount,
        totalAmount,
        couponCode,
      ];
}

class BookingDates extends Equatable {
  const BookingDates({
    required this.startDate,
    required this.endDate,
    required this.durationDays,
  });

  final String startDate;
  final String endDate;
  final int durationDays;

  DateTime? get startDateParsed => DateTime.tryParse(startDate);
  DateTime? get endDateParsed => DateTime.tryParse(endDate);

  String get range => '$startDate - $endDate';

  @override
  List<Object?> get props => [startDate, endDate, durationDays];
}

class BookingTravelersCount extends Equatable {
  const BookingTravelersCount({
    required this.adults,
    required this.kids,
    required this.babies,
    required this.total,
  });

  final int adults;
  final int kids;
  final int babies;
  final int total;

  @override
  List<Object?> get props => [adults, kids, babies, total];
}

class BookingTrip extends Equatable {
  const BookingTrip({
    required this.id,
    required this.title,
    this.coverImage,
    required this.fromLocation,
  });

  final int id;
  final String title;
  final String? coverImage;
  final String fromLocation;

  @override
  List<Object?> get props => [id, title, coverImage, fromLocation];
}

class Booking extends Equatable {
  const Booking({
    required this.id,
    required this.reference,
    required this.status,
    required this.paymentStatus,
    this.paidAt,
    required this.currency,
    required this.trip,
    required this.dates,
    required this.travelersCount,
    required this.paymentDetail,
    required this.createdAt,
  });

  final int id;
  final String reference;
  final String status;
  final String paymentStatus;
  final String? paidAt;
  final String currency;
  final BookingTrip trip;
  final BookingDates dates;
  final BookingTravelersCount travelersCount;
  final BookingPaymentDetail paymentDetail;
  final String createdAt;

  /// Classifies this booking into a tab without any extra request.
  BookingStatusCategory get statusCategory {
    final s = status.trim().toLowerCase();
    if (s == 'cancelled' || s == 'canceled') {
      return BookingStatusCategory.cancelled;
    }
    final now = DateTime.now();
    final ended = dates.endDateParsed;
    if (s == 'completed' ||
        s == 'past' ||
        (ended != null && ended.isBefore(now))) {
      return BookingStatusCategory.past;
    }
    return BookingStatusCategory.active;
  }

  @override
  List<Object?> get props => [
        id,
        reference,
        status,
        paymentStatus,
        paidAt,
        currency,
        trip,
        dates,
        travelersCount,
        paymentDetail,
        createdAt,
      ];
}

class BookingPaginationMeta extends Equatable {
  const BookingPaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [currentPage, lastPage, perPage, total];
}

class BookingsPage extends Equatable {
  const BookingsPage({required this.bookings, required this.meta});

  final List<Booking> bookings;
  final BookingPaginationMeta meta;

  @override
  List<Object?> get props => [bookings, meta];
}

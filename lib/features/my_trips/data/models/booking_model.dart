import 'package:trip_marche/features/my_trips/domain/entities/booking_entity.dart';

class BookingPaymentDetailModel {
  const BookingPaymentDetailModel({
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

  factory BookingPaymentDetailModel.fromJson(Map<String, dynamic> json) {
    return BookingPaymentDetailModel(
      baseAmount: (json['base_amount'] as num?)?.toDouble() ?? 0.0,
      roomsAmount: (json['rooms_amount'] as num?)?.toDouble() ?? 0.0,
      activitiesAmount: (json['activities_amount'] as num?)?.toDouble() ?? 0.0,
      discountAmount: (json['discount_amount'] as num?)?.toDouble() ?? 0.0,
      taxAmount: (json['tax_amount'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      couponCode: json['coupon_code'] as String?,
    );
  }

  BookingPaymentDetail toEntity() => BookingPaymentDetail(
        baseAmount: baseAmount,
        roomsAmount: roomsAmount,
        activitiesAmount: activitiesAmount,
        discountAmount: discountAmount,
        taxAmount: taxAmount,
        totalAmount: totalAmount,
        couponCode: couponCode,
      );
}

class BookingDatesModel {
  const BookingDatesModel({
    required this.startDate,
    required this.endDate,
    required this.durationDays,
  });

  final String startDate;
  final String endDate;
  final int durationDays;

  factory BookingDatesModel.fromJson(Map<String, dynamic> json) {
    return BookingDatesModel(
      startDate: (json['start_date'] as String?)?.trim() ?? '',
      endDate: (json['end_date'] as String?)?.trim() ?? '',
      durationDays: json['duration_days'] as int? ?? 0,
    );
  }

  BookingDates toEntity() => BookingDates(
        startDate: startDate,
        endDate: endDate,
        durationDays: durationDays,
      );
}

class BookingTravelersCountModel {
  const BookingTravelersCountModel({
    required this.adults,
    required this.kids,
    required this.babies,
    required this.total,
  });

  final int adults;
  final int kids;
  final int babies;
  final int total;

  factory BookingTravelersCountModel.fromJson(Map<String, dynamic> json) {
    return BookingTravelersCountModel(
      adults: json['adults'] as int? ?? 0,
      kids: json['kids'] as int? ?? 0,
      babies: json['babies'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
    );
  }

  BookingTravelersCount toEntity() => BookingTravelersCount(
        adults: adults,
        kids: kids,
        babies: babies,
        total: total,
      );
}

class BookingTripModel {
  const BookingTripModel({
    required this.id,
    required this.title,
    this.coverImage,
    required this.fromLocation,
  });

  final int id;
  final String title;
  final String? coverImage;
  final String fromLocation;

  factory BookingTripModel.fromJson(Map<String, dynamic> json) {
    final cover = json['cover_image'] as String?;
    return BookingTripModel(
      id: json['id'] as int? ?? 0,
      title: (json['title'] as String?)?.trim() ?? '',
      coverImage: cover?.trim().isNotEmpty == true ? cover!.trim() : null,
      fromLocation: (json['from_location'] as String?)?.trim() ?? '',
    );
  }

  BookingTrip toEntity() => BookingTrip(
        id: id,
        title: title,
        coverImage: coverImage,
        fromLocation: fromLocation,
      );
}

class BookingModel {
  const BookingModel({
    required this.id,
    required this.reference,
    required this.status,
    required this.paymentStatus,
    this.paymentMethod,
    this.requiresPayment = false,
    this.paidAt,
    this.expiresAt,
    required this.currency,
    this.payment,
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
  final String? paymentMethod;
  final bool requiresPayment;
  final String? paidAt;
  final String? expiresAt;
  final String currency;
  final Map<String, dynamic>? payment;
  final BookingTripModel trip;
  final BookingDatesModel dates;
  final BookingTravelersCountModel travelersCount;
  final BookingPaymentDetailModel paymentDetail;
  final String createdAt;

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    final trip = json['trip'] as Map<String, dynamic>? ?? {};
    final dates = json['dates'] as Map<String, dynamic>? ?? {};
    final travelers = json['travelers_count'] as Map<String, dynamic>? ?? {};
    final payment = json['payment_detail'] as Map<String, dynamic>? ?? {};
    final rawPayment = json['payment'];
    return BookingModel(
      id: json['id'] as int? ?? 0,
      reference: (json['reference'] as String?)?.trim() ?? '',
      status: (json['status'] as String?)?.trim() ?? '',
      paymentStatus: (json['payment_status'] as String?)?.trim() ?? '',
      paymentMethod: json['payment_method'] as String?,
      requiresPayment: json['requires_payment'] as bool? ?? false,
      paidAt: json['paid_at'] as String?,
      expiresAt: json['expires_at'] as String?,
      currency: (json['currency'] as String?)?.trim().isNotEmpty == true
          ? (json['currency'] as String).trim()
          : 'EGP',
      payment: rawPayment is Map<String, dynamic>
          ? Map<String, dynamic>.from(rawPayment)
          : null,
      trip: BookingTripModel.fromJson(trip),
      dates: BookingDatesModel.fromJson(dates),
      travelersCount: BookingTravelersCountModel.fromJson(travelers),
      paymentDetail: BookingPaymentDetailModel.fromJson(payment),
      createdAt: (json['created_at'] as String?)?.trim() ?? '',
    );
  }

  Booking toEntity() => Booking(
        id: id,
        reference: reference,
        status: status,
        paymentStatus: paymentStatus,
        paymentMethod: paymentMethod,
        requiresPayment: requiresPayment,
        paidAt: paidAt,
        expiresAt: expiresAt,
        currency: currency,
        payment: payment,
        trip: trip.toEntity(),
        dates: dates.toEntity(),
        travelersCount: travelersCount.toEntity(),
        paymentDetail: paymentDetail.toEntity(),
        createdAt: createdAt,
      );
}

class BookingPaginationMetaModel {
  const BookingPaginationMetaModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  factory BookingPaginationMetaModel.fromJson(Map<String, dynamic> json) {
    return BookingPaginationMetaModel(
      currentPage: json['current_page'] as int? ?? 1,
      lastPage: json['last_page'] as int? ?? 1,
      perPage: json['per_page'] as int? ?? 15,
      total: json['total'] as int? ?? 0,
    );
  }

  BookingPaginationMeta toEntity() => BookingPaginationMeta(
        currentPage: currentPage,
        lastPage: lastPage,
        perPage: perPage,
        total: total,
      );
}

class BookingsPageModel {
  const BookingsPageModel({required this.bookings, required this.meta});

  final List<BookingModel> bookings;
  final BookingPaginationMetaModel meta;

  factory BookingsPageModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>? ?? [];
    return BookingsPageModel(
      bookings: data
          .map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: BookingPaginationMetaModel.fromJson(
        json['meta'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  BookingsPage toEntity() => BookingsPage(
        bookings: bookings.map((e) => e.toEntity()).toList(),
        meta: meta.toEntity(),
      );
}

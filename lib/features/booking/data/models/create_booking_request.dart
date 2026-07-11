import 'package:equatable/equatable.dart';

class CreateBookingRoom {
  const CreateBookingRoom({required this.roomTypeId, required this.persons});

  final int roomTypeId;
  final int persons;

  Map<String, dynamic> toJson() => {
    'room_type_id': roomTypeId,
    'persons': persons,
  };
}

class CreateBookingActivity {
  const CreateBookingActivity({
    required this.travelerIndex,
    required this.activityId,
  });

  final int travelerIndex;
  final int activityId;

  Map<String, dynamic> toJson() => {
    'traveler_index': travelerIndex,
    'activity_id': activityId,
  };
}

class CreateBookingTraveler {
  const CreateBookingTraveler({
    required this.fullName,
    this.phoneCountryCode,
    this.phone,
    required this.type,
  });

  final String fullName;
  final String? phoneCountryCode;
  final String? phone;
  final String type;

  Map<String, dynamic> toJson() => {
    'full_name': fullName,
    'phone_country_code': phoneCountryCode,
    'phone': phone,
    'type': type,
  };
}

class CreateBookingRequest {
  const CreateBookingRequest({
    required this.departureId,
    required this.adults,
    required this.kids,
    required this.babies,
    required this.rooms,
    required this.activities,
    this.couponCode,
    required this.travelers,
    this.notes,
    this.paymentMethod,
  });

  final int departureId;
  final int adults;
  final int kids;
  final int babies;
  final List<CreateBookingRoom> rooms;
  final List<CreateBookingActivity> activities;
  final String? couponCode;
  final List<CreateBookingTraveler> travelers;
  final String? notes;
  final String? paymentMethod;

  Map<String, dynamic> toJson() => {
    'departure_id': departureId,
    'adults': adults,
    'kids': kids,
    'babies': babies,
    'rooms': rooms.map((r) => r.toJson()).toList(growable: false),
    'activities': activities.map((a) => a.toJson()).toList(growable: false),
    'coupon_code': couponCode,
    'travelers': travelers.map((t) => t.toJson()).toList(growable: false),
    'notes': notes,
    'payment_method': paymentMethod,
  };
}

class PaymentModel extends Equatable {
  const PaymentModel({this.provider, this.checkoutUrl});

  final String? provider;
  final String? checkoutUrl;

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      provider: json['provider']?.toString(),
      checkoutUrl: json['checkout_url']?.toString(),
    );
  }

  @override
  List<Object?> get props => [provider, checkoutUrl];
}

class CreateBookingData extends Equatable {
  const CreateBookingData({
    this.bookingId,
    this.reference,
    this.status,
    this.paymentStatus,
    this.paymentMethod,
    this.requiresPayment,
    this.payment,
  });

  final int? bookingId;
  final String? reference;
  final String? status;
  final String? paymentStatus;
  final String? paymentMethod;
  final bool? requiresPayment;
  final PaymentModel? payment;

  factory CreateBookingData.fromJson(Map<String, dynamic> json) {
    final rawPayment = json['payment'];
    return CreateBookingData(
      bookingId: json['booking_id'] is int
          ? json['booking_id'] as int
          : int.tryParse(json['booking_id']?.toString() ?? ''),
      reference: json['reference']?.toString(),
      status: json['status']?.toString(),
      paymentStatus: json['payment_status']?.toString(),
      paymentMethod: json['payment_method']?.toString(),
      requiresPayment: json['requires_payment'] == true,
      payment: rawPayment is Map<String, dynamic>
          ? PaymentModel.fromJson(rawPayment)
          : null,
    );
  }

  @override
  List<Object?> get props => [
    bookingId,
    reference,
    status,
    paymentStatus,
    paymentMethod,
    requiresPayment,
    payment,
  ];
}

class CreateBookingResponse extends Equatable {
  const CreateBookingResponse({
    required this.success,
    required this.message,
    this.data,
  });

  final bool success;
  final String message;
  final CreateBookingData? data;

  factory CreateBookingResponse.fromApiResponse(Map<String, dynamic> json) {
    final success = json['success'] == true;
    final rawData = json['data'];
    return CreateBookingResponse(
      success: success,
      message: json['message']?.toString() ?? '',
      data: rawData is Map<String, dynamic>
          ? CreateBookingData.fromJson(rawData)
          : null,
    );
  }

  @override
  List<Object?> get props => [success, message, data];
}

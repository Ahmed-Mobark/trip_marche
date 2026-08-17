import 'package:equatable/equatable.dart';

class CreateBookingRoom {
  const CreateBookingRoom({
    required this.roomTypeId,
    required this.persons,
  });

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
      };
}

class CreateBookingData extends Equatable {
  const CreateBookingData({
    this.bookingId,
    this.reference,
  });

  final int? bookingId;
  final String? reference;

  factory CreateBookingData.fromJson(Map<String, dynamic> json) {
    return CreateBookingData(
      bookingId: json['booking_id'] is int
          ? json['booking_id'] as int
          : int.tryParse(json['booking_id']?.toString() ?? ''),
      reference: json['reference']?.toString(),
    );
  }

  @override
  List<Object?> get props => [bookingId, reference];
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

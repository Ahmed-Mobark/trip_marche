import '../../domain/entities/booking_price_selection.dart';
import '../../domain/entities/booking_quote.dart';
import '../../domain/entities/booking_review_data.dart';
import '../../domain/entities/coupon_validation.dart';

class BookingQuoteModel {
  static BookingQuote fromApiResponse(Map<String, dynamic> json) {
    final raw = json['data'];
    if (json['success'] != true ||
        raw is! Map<String, dynamic> ||
        raw['payment_detail'] is! Map) {
      throw FormatException(
        json['message']?.toString() ?? 'Invalid booking quote',
      );
    }
    final details = Map<String, dynamic>.from(raw['payment_detail'] as Map);
    double amount(String key) =>
        double.tryParse(details[key]?.toString() ?? '') ?? 0;
    final coupon = raw['coupon'];
    final travelers = raw['travelers'];
    final rooms = raw['rooms'];
    return BookingQuote(
      totalBase: amount('total_amount_base'),
      priceSelections:
          (raw['price_options'] is List
                  ? raw['price_options'] as List
                  : const [])
              .whereType<Map>()
              .map(
                (option) => BookingPriceSelection(
                  priceOptionId: (option['price_option_id'] as num).toInt(),
                  travelerType: option['traveler_type']?.toString() ?? '',
                  label: option['label']?.toString() ?? '',
                  unitPrice:
                      double.tryParse(option['unit_price']?.toString() ?? '') ??
                      0,
                  quantity: (option['quantity'] as num).toInt(),
                ),
              )
              .toList(),
      currency: raw['currency']?.toString() ?? 'EGP',
      breakdown: BookingPriceBreakdown(
        travelersCount: travelers is Map
            ? (travelers['totalTravelers'] as num?)?.toInt() ?? 0
            : 0,
        travelersTotal: amount('base_amount'),
        roomLabel: rooms is List
            ? rooms
                  .whereType<Map>()
                  .map((room) => room['name']?.toString() ?? '')
                  .join(', ')
            : '',
        roomTotal: amount('rooms_amount'),
        activitiesTotal: amount('activities_amount'),
        optionalExtrasTotal: amount('optional_extras_amount'),
        taxes: amount('tax_amount'),
        couponDiscount: amount('discount_amount'),
        quotedSubtotal: amount('subtotal'),
        quotedTotal: amount('total_amount'),
      ),
      coupon: coupon is Map
          ? CouponValidation(
              code: coupon['code']?.toString() ?? '',
              type: coupon['type']?.toString() ?? 'fixed',
              value: double.tryParse(coupon['value']?.toString() ?? '') ?? 0,
              discountAmount: amount('discount_amount'),
              message: json['message']?.toString() ?? '',
              terms:
                  (coupon['terms'] as List?)?.whereType<String>().toList() ??
                  const [],
            )
          : null,
    );
  }
}

class BookingQuoteRequest {
  const BookingQuoteRequest(this.data, {this.couponCode});
  final BookingReviewData data;
  final String? couponCode;
  Map<String, dynamic> toJson() => {
    if (data.departureId > 0) 'departure_id': data.departureId,
    if (data.selectedMeetingPointId != null)
      'meeting_point_id': data.selectedMeetingPointId,
    if (data.selectedAccommodationId != null)
      'trip_accommodation_id': data.selectedAccommodationId,
    'adults': data.adultCount,
    'kids': data.kidCount,
    'babies': data.babyCount,
    if (data.occupancies.isNotEmpty) ...{
      'occupancies': data.occupancies
          .map(
            (item) => {'category': item.category, 'travelers': item.travelers},
          )
          .toList(growable: false),
      'children_without_bed': data.childrenWithoutBed,
      'children_with_bed': data.childrenWithBed,
    },
    'rooms': data.selectedRooms
        .map(
          (room) => {'room_type_id': room.roomTypeId, 'persons': room.persons},
        )
        .toList(),
    if (data.priceSelections.isNotEmpty)
      'price_options': data.priceSelections
          .map(
            (option) => {
              'price_option_id': option.priceOptionId,
              'quantity': option.quantity,
            },
          )
          .toList(),
    'activities': [
      for (final entry in data.activities)
        for (final activity in entry.activities)
          {
            'activity_id': int.parse(activity.id),
            'traveler_index': data.travelers.indexOf(entry.traveler),
          },
    ],
    'optional_extras': data.optionalExtras
        .where((extra) => extra.quantity > 0)
        .map((extra) => {'extra_id': extra.extraId, 'quantity': extra.quantity})
        .toList(),
    if (couponCode?.trim().isNotEmpty == true)
      'coupon_code': couponCode!.trim(),
  };
}

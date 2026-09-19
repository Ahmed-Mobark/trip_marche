import 'package:flutter_test/flutter_test.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_optional_extra_selection.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_review_data.dart';

void main() {
  test('optional extra total is unit price multiplied by quantity', () {
    const extra = BookingOptionalExtraSelection(
      extraId: 5,
      name: 'Vendor extra',
      unitPrice: 100,
      currency: 'EGP',
      quantity: 2,
    );

    expect(extra.totalPrice, 200);
  });

  test('optional extras are included once in the booking subtotal', () {
    const breakdown = BookingPriceBreakdown(
      travelersCount: 1,
      travelersTotal: 1000,
      roomLabel: 'Room',
      roomTotal: 200,
      activitiesTotal: 50,
      optionalExtrasTotal: 350,
      taxes: 0,
    );

    expect(breakdown.subtotal, 1600);
    expect(breakdown.total, 1600);
  });
}

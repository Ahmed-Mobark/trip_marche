import 'package:flutter_test/flutter_test.dart';
import 'package:trip_marche/features/booking/data/models/create_booking_request.dart';

void main() {
  test('booking payload sends occupancy categories without client prices', () {
    const request = CreateBookingRequest(
      departureId: 8,
      tripAccommodationId: 23,
      adults: 2,
      kids: 1,
      babies: 1,
      rooms: [],
      activities: [],
      travelers: [],
      occupancies: [
        CreateBookingOccupancy(category: 'single', travelers: 1),
        CreateBookingOccupancy(category: 'double', travelers: 1),
      ],
      childrenWithoutBed: 0,
      childrenWithBed: 1,
    );

    final payload = request.toJson();
    expect(payload['occupancies'], [
      {'category': 'single', 'travelers': 1},
      {'category': 'double', 'travelers': 1},
    ]);
    expect(payload['children_with_bed'], 1);
    expect(payload.containsKey('prices'), isFalse);
    expect(payload.containsKey('unit_price'), isFalse);
  });
}

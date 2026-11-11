import 'package:flutter_test/flutter_test.dart';
import 'package:trip_marche/features/trip_details/data/models/trip_details_model.dart';

void main() {
  test(
    'new dashboard fields are consumed alongside the existing API shape',
    () {
      final trip = TripDetailsModel.fromApiResponse({
        'data': {
          'days': [
            {'day_number': 1, 'title': 'Arrival', 'stay_city': 'Dahab'},
          ],
          'journey_highlights': [
            {
              'name': 'Blue Hole',
              'description': 'Snorkeling stop',
              'image_url': 'https://example.test/blue-hole.jpg',
            },
          ],
          'destination_information': [
            {'country': 'Egypt', 'city': 'Dahab', 'destination': 'Dahab'},
          ],
          'accommodations': [
            {'name': 'Hotel', 'address': 'Street address', 'city': 'Dahab'},
          ],
          'transports': [
            {'type': 'car', 'company': null, 'company_name': 'Local transfer'},
            {
              'type': 'bus',
              'company': {'id': 7, 'name': 'Previous catalog company'},
            },
          ],
        },
      }).toEntity();

      expect(trip.days.single.stayCity, 'Dahab');
      expect(trip.journeyHighlights.single.name, 'Blue Hole');
      expect(
        trip.journeyHighlights.single.imageUrl,
        'https://example.test/blue-hole.jpg',
      );
      expect(trip.destinationInformation.single.country, 'Egypt');
      expect(trip.destinationInformation.single.city, 'Dahab');
      expect(trip.accommodations.single.city, 'Dahab');
      expect(trip.transports.first.company.name, 'Local transfer');
      expect(trip.transports.last.company.id, 7);
      expect(trip.transports.last.company.name, 'Previous catalog company');
    },
  );

  test('older API responses still parse without the new fields', () {
    final trip = TripDetailsModel.fromApiResponse({
      'data': {
        'days': [
          {'day_number': 1, 'title': 'Old itinerary'},
        ],
        'accommodations': [
          {'name': 'Old hotel', 'address': 'Old address'},
        ],
      },
    }).toEntity();

    expect(trip.days.single.stayCity, isEmpty);
    expect(trip.accommodations.single.city, isEmpty);
    expect(trip.journeyHighlights, isEmpty);
  });
}

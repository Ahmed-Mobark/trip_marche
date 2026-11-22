import 'package:flutter_test/flutter_test.dart';
import 'package:trip_marche/features/home/data/models/home_section_response.dart';
import 'package:trip_marche/features/trip_details/data/models/trip_details_model.dart';

void main() {
  test(
    'trip cards parse the seasonal marker separately from special flags',
    () {
      final flags = TripFlags.fromJson({'special': false, 'seasonal': true});

      expect(flags.special, isFalse);
      expect(flags.seasonal, isTrue);
    },
  );

  test(
    'new dashboard fields are consumed alongside the existing API shape',
    () {
      final trip = TripDetailsModel.fromApiResponse({
        'data': {
          'season': 'eid',
          'flags': {'seasonal': true},
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
            {
              'id': 17,
              'hotel_id': 5,
              'is_registered': true,
              'name': 'Hotel',
              'address': 'Street address',
              'city': 'Dahab',
              'accommodation_type': 'Hotel',
              'google_maps_url': 'https://maps.google.com/?q=1',
              'images': ['https://example.test/hotel.jpg'],
            },
          ],
          'departures': [
            {
              'id': 31,
              'pricing_method': 'hotel',
              'configured_currency': 'USD',
              'hotel_prices': [
                {
                  'trip_accommodation_id': 17,
                  'pricing_scope': 'hotel',
                  'category': 'single',
                  'amount': 150,
                },
              ],
            },
          ],
          'activities': [
            {
              'id': 44,
              'trip_departure_id': 31,
              'pricing_unit': 'per_person',
              'image': 'https://cdn.example.test/activities/sunrise.jpg',
              'label': 'Sunrise hike',
              'price': 25,
            },
          ],
          'optional_extras': [
            {
              'id': 55,
              'trip_departure_id': 31,
              'pricing_unit': 'per_night',
              'maximum_quantity': 3,
              'name': 'Extra night',
              'unit_price': 45,
              'currency': 'EGP',
            },
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
      expect(trip.season, 'eid');
      expect(trip.flags.seasonal, isTrue);
      expect(trip.journeyHighlights.single.name, 'Blue Hole');
      expect(
        trip.journeyHighlights.single.imageUrl,
        'https://example.test/blue-hole.jpg',
      );
      expect(trip.destinationInformation.single.country, 'Egypt');
      expect(trip.destinationInformation.single.city, 'Dahab');
      expect(trip.accommodations.single.city, 'Dahab');
      expect(trip.accommodations.single.id, 17);
      expect(trip.accommodations.single.hotelId, 5);
      expect(trip.accommodations.single.isRegistered, isTrue);
      expect(trip.accommodations.single.accommodationType, 'Hotel');
      expect(
        trip.accommodations.single.googleMapsUrl,
        'https://maps.google.com/?q=1',
      );
      expect(trip.accommodations.single.images, [
        'https://example.test/hotel.jpg',
      ]);
      expect(trip.departures.single.pricingMethod, 'hotel');
      expect(trip.departures.single.configuredCurrency, 'USD');
      expect(trip.departures.single.hotelPrices.single.accommodationId, 17);
      expect(trip.departures.single.hotelPrices.single.amount, 150);
      expect(trip.activities.single.departureId, 31);
      expect(trip.activities.single.pricingUnit, 'per_person');
      expect(
        trip.activities.single.image,
        'https://cdn.example.test/activities/sunrise.jpg',
      );
      expect(trip.optionalExtras.single.departureId, 31);
      expect(trip.optionalExtras.single.maximumQuantity, 3);
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

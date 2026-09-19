import 'package:flutter_test/flutter_test.dart';
import 'package:trip_marche/features/trip_details/data/models/trip_details_model.dart';

void main() {
  group('TripDetails meeting points', () {
    test('parses complete and nullable meeting point fields safely', () {
      final trip = TripDetailsModel.fromApiResponse({
        'data': {
          'meeting_points': [
            {
              'id': 1,
              'name': 'Cairo Airport · T3',
              'address': 'Terminal 3',
              'lat': 30.1219,
              'lng': '31.4056',
              'time': '05:00',
            },
            {'id': '2', 'name': 'Ramses Station', 'address': null},
          ],
        },
      }).toEntity();

      expect(trip.meetingPoints, hasLength(2));
      expect(trip.meetingPoints.first.id, 1);
      expect(trip.meetingPoints.first.lat, 30.1219);
      expect(trip.meetingPoints.first.lng, 31.4056);
      expect(trip.meetingPoints.last.id, 2);
      expect(trip.meetingPoints.last.address, isNull);
      expect(trip.meetingPoints.last.time, isNull);
    });

    test('uses an empty list when meeting_points is missing or null', () {
      final missing = TripDetailsModel.fromApiResponse({
        'data': <String, dynamic>{},
      }).toEntity();
      final nullValue = TripDetailsModel.fromApiResponse({
        'data': {'meeting_points': null},
      }).toEntity();

      expect(missing.meetingPoints, isEmpty);
      expect(nullValue.meetingPoints, isEmpty);
    });
  });
}

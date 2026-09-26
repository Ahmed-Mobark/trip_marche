import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/booking/data/models/create_booking_request.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_activities.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_flow_context.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_review_data_builder.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_room.dart';
import 'package:trip_marche/features/booking/domain/entities/traveler_contact.dart';
import 'package:trip_marche/features/booking/domain/repositories/create_booking_repository.dart';
import 'package:trip_marche/features/booking/domain/usecases/create_booking_use_case.dart';
import 'package:trip_marche/features/booking/presentation/cubit/create_booking_cubit.dart';
import 'package:trip_marche/features/trip_details/data/models/trip_details_model.dart';
import 'package:trip_marche/core/translation/app_localizations.dart';

class _RecordingRepository implements CreateBookingRepository {
  final bodies = <Map<String, dynamic>>[];

  @override
  Future<Either<Failure, CreateBookingResponse>> createBooking(
    int tripId,
    CreateBookingRequest request,
  ) async {
    bodies.add(request.toJson());
    return const Right(CreateBookingResponse(success: true, message: ''));
  }
}

void main() {
  testWidgets(
    'selected point survives review and changes the booking payload',
    (tester) async {
      final repository = _RecordingRepository();
      final cubit = CreateBookingCubit(CreateBookingUseCase(repository));
      addTearDown(cubit.close);
      final trip = TripDetailsModel.fromApiResponse({
        'data': {
          'meeting_points': [
            {'id': 17, 'name': 'Airport', 'time': '05:00'},
            {'id': 42, 'name': 'Station', 'time': '06:00'},
          ],
        },
      }).toEntity();
      final flow = BookingFlowContext(
        trip: trip,
        departureId: 5,
        dateRange: '',
        adultCount: 1,
        kidCount: 0,
        babyCount: 0,
        travelersCount: 1,
        rooms: const [BookingRoom(roomTypeId: 3, persons: 1)],
        currency: 'EGP',
      );
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (value) {
              context = value;
              return const SizedBox();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      var selectedFlow = flow;
      for (final point in trip.meetingPoints) {
        selectedFlow = selectedFlow.copyWith(selectedMeetingPointId: point.id);
        final review = BookingReviewDataBuilder.fromBookingFlow(
          context: context,
          flowContext: selectedFlow,
          activities: const [
            BookingActivities(
              traveler: TravelerContact(
                fullName: 'Test Traveler',
                phoneNumber: '1000000000',
                countryCode: '+20',
              ),
              activities: [],
            ),
          ],
        );
        expect(review.trip.location, point.name);
        expect(review.selectedMeetingPointId, point.id);
        await cubit.createBooking(data: review);
        expect(repository.bodies.last['meeting_point_id'], point.id);
      }
      expect(repository.bodies, hasLength(2));
      final first = Map<String, dynamic>.of(repository.bodies.first)
        ..remove('meeting_point_id');
      final last = Map<String, dynamic>.of(repository.bodies.last)
        ..remove('meeting_point_id');
      expect(last, first);
    },
  );

  test('no meeting point preserves the existing request payload', () {
    const request = CreateBookingRequest(
      departureId: 5,
      adults: 1,
      kids: 0,
      babies: 0,
      rooms: [],
      activities: [],
      travelers: [],
    );
    expect(request.toJson().containsKey('meeting_point_id'), isFalse);
  });
}

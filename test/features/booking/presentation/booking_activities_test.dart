import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/navigation/app_page_route.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/core/translation/app_localizations.dart';
import 'package:trip_marche/core/widgets/bottom_booking_bar.dart';
import 'package:trip_marche/features/booking/data/models/create_booking_request.dart';
import 'package:trip_marche/features/booking/domain/entities/activity.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_activities.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_flow_context.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_review_data.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_room.dart';
import 'package:trip_marche/features/booking/domain/entities/traveler_contact.dart';
import 'package:trip_marche/features/booking/domain/repositories/create_booking_repository.dart';
import 'package:trip_marche/features/booking/domain/usecases/create_booking_use_case.dart';
import 'package:trip_marche/features/booking/presentation/cubit/create_booking_cubit.dart';
import 'package:trip_marche/features/booking/presentation/view/review_view.dart';
import 'package:trip_marche/features/booking/presentation/view/select_activities_view.dart';
import 'package:trip_marche/features/booking/presentation/widgets/traveler_activities_section.dart';
import 'package:trip_marche/features/trip_details/data/models/trip_details_model.dart';

class _Repository implements CreateBookingRepository {
  Map<String, dynamic>? body;
  @override
  Future<Either<Failure, CreateBookingResponse>> createBooking(
    int tripId,
    CreateBookingRequest request,
  ) async {
    body = request.toJson();
    return const Right(CreateBookingResponse(success: true, message: ''));
  }
}

class _Navigator extends AppNavigator {
  late BookingReviewData review;
  @override
  Future<T?> push<T>({
    required Widget screen,
    NavAnimation animation = NavAnimation.cupertino,
  }) async {
    review = (screen as ReviewView).data;
    return null;
  }
}

void main() {
  testWidgets('UI selections, copying, and navigation preserve activity owners', (
    tester,
  ) async {
    final navigator = _Navigator();
    sl.registerSingleton<AppNavigator>(navigator);
    addTearDown(() => sl.unregister<AppNavigator>());
    final repository = _Repository();
    final cubit = CreateBookingCubit(CreateBookingUseCase(repository));
    addTearDown(cubit.close);
    final travelers = List.generate(
      3,
      (index) => TravelerContact(
        fullName: 'Traveler $index',
        phoneNumber: '1000000000',
        countryCode: '+20',
      ),
    );
    final trip = TripDetailsModel.fromApiResponse({
      'data': {
        'id': 12,
        'activities': [
          {'id': 41, 'label': 'Trip camping', 'price': 90},
          {'id': 72, 'label': 'Trip diving', 'price': 120},
        ],
      },
    }).toEntity();
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(393, 852),
        builder: (_, __) => MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SelectActivitiesView(
            travelers: travelers,
            flowContext: BookingFlowContext(
              trip: trip,
              departureId: 17,
              dateRange: '',
              adultCount: 1,
              kidCount: 1,
              babyCount: 1,
              travelersCount: 3,
              rooms: const [BookingRoom(roomTypeId: 13, persons: 3)],
              currency: 'EGP',
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    TravelerActivitiesSection section(int index) => tester
        .widgetList<TravelerActivitiesSection>(
          find.byType(TravelerActivitiesSection),
        )
        .elementAt(index);
    Future<void> toggle(int index, String id) async {
      section(index).onActivityToggled(id);
      await tester.pump();
    }

    Future<void> expectPayload(List<Map<String, int>> expected) async {
      tester
          .widget<BottomBookingBar>(find.byType(BottomBookingBar))
          .onContinue();
      await cubit.createBooking(data: navigator.review);
      expect(repository.body!['activities'], expected);
    }

    expect(section(0).activities.map((a) => a.id), ['41', '72']);
    expect(section(0).activities.first.price, 90);
    await toggle(0, '41');
    await toggle(1, '72');
    await expectPayload([
      {'traveler_index': 0, 'activity_id': 41},
      {'traveler_index': 1, 'activity_id': 72},
    ]);
    await toggle(0, '72');
    await expectPayload([
      {'traveler_index': 0, 'activity_id': 41},
      {'traveler_index': 0, 'activity_id': 72},
      {'traveler_index': 1, 'activity_id': 72},
    ]);
    section(1).onSameAsTravelerOneChanged!(true);
    await tester.pump();
    await expectPayload([
      {'traveler_index': 0, 'activity_id': 41},
      {'traveler_index': 0, 'activity_id': 72},
      {'traveler_index': 1, 'activity_id': 41},
      {'traveler_index': 1, 'activity_id': 72},
    ]);
    expect(
      identical(section(0).selectedActivityIds, section(1).selectedActivityIds),
      isFalse,
    );
    await toggle(0, '41');
    await expectPayload([
      {'traveler_index': 0, 'activity_id': 72},
      {'traveler_index': 1, 'activity_id': 72},
    ]);
    section(1).onSameAsTravelerOneChanged!(false);
    await tester.pump();
    await toggle(0, '72');
    await expectPayload([
      {'traveler_index': 1, 'activity_id': 72},
    ]);

    // Group order and missing empty groups must not determine request ownership.
    final review = navigator.review;
    BookingReviewData withSelections(List<BookingActivities> selections) =>
        BookingReviewData(
          tripId: review.tripId,
          trip: review.trip,
          travelers: review.travelers,
          room: review.room,
          selectedRooms: review.selectedRooms,
          activities: selections,
          priceBreakdown: review.priceBreakdown,
          currency: review.currency,
          departureId: review.departureId,
          adultCount: review.adultCount,
          kidCount: review.kidCount,
          babyCount: review.babyCount,
        );
    await cubit.createBooking(
      data: withSelections([
        BookingActivities(
          traveler: travelers[2],
          activities: const [Activity(id: '41', name: '', price: 90)],
        ),
        review.activities[1],
      ]),
    );
    expect(repository.body!['activities'], [
      {'traveler_index': 2, 'activity_id': 41},
      {'traveler_index': 1, 'activity_id': 72},
    ]);
    repository.body = null;
    await cubit.createBooking(
      data: withSelections(const [
        BookingActivities(
          traveler: TravelerContact(
            fullName: 'Unknown',
            phoneNumber: '',
            countryCode: '',
          ),
          activities: [Activity(id: '41', name: '', price: 90)],
        ),
      ]),
    );
    expect(cubit.state.isValidationFailure, isTrue);
    expect(repository.body, isNull);
  });
}

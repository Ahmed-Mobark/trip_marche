import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/translation/app_localizations.dart';
import 'package:trip_marche/features/booking/data/models/create_booking_request.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_optional_extra_selection.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_review_data.dart';
import 'package:trip_marche/features/booking/presentation/view/trip_options_view.dart';
import 'package:trip_marche/features/booking/presentation/widgets/optional_extra_card.dart';
import 'package:trip_marche/features/trip_details/data/models/trip_details_model.dart';

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

  test('trip details parses optional extras with API currency', () {
    final trip = TripDetailsModel.fromApiResponse({
      'data': {
        'currency': 'USD',
        'optional_extras': [
          {
            'id': 7,
            'name': 'Extra bus seat',
            'unit_price': '35.50',
            'currency': 'USD',
            'is_available': true,
          },
        ],
      },
    }).toEntity();

    expect(trip.optionalExtras, hasLength(1));
    expect(trip.optionalExtras.single.id, 7);
    expect(trip.optionalExtras.single.name, 'Extra bus seat');
    expect(trip.optionalExtras.single.unitPrice, 35.5);
    expect(trip.optionalExtras.single.currency, 'USD');
    expect(trip.optionalExtras.single.isAvailable, isTrue);
  });

  test('booking request sends only extra id and quantity', () {
    const request = CreateBookingRequest(
      departureId: 5,
      adults: 1,
      kids: 0,
      babies: 0,
      rooms: [],
      activities: [],
      optionalExtras: [
        CreateBookingOptionalExtra(extraId: 7, quantity: 2),
        CreateBookingOptionalExtra(extraId: 11, quantity: 3),
      ],
      travelers: [],
    );

    expect(request.toJson()['optional_extras'], [
      {'extra_id': 7, 'quantity': 2},
      {'extra_id': 11, 'quantity': 3},
    ]);
  });

  testWidgets('available extras appear below Baby and update quantity', (
    tester,
  ) async {
    final trip = TripDetailsModel.fromApiResponse({
      'data': {
        'currency': 'EGP',
        'departures': [
          {
            'id': 5,
            'start_date': '2026-10-16',
            'end_date': '2026-10-24',
            'price': 950,
          },
        ],
        'optional_extras': [
          {
            'id': 7,
            'name': 'Extra bus seat',
            'unit_price': 150,
            'currency': 'EGP',
            'is_available': true,
          },
        ],
      },
    }).toEntity();

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(393, 852),
        builder: (_, __) => MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: TripOptionsView(trip: trip),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final baby = find.text('Baby');
    final extra = find.text('Extra bus seat');
    expect(baby, findsOneWidget);
    expect(extra, findsOneWidget);
    expect(
      tester.getTopLeft(extra).dy,
      greaterThan(tester.getTopLeft(baby).dy),
    );

    var card = tester.widget<OptionalExtraCard>(find.byType(OptionalExtraCard));
    expect(card.quantity, 0);
    expect(card.unitPrice, 150);
    card.onIncrement();
    await tester.pump();
    card = tester.widget<OptionalExtraCard>(find.byType(OptionalExtraCard));
    expect(card.quantity, 1);
  });
}

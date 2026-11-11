import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/core/translation/app_localizations.dart';
import 'package:trip_marche/features/booking/data/models/booking_quote_model.dart';
import 'package:trip_marche/features/booking/data/models/create_booking_request.dart';
import 'package:trip_marche/features/booking/data/models/validate_coupon_request.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_flow_context.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_price_selection.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_quote.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_review_data.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_review_data_builder.dart';
import 'package:trip_marche/features/booking/domain/entities/coupon_validation.dart';
import 'package:trip_marche/features/booking/domain/repositories/coupon_repository.dart';
import 'package:trip_marche/features/booking/domain/repositories/create_booking_repository.dart';
import 'package:trip_marche/features/booking/domain/usecases/quote_booking_usecase.dart';
import 'package:trip_marche/features/booking/domain/usecases/validate_coupon_usecase.dart';
import 'package:trip_marche/features/booking/presentation/cubit/coupon_cubit.dart';
import 'package:trip_marche/features/booking/presentation/cubit/coupon_state.dart';
import 'package:trip_marche/features/booking/presentation/view/trip_options_view.dart';
import 'package:trip_marche/features/booking/presentation/widgets/date_option_card.dart';
import 'package:trip_marche/features/my_trips/data/models/booking_model.dart';
import 'package:trip_marche/features/trip_details/data/models/trip_details_model.dart';

final trip = TripDetailsModel.fromApiResponse({
  'data': {
    'id': 7,
    'title': 'Full-price trip',
    'price': 1000,
    'currency': 'EGP',
    'pricing_mode': 'options',
    'departures': [
      {
        'id': 1,
        'start_date': '2026-12-10',
        'end_date': '2026-12-12',
        'price': 1000,
        'price_options': [
          {
            'id': 11,
            'traveler_type': 'adult',
            'label': 'Person in a double room',
            'price': 1000,
          },
          {
            'id': 12,
            'traveler_type': 'adult',
            'label': 'Person in a single room',
            'price': 1500,
          },
          {
            'id': 13,
            'traveler_type': 'kid',
            'label': 'Child with bed',
            'price': 200,
          },
          {
            'id': 14,
            'traveler_type': 'baby',
            'label': 'Infant with family',
            'price': 50,
          },
        ],
      },
      {
        'id': 2,
        'start_date': '2026-12-20',
        'end_date': '2026-12-22',
        'price': 1200,
        'price_options': [
          {
            'id': 21,
            'traveler_type': 'adult',
            'label': 'Holiday double room',
            'price': 1200,
          },
        ],
      },
    ],
  },
}).toEntity();

BookingReviewData data() => const BookingReviewData(
  tripId: 7,
  trip: BookingReviewTrip(
    name: 'Trip',
    description: '',
    dateRange: '',
    duration: '',
    participantsSummary: '',
    routeLabel: '',
    routeHighlight: '',
    meetingTime: '',
    startingTime: '',
    groupSize: '',
    location: '',
    includedFeatures: [],
  ),
  travelers: [],
  room: BookingRoomSelection(name: '', price: 0),
  selectedRooms: [],
  activities: [],
  priceSelections: [
    BookingPriceSelection(
      priceOptionId: 11,
      travelerType: 'adult',
      label: 'Person in a double room',
      unitPrice: 1000,
      quantity: 1,
    ),
  ],
  priceBreakdown: BookingPriceBreakdown(
    travelersCount: 1,
    travelersTotal: 1000,
    roomLabel: '',
    roomTotal: 0,
    activitiesTotal: 0,
    taxes: 0,
  ),
  currency: 'EGP',
  departureId: 1,
  adultCount: 1,
  kidCount: 0,
  babyCount: 0,
);
BookingQuote quote({bool coupon = false}) => BookingQuoteModel.fromApiResponse({
  'success': true,
  'data': {
    'currency': 'EGP',
    'travelers': {'totalTravelers': 1},
    'price_options': [
      {
        'price_option_id': 11,
        'traveler_type': 'adult',
        'label': 'Person in a double room',
        'quantity': 1,
        'unit_price': 1000,
        'subtotal': 1000,
      },
    ],
    'payment_detail': {
      'base_amount': 1000,
      'rooms_amount': 0,
      'activities_amount': 0,
      'optional_extras_amount': 0,
      'subtotal': 1000,
      'discount_amount': coupon ? 100 : 0,
      'tax_amount': 0,
      'total_amount': coupon ? 900 : 1000,
      'total_amount_base': coupon ? 900 : 1000,
    },
    'coupon': coupon
        ? {
            'code': 'TEN',
            'type': 'percent',
            'value': 10,
            'terms': ['One condition'],
          }
        : null,
  },
});

class QuoteRepository implements CreateBookingRepository {
  final requests = <Completer<Either<Failure, BookingQuote>>>[];
  final codes = <String?>[];
  @override
  Future<Either<Failure, BookingQuote>> quoteBooking(
    BookingReviewData data, {
    String? couponCode,
  }) {
    codes.add(couponCode);
    final c = Completer<Either<Failure, BookingQuote>>();
    requests.add(c);
    return c.future;
  }

  @override
  Future<Either<Failure, CreateBookingResponse>> createBooking(
    int tripId,
    CreateBookingRequest request,
  ) => throw UnimplementedError();
}

class UnusedCoupons implements CouponRepository {
  @override
  Future<Either<Failure, CouponValidation>> validateCoupon(
    ValidateCouponRequest request,
  ) => throw StateError('The review must use the server booking quote');
}

void main() {
  Future<void> show(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, _) => MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: child,
        ),
      ),
    );
    await tester.pump();
  }

  test(
    'vendor labels and complete per-date prices parse without fixed room categories',
    () {
      expect(trip.hasCustomPricing, isTrue);
      expect(trip.departures.first.priceOptions.length, 4);
      expect(
        trip.departures.first.priceOptions[1].label,
        'Person in a single room',
      );
      expect(trip.departures.last.priceOptions.single.price, 1200);
      expect(
        TripDetailsModel.fromApiResponse({
          'data': {'id': 1},
        }).toEntity().hasCustomPricing,
        isFalse,
      );
    },
  );
  testWidgets(
    'selected prices replace base plus room surcharges in the review',
    (tester) async {
      BookingReviewData? review;
      final flow = BookingFlowContext(
        trip: trip,
        departureId: 1,
        dateRange: '10 Dec - 12 Dec',
        adultCount: 2,
        kidCount: 1,
        babyCount: 0,
        travelersCount: 3,
        rooms: const [],
        currency: 'EGP',
        priceSelections: const [
          BookingPriceSelection(
            priceOptionId: 11,
            travelerType: 'adult',
            label: 'Double',
            unitPrice: 1000,
            quantity: 1,
          ),
          BookingPriceSelection(
            priceOptionId: 12,
            travelerType: 'adult',
            label: 'Single',
            unitPrice: 1500,
            quantity: 1,
          ),
          BookingPriceSelection(
            priceOptionId: 13,
            travelerType: 'kid',
            label: 'Child',
            unitPrice: 200,
            quantity: 1,
          ),
        ],
      );
      await show(
        tester,
        Builder(
          builder: (context) {
            review = BookingReviewDataBuilder.fromBookingFlow(
              context: context,
              flowContext: flow,
              activities: const [],
            );
            return const SizedBox.shrink();
          },
        ),
      );
      expect(review!.priceBreakdown.travelersTotal, 2700);
      expect(review!.priceBreakdown.roomTotal, 0);
      expect(review!.priceSelections.length, 3);
    },
  );
  test(
    'quote and create bodies send option ids and quantities, not client prices',
    () {
      final body = BookingQuoteRequest(data(), couponCode: 'TEN').toJson();
      expect(body['price_options'], [
        {'price_option_id': 11, 'quantity': 1},
      ]);
      expect(body['coupon_code'], 'TEN');
      final request = CreateBookingRequest(
        departureId: 1,
        adults: 1,
        kids: 0,
        babies: 0,
        rooms: const [],
        activities: const [],
        travelers: const [],
        priceOptions: const [
          CreateBookingPriceOption(priceOptionId: 11, quantity: 1),
        ],
        expectedTotalAmount: 900,
      );
      expect(request.toJson()['price_options'], body['price_options']);
      expect(request.toJson()['expected_total_amount'], 900);
      expect(body.toString(), isNot(contains('unit_price')));
    },
  );
  test(
    'server quote controls totals and carries coupon terms without private fees',
    () {
      final result = quote(coupon: true);
      expect(result.breakdown.total, 900);
      expect(result.breakdown.couponDiscount, 100);
      expect(result.coupon!.terms, ['One condition']);
      final updated = data().withQuote(result);
      expect(updated.expectedTotalAmount, 900);
      expect(updated.priceBreakdown.total, 900);
      expect(updated.priceSelections.single.label, 'Person in a double room');
    },
  );
  test(
    'coupon applies by re-quoting the complete booking on the server',
    () async {
      final repo = QuoteRepository();
      final cubit = CouponCubit(
        ValidateCouponUseCase(UnusedCoupons()),
        quoteBooking: QuoteBookingUseCase(repo),
      );
      addTearDown(cubit.close);
      final first = cubit.loadBookingQuote(data());
      expect(cubit.state.isLoading, isTrue);
      repo.requests[0].complete(Right(quote()));
      await first;
      expect(cubit.state.quote!.breakdown.total, 1000);
      final applied = cubit.applyCoupon(code: 'TEN', tripId: 7, amount: 123456);
      expect(repo.codes.last, 'TEN');
      repo.requests[1].complete(Right(quote(coupon: true)));
      await applied;
      expect(cubit.state.isApplied, isTrue);
      expect(cubit.state.quote!.breakdown.total, 900);
    },
  );
  test(
    'clearing a code ignores an older response and a quote error blocks stale payment',
    () async {
      final repo = QuoteRepository();
      final cubit = CouponCubit(
        ValidateCouponUseCase(UnusedCoupons()),
        quoteBooking: QuoteBookingUseCase(repo),
      );
      addTearDown(cubit.close);
      final first = cubit.loadBookingQuote(data());
      repo.requests[0].complete(Right(quote()));
      await first;
      final applied = cubit.applyCoupon(code: 'TEN', tripId: 7, amount: 1000);
      cubit.onCodeChanged('OTHER');
      expect(repo.codes.last, isNull);
      repo.requests[1].complete(Right(quote(coupon: true)));
      await applied;
      expect(cubit.state.isLoading, isTrue);
      repo.requests[2].complete(Right(quote()));
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.isApplied, isFalse);
      expect(cubit.state.quote!.breakdown.total, 1000);
      final retry = cubit.loadBookingQuote(data());
      repo.requests[3].complete(
        const Left(ValidationFailure(message: 'Price unavailable')),
      );
      await retry;
      expect(cubit.state.quote, isNull);
      expect(cubit.state.status, CouponStatus.error);
    },
  );
  testWidgets(
    'full-price choices have independent quantities and reset for another date',
    (tester) async {
      await show(tester, TripOptionsView(trip: trip));
      final doubleCard = find.byKey(const ValueKey('trip-price-option-11'));
      expect(find.text('Person in a double room'), findsOneWidget);
      expect(find.textContaining('1000+'), findsNothing);
      await tester.ensureVisible(doubleCard);
      final plus = find.descendant(
        of: doubleCard,
        matching: find.byIcon(Iconsax.add),
      );
      await tester.tap(plus);
      await tester.tap(plus);
      await tester.pump();
      expect(
        find.descendant(of: doubleCard, matching: find.text('3')),
        findsOneWidget,
      );
      final secondDate = find.byType(DateOptionCard).at(1);
      await tester.ensureVisible(secondDate);
      await tester.tap(secondDate);
      await tester.pump();
      expect(find.text('Holiday double room'), findsOneWidget);
      expect(find.byKey(const ValueKey('trip-price-option-11')), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );
  test(
    'booked labels and prices are retained while older responses have none',
    () {
      final booking = BookingModel.fromJson({
        'price_options': [
          {
            'label': 'Booked label',
            'traveler_type': 'adult',
            'quantity': 2,
            'unit_price': 1000,
            'subtotal': 2000,
          },
        ],
      }).toEntity();
      expect(booking.priceOptions.single.label, 'Booked label');
      expect(booking.priceOptions.single.subtotal, 2000);
      expect(BookingModel.fromJson({}).toEntity().priceOptions, isEmpty);
    },
  );
}

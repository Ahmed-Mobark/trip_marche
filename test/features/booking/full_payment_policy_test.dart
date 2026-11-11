import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_marche/core/translation/app_localizations.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_flow_context.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_review_data.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_review_data_builder.dart';
import 'package:trip_marche/features/booking/presentation/widgets/payment_details_card.dart';
import 'package:trip_marche/features/trip_details/data/models/trip_details_model.dart';

void main() {
  Future<void> show(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, _) => MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: child),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('new review ignores a tax percentage from legacy trip data', (
    tester,
  ) async {
    final trip = TripDetailsModel.fromApiResponse({
      'data': {
        'id': 7,
        'title': 'Trip',
        'price': 1000,
        'tax_percent': 15,
        'deposit_amount': 100,
        'pay_on_arrival_amount': 900,
        'currency': 'EGP',
      },
    }).toEntity();
    BookingReviewData? review;
    await show(
      tester,
      Builder(
        builder: (context) {
          review = BookingReviewDataBuilder.fromBookingFlow(
            context: context,
            flowContext: BookingFlowContext(
              trip: trip,
              departureId: 0,
              dateRange: '',
              adultCount: 1,
              kidCount: 0,
              babyCount: 0,
              travelersCount: 1,
              rooms: const [],
              currency: 'EGP',
            ),
            activities: const [],
          );
          return Text(AppLocalizations.of(context)!.bookingFullPaymentEgp);
        },
      ),
    );
    expect(review!.priceBreakdown.taxes, 0);
    expect(review!.priceBreakdown.total, 1000);
    expect(
      find.textContaining('full amount is paid at booking'),
      findsOneWidget,
    );
  });

  testWidgets(
    'new tax-free breakdown hides tax row and retains discounted full total',
    (tester) async {
      await show(
        tester,
        const PaymentDetailsCard(
          title: 'Payment',
          breakdown: BookingPriceBreakdown(
            travelersCount: 1,
            travelersTotal: 1000,
            roomLabel: 'Room',
            roomTotal: 0,
            activitiesTotal: 0,
            taxes: 0,
            couponDiscount: 100,
          ),
          travelersLabel: 'Traveler',
          activitiesLabel: 'Activities',
          optionalExtrasLabel: 'Extras',
          taxesLabel: 'Taxes',
          totalLabel: 'Total',
          currencySuffix: 'EGP',
        ),
      );
      expect(find.text('Taxes'), findsNothing);
      expect(find.text('900 EGP'), findsOneWidget);
    },
  );

  testWidgets(
    'nonzero historical tax remains visible when explicitly supplied',
    (tester) async {
      await show(
        tester,
        const PaymentDetailsCard(
          title: 'Payment',
          breakdown: BookingPriceBreakdown(
            travelersCount: 1,
            travelersTotal: 1000,
            roomLabel: 'Room',
            roomTotal: 0,
            activitiesTotal: 0,
            taxes: 150,
          ),
          travelersLabel: 'Traveler',
          activitiesLabel: 'Activities',
          optionalExtrasLabel: 'Extras',
          taxesLabel: 'Taxes',
          totalLabel: 'Total',
          currencySuffix: 'EGP',
        ),
      );
      expect(find.text('Taxes'), findsOneWidget);
      expect(find.text('150 EGP'), findsOneWidget);
      expect(find.text('1150 EGP'), findsOneWidget);
    },
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/translation/app_localizations.dart';
import 'package:trip_marche/features/my_trips/data/models/booking_model.dart';
import 'package:trip_marche/features/my_trips/presentation/widgets/booking_cancellation_dialog.dart';
import 'package:trip_marche/features/my_trips/presentation/widgets/my_trips_screen_trip_card.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_state.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_tab.dart';

void main() {
  final booking = BookingModel.fromJson({
    'id': 7,
    'can_cancel': true,
    'cancellation_policy': 'Vendor cancellation terms',
    'trip': {'id': 3, 'title': 'Dahab trip'},
    'dates': {'start_date': '2026-12-10'},
  }).toEntity();

  test('cancellation fields are optional for older API responses', () {
    final old = BookingModel.fromJson({}).toEntity();
    expect(old.canCancel, isFalse);
    expect(old.cancellationPolicy, isNull);
    expect(old.cancelledAt, isNull);
    expect(booking.canCancel, isTrue);
  });

  Future<void> openDialog(
    WidgetTester tester,
    ValueChanged<bool?> onResult,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async => onResult(
                await showDialog<bool>(
                  context: context,
                  builder: (_) => BookingCancellationDialog(booking: booking),
                ),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
  }

  testWidgets(
    'popup explains the action, vendor contact and terms; keeping the booking returns false',
    (tester) async {
      bool? result;
      await openDialog(tester, (value) => result = value);
      expect(find.text('Dahab trip'), findsOneWidget);
      expect(find.text('2026-12-10'), findsOneWidget);
      expect(find.text('Vendor cancellation terms'), findsOneWidget);
      expect(find.textContaining('contact the vendor'), findsOneWidget);
      expect(
        find.textContaining('does not automatically refund'),
        findsOneWidget,
      );
      await tester.tap(find.text('Keep booking'));
      await tester.pumpAndSettle();
      expect(result, isFalse);
    },
  );

  testWidgets('cancellation only returns true after explicit confirmation', (
    tester,
  ) async {
    bool? result;
    await openDialog(tester, (value) => result = value);
    expect(result, isNull);
    await tester.tap(find.text('Confirm cancellation'));
    await tester.pumpAndSettle();
    expect(result, isTrue);
  });

  testWidgets(
    'cancelled booking keeps the refund instructions and contact action visible',
    (tester) async {
      var contactTapped = false;
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          builder: (_, child) => MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: SingleChildScrollView(
                child: MyTripsScreenTripCard(
                  trip: const MyTripRowUiModel(
                    id: 7,
                    tripId: 3,
                    title: 'Dahab',
                    rating: 0,
                    reviewCount: 0,
                    locationLabel: '',
                    dateRange: '2026-12-10',
                  ),
                  tab: MyTripsShellTab.canceled,
                  cancelledAtText: '2026-10-31 12:30',
                  onContactVendor: () => contactTapped = true,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Contact the vendor directly'),
        findsOneWidget,
      );
      expect(find.textContaining('2026-10-31 12:30'), findsOneWidget);
      await tester.ensureVisible(find.text('Contact vendor'));
      await tester.tap(find.text('Contact vendor'));
      expect(contactTapped, isTrue);
      expect(find.text('Cancel booking'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );
}

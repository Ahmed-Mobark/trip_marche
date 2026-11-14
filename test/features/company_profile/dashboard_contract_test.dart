import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_marche/core/translation/app_localizations.dart';
import 'package:trip_marche/features/booking/data/models/coupon_validation_model.dart';
import 'package:trip_marche/features/booking/presentation/widgets/coupon_field.dart';
import 'package:trip_marche/features/company_profile/data/models/vendor_profile_model.dart';
import 'package:trip_marche/features/company_profile/presentation/models/review_model.dart';
import 'package:trip_marche/features/company_profile/presentation/models/team_member_model.dart';
import 'package:trip_marche/features/company_profile/presentation/widgets/company_profile_header.dart';
import 'package:trip_marche/features/company_profile/presentation/widgets/customer_reviews_section.dart';
import 'package:trip_marche/features/company_profile/presentation/widgets/team_section.dart';
import 'package:trip_marche/features/trip_details/data/models/trip_details_model.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_details_destination_details_section.dart';
import 'package:trip_marche/features/trip_details/presentation/widgets/trip_details_transportation_section.dart';

void main() {
  Future<void> show(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, _) => MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: SingleChildScrollView(child: child)),
        ),
      ),
    );
    await tester.pump();
  }

  test('coupon terms and manager flags preserve old API compatibility', () {
    final oldCoupon = CouponValidationModel.fromApiResponse({
      'success': true,
      'data': {'code': 'OLD'},
    }).toEntity();
    final coupon = CouponValidationModel.fromApiResponse({
      'success': true,
      'data': {
        'code': 'NEW',
        'terms': ['First', 'Second'],
        'discount_amount': 10,
      },
    }).toEntity();
    expect(oldCoupon.terms, isEmpty);
    expect(coupon.terms, ['First', 'Second']);
    expect(
      TeamMemberApiModel.fromJson({
        'name': 'Manager',
        'is_manager': true,
      }).isManager,
      isTrue,
    );
    expect(TeamMemberApiModel.fromJson({'name': 'Member'}).isManager, isFalse);
    expect(
      ReviewModelApi.fromJson({'vendor_reply': 'Thank you'}).vendorReply,
      'Thank you',
    );
    final companyDetails = CompanyDetailsModel.fromJson({
      'tourism_license_url': 'https://example.test/tourism-license',
      'tourism_license_type': 'image',
    });
    expect(
      companyDetails.tourismLicenseUrl,
      'https://example.test/tourism-license',
    );
    expect(companyDetails.tourismLicenseType, 'image');
  });

  testWidgets(
    'team member dialog shows public role description and manager badge',
    (tester) async {
      await show(
        tester,
        const TeamMemberItem(
          member: TeamMemberModel(
            name: 'Mona Ali',
            role: 'Tour leader',
            avatarUrl: '',
            isManager: true,
            shortDescription: 'Ten years of travel experience',
          ),
        ),
      );

      await tester.tap(find.text('Mona Ali'));
      await tester.pumpAndSettle();

      expect(find.text('Tour leader'), findsOneWidget);
      expect(find.text('Company manager'), findsWidgets);
      expect(find.text('Ten years of travel experience'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    },
  );

  testWidgets('verification badge stays immediately after the company name', (
    tester,
  ) async {
    await show(
      tester,
      CompanyProfileHeader(
        companyName: 'TrevLen Travel',
        avatarUrl: '',
        rating: 4.8,
        reviewsCount: 12,
        isFollowing: false,
        onFollowToggle: () {},
        isVerified: true,
        showFollowButton: false,
      ),
    );

    final nameRect = tester.getRect(find.text('TrevLen Travel'));
    final badgeRect = tester.getRect(find.byIcon(Icons.check));
    expect((badgeRect.center.dy - nameRect.center.dy).abs(), lessThan(2));
    expect(badgeRect.left - nameRect.right, inInclusiveRange(0, 20));
  });

  test(
    'geographic levels and optional clocks parse without epoch defaults',
    () {
      final trip = TripDetailsModel.fromApiResponse({
        'data': {
          'primary_destination_name': 'Dahab',
          'stops': [
            {
              'city': 'Dahab',
              'administrative_area': 'South Sinai',
              'country': 'Egypt',
              'region': 'North Africa',
              'continent': 'Africa',
            },
          ],
          'destination_information': [
            {
              'destination': 'Egypt',
              'visa': 'Actual visa rules',
              'currency': 'EGP',
            },
          ],
          'transports': [
            {
              'type': 'bus',
              'travel_date': '2026-12-10',
              'depart_at': null,
              'arrive_at': null,
            },
          ],
          'flights': [
            {
              'depart_at': '2026-12-10T23:30:00Z',
              'arrive_at': '2026-12-11T02:00:00Z',
              'departure_time': '23:30',
              'arrival_time': '02:00',
              'arrival_day_offset': 1,
            },
          ],
        },
      }).toEntity();
      expect(trip.primaryDestinationName, 'Dahab');
      expect(
        trip.stops.single.description,
        'Dahab / South Sinai / Egypt / North Africa / Africa',
      );
      expect(trip.destinationInformation.single.currency, 'EGP');
      expect(trip.transports.single.departAt, isNull);
      expect(trip.transports.single.arriveAt, isNull);
      expect(trip.transports.single.travelDate, DateTime(2026, 12, 10));
      expect(trip.flights.single.departureTime, '23:30');
      expect(trip.flights.single.arrivalDayOffset, 1);
    },
  );

  testWidgets(
    'destination details display supplied information and no default claims',
    (tester) async {
      final trip = TripDetailsModel.fromApiResponse({
        'data': {
          'destination_information': [
            {
              'destination': 'Egypt',
              'visa': 'Actual visa rules',
              'currency': 'EGP',
              'notes': 'Actual instructions',
            },
          ],
        },
      }).toEntity();
      await show(tester, TripDetailsDestinationDetailsGridCard(trip: trip));
      expect(find.text('Egypt'), findsOneWidget);
      expect(find.text('Actual visa rules'), findsOneWidget);
      expect(find.text('EGP'), findsOneWidget);
      expect(find.text('Actual instructions'), findsOneWidget);
      final old = TripDetailsModel.fromApiResponse({
        'data': {'id': 1},
      }).toEntity();
      await show(tester, TripDetailsDestinationDetailsGridCard(trip: old));
      expect(find.text('Egypt'), findsNothing);
      expect(find.textContaining('Visa'), findsNothing);
    },
  );

  testWidgets('date-only transport shows a date with unspecified clocks', (
    tester,
  ) async {
    final trip = TripDetailsModel.fromApiResponse({
      'data': {
        'transports': [
          {
            'type': 'car',
            'company_name': 'Local transfer',
            'from_city': 'Airport',
            'to_city': 'Hotel',
            'travel_date': '2026-12-10',
          },
        ],
      },
    }).toEntity();
    await show(tester, TripDetailsTransportationSection(trip: trip));
    expect(find.text('Dec 10, 2026'), findsOneWidget);
    expect(find.text('—'), findsNWidgets(2));
    expect(find.textContaining('1970'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('company review reply is visible with its label', (tester) async {
    await show(
      tester,
      const ReviewCard(
        review: ReviewModel(
          name: 'Customer',
          avatarUrl: '',
          country: '',
          countryFlagUrl: '',
          rating: 5,
          comment: 'Great trip',
          galleryImages: [],
          vendorReply: 'Thank you for travelling with us',
        ),
      ),
    );
    expect(find.text('Company reply'), findsOneWidget);
    expect(find.text('Thank you for travelling with us'), findsOneWidget);
  });

  testWidgets('applied coupon displays all usage conditions', (tester) async {
    final controller = TextEditingController(text: 'SAVE');
    addTearDown(controller.dispose);
    await show(
      tester,
      CouponField(
        controller: controller,
        title: 'Coupon',
        placeholder: 'Code',
        applyLabel: 'Apply',
        appliedLabel: 'Applied',
        successMessage: 'Success',
        showSuccess: true,
        isApplied: true,
        terms: const ['First condition', 'Second condition'],
        onApply: () {},
        onChanged: (_) {},
      ),
    );
    expect(find.text('• First condition'), findsOneWidget);
    expect(find.text('• Second condition'), findsOneWidget);
  });
}

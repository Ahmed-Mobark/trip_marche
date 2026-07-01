import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_flow_context.dart';
import 'contact_info_view.dart';
import 'package:trip_marche/core/config/dimensions/trip_options_figma_tokens.dart';
import 'package:trip_marche/core/widgets/bottom_booking_bar.dart';
import '../widgets/accommodation_card.dart';
import '../widgets/date_option_card.dart';
import '../widgets/traveler_counter_card.dart';

class _TripDateOption {
  const _TripDateOption({required this.range, required this.price});

  final String range;
  final String price;
}

class TripOptionsView extends StatefulWidget {
  const TripOptionsView({super.key});

  @override
  State<TripOptionsView> createState() => _TripOptionsViewState();
}

class _TripOptionsViewState extends State<TripOptionsView> {
  static const List<_TripDateOption> _dates = [
    _TripDateOption(range: '16 May - 24 May', price: '\$950'),
    _TripDateOption(range: '20 May - 28 May', price: '\$980'),
    _TripDateOption(range: '3 Jun - 11 Jun', price: '\$850'),
    _TripDateOption(range: '8 Jun - 16 Jun', price: '\$900'),
    _TripDateOption(range: '24 Jun - 2 Jul', price: '\$920'),
    _TripDateOption(range: '30 Jun - 8 Jul', price: '\$930'),
  ];

  int _selectedDateIndex = 2;
  int _adults = 4;
  int _kids = 1;
  int _babies = 0;
  int _singlePersons = 1;
  int _doublePersons = 1;
  int _triplePersons = 3;

  int get _travelersCount => _adults + _kids + _babies;

  void _onContinue() {
    sl<AppNavigator>().push(
      screen: ContactInfoView(
        travelersCount: _travelersCount,
        flowContext: BookingFlowContext(
          dateRange: _dates[_selectedDateIndex].range,
          travelersCount: _travelersCount,
          roomName: _selectedRoomName(context),
          roomPrice: _selectedRoomPrice(),
        ),
      ),
    );
  }

  String _selectedRoomName(BuildContext context) {
    final tr = context.tr;
    if (_triplePersons > 0) {
      return tr.bookingTripleRoom;
    }
    if (_doublePersons > 0) {
      return tr.bookingDoubleRoom;
    }
    return tr.bookingSingleRoom;
  }

  double _selectedRoomPrice() {
    if (_triplePersons > 0) {
      return 480;
    }
    if (_doublePersons > 0) {
      return 0;
    }
    return 480;
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.tr;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: AppColors.white,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: TripOptionsFigmaTokens.titleTop,
                  bottom: TripOptionsFigmaTokens.titleBottom,
                ),
                child: Text(
                  tr.bookingTripOptionsTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading3(
                    color: AppColors.tripDetailsFigmaBlack,
                  ).copyWith(
                    fontSize: TripOptionsFigmaTokens.titleFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: TripOptionsFigmaTokens.screenPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _SectionTitle(tr.bookingChooseDateTitle),
                      _DateOptionsGrid(
                        dates: _dates,
                        selectedIndex: _selectedDateIndex,
                        onSelected: (index) =>
                            setState(() => _selectedDateIndex = index),
                      ),
                      SizedBox(height: TripOptionsFigmaTokens.seeAllTop),
                      Center(
                        child: GestureDetector(
                          onTap: () {},
                          behavior: HitTestBehavior.opaque,
                          child: Text(
                            tr.bookingSeeAllDates,
                            style: AppTextStyles.bodyMedium(
                              color: AppColors.primary,
                            ).copyWith(
                              fontSize: TripOptionsFigmaTokens.seeAllFontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: TripOptionsFigmaTokens.sectionBottom),
                      _SectionTitle(tr.bookingHowManyTraveling),
                      TravelerCounterCard(
                        icon: Iconsax.profile_2user,
                        title: tr.bookingTravelerAdult,
                        count: _adults,
                        min: 1,
                        onDecrement: () => setState(() => _adults--),
                        onIncrement: () => setState(() => _adults++),
                      ),
                      SizedBox(height: TripOptionsFigmaTokens.travelerCardGap),
                      TravelerCounterCard(
                        icon: Iconsax.emoji_happy,
                        title: tr.bookingTravelerKid,
                        subtitle: tr.bookingTravelerKidAge,
                        count: _kids,
                        onDecrement: () => setState(() => _kids--),
                        onIncrement: () => setState(() => _kids++),
                      ),
                      SizedBox(height: TripOptionsFigmaTokens.travelerCardGap),
                      TravelerCounterCard(
                        icon: Iconsax.milk,
                        title: tr.bookingTravelerBaby,
                        subtitle: tr.bookingTravelerBabyAge,
                        count: _babies,
                        onDecrement: () => setState(() => _babies--),
                        onIncrement: () => setState(() => _babies++),
                      ),
                      SizedBox(height: TripOptionsFigmaTokens.sectionBottom),
                      _SectionTitle(tr.bookingAccommodationOptions),
                      AccommodationCard(
                        title: tr.bookingSingleRoom,
                        subtitle: tr.bookingSingleRoomSubtitle,
                        priceLabel: '\$480+',
                        personLabel: tr.bookingPerson,
                        personCount: _singlePersons,
                        canDecrement: _singlePersons > 1,
                        canIncrement: _singlePersons < 1,
                        onDecrement: () =>
                            setState(() => _singlePersons = _singlePersons - 1),
                        onIncrement: () =>
                            setState(() => _singlePersons = _singlePersons + 1),
                      ),
                      SizedBox(height: TripOptionsFigmaTokens.travelerCardGap),
                      AccommodationCard(
                        title: tr.bookingDoubleRoom,
                        subtitle: tr.bookingDoubleRoomSubtitle,
                        priceLabel: tr.bookingFree,
                        personLabel: tr.bookingPerson,
                        personCount: _doublePersons,
                        canDecrement: false,
                        canIncrement: _doublePersons < 2,
                        onDecrement: () {},
                        onIncrement: () =>
                            setState(() => _doublePersons = _doublePersons + 1),
                      ),
                      SizedBox(height: TripOptionsFigmaTokens.travelerCardGap),
                      AccommodationCard(
                        title: tr.bookingTripleRoom,
                        subtitle: tr.bookingTripleRoomSubtitle,
                        priceLabel: '\$650+',
                        personLabel: tr.bookingPerson,
                        personCount: _triplePersons,
                        canDecrement: _triplePersons > 1,
                        canIncrement: false,
                        onDecrement: () =>
                            setState(() => _triplePersons = _triplePersons - 1),
                        onIncrement: () {},
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: BottomBookingBar(
                  onBack: () => Navigator.pop(context),
                  onContinue: _onContinue,
                  continueLabel: tr.bookingContinue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        bottom: TripOptionsFigmaTokens.sectionTitleBottom,
      ),
      child: Text(
        label,
        style: AppTextStyles.subtitle(
          color: AppColors.tripDetailsFigmaBlack,
        ).copyWith(
          fontSize: TripOptionsFigmaTokens.sectionTitleFontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _DateOptionsGrid extends StatelessWidget {
  const _DateOptionsGrid({
    required this.dates,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<_TripDateOption> dates;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - TripOptionsFigmaTokens.gridHGap) / 2;
        return Wrap(
          spacing: TripOptionsFigmaTokens.gridHGap,
          runSpacing: TripOptionsFigmaTokens.gridVGap,
          children: [
            for (var i = 0; i < dates.length; i++)
              SizedBox(
                width: itemWidth,
                child: DateOptionCard(
                  dateRange: dates[i].range,
                  price: dates[i].price,
                  isSelected: selectedIndex == i,
                  onTap: () => onSelected(i),
                ),
              ),
          ],
        );
      },
    );
  }
}

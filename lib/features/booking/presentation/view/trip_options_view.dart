import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/toast/app_toast.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_flow_context.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_room.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'package:trip_marche/features/trip_details/presentation/trip_details_ui_formatters.dart';
import 'contact_info_view.dart';
import 'package:trip_marche/core/config/dimensions/trip_options_figma_tokens.dart';
import 'package:trip_marche/core/widgets/bottom_booking_bar.dart';
import '../widgets/accommodation_card.dart';
import '../widgets/date_option_card.dart';
import '../widgets/traveler_counter_card.dart';

class _TripDateOption {
  const _TripDateOption({
    required this.id,
    required this.range,
    required this.price,
  });

  final int id;
  final String range;
  final String price;
}

class TripOptionsView extends StatefulWidget {
  const TripOptionsView({required this.trip, super.key});

  final TripDetails trip;

  @override
  State<TripOptionsView> createState() => _TripOptionsViewState();
}

class _TripOptionsViewState extends State<TripOptionsView> {
  static const int _initialVisibleDates = 4;

  late final List<TripRoomType> _roomTypes;
  late final Map<String, int> _roomPersonCounts;

  int _selectedDateIndex = 0;
  bool _datesExpanded = false;
  int _adults = 1;
  int _kids = 0;
  int _babies = 0;

  int get _travelersCount => _adults + _kids + _babies;

  @override
  void initState() {
    super.initState();
    _roomTypes = List<TripRoomType>.of(widget.trip.roomTypes)
      ..sort((a, b) => a.capacity.compareTo(b.capacity));
    _roomPersonCounts = {
      for (final room in _roomTypes)
        room.key: _initialRoomPersonCount(room),
    };
  }

  int _initialRoomPersonCount(TripRoomType room) {
    if (room.capacity >= 3) {
      return room.capacity;
    }
    return 1;
  }

  List<_TripDateOption> _buildDateOptions(BuildContext context) {
    return widget.trip.departures
        .map(
          (departure) => _TripDateOption(
            id: departure.id,
            range: TripDetailsUiFormatters.departureDateRange(
              context,
              departure.startDate,
              departure.endDate,
            ),
            price: TripDetailsUiFormatters.formatAmount(
              departure.price,
              currency: widget.trip.currency,
            ),
          ),
        )
        .where((option) => option.range.isNotEmpty)
        .toList(growable: false);
  }

  void _onContinue() {
    final dateOptions = _buildDateOptions(context);
    if (dateOptions.isEmpty) {
      return;
    }

    final selectedDateIndex =
        _selectedDateIndex.clamp(0, dateOptions.length - 1);

    final selectedRooms = _selectedRooms();
    if (selectedRooms.isEmpty) {
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.bookingRoomsRequired,
      );
      return;
    }

    final totalRoomOccupants = selectedRooms.fold<int>(
      0,
      (sum, room) => sum + room.persons,
    );
    if (totalRoomOccupants != _travelersCount) {
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.bookingRoomOccupantsMismatch(_travelersCount),
      );
      return;
    }

    final selectedDate = dateOptions[selectedDateIndex];

    sl<AppNavigator>().push(
      screen: ContactInfoView(
        travelersCount: _travelersCount,
        flowContext: BookingFlowContext(
          trip: widget.trip,
          departureId: selectedDate.id,
          dateRange: selectedDate.range,
          adultCount: _adults,
          kidCount: _kids,
          babyCount: _babies,
          travelersCount: _travelersCount,
          rooms: selectedRooms,
          currency: widget.trip.currency,
        ),
      ),
    );
  }

  List<BookingRoom> _selectedRooms() {
    if (_roomTypes.isEmpty) {
      return const <BookingRoom>[];
    }

    final result = <BookingRoom>[];
    for (final room in _roomTypes) {
      final count = _roomPersonCounts[room.key];
      if (count != null && count > 0) {
        result.add(BookingRoom(roomTypeId: room.id, persons: count));
      }
    }
    return result;
  }

  String _roomPriceLabel(BuildContext context, TripRoomType room) {
    final tr = context.tr;
    if (room.price <= 0) {
      return tr.bookingFree;
    }
    return '${TripDetailsUiFormatters.formatAmount(room.price, currency: widget.trip.currency)}+';
  }

  bool _canDecrementRoom(TripRoomType room, int count) {
    return count > 0;
  }

  bool _canIncrementRoom(TripRoomType room, int count) {
    return count < room.capacity;
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.tr;
    final dateOptions = _buildDateOptions(context);
    final selectedDateIndex = dateOptions.isEmpty
        ? 0
        : _selectedDateIndex.clamp(0, dateOptions.length - 1);
    final showDatesToggle = dateOptions.length > _initialVisibleDates;
    final visibleDates = showDatesToggle && !_datesExpanded
        ? dateOptions.sublist(0, _initialVisibleDates)
        : dateOptions;

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
                      if (dateOptions.isNotEmpty) ...[
                        _SectionTitle(tr.bookingChooseDateTitle),
                        _DateOptionsGrid(
                          dates: visibleDates,
                          selectedIndex: selectedDateIndex,
                          onSelected: (index) =>
                              setState(() => _selectedDateIndex = index),
                        ),
                        if (showDatesToggle) ...[
                          SizedBox(height: TripOptionsFigmaTokens.seeAllTop),
                          Center(
                            child: GestureDetector(
                              onTap: () => setState(
                                () => _datesExpanded = !_datesExpanded,
                              ),
                              behavior: HitTestBehavior.opaque,
                              child: Text(
                                _datesExpanded
                                    ? tr.bookingShowLessDates
                                    : tr.bookingSeeAllDates,
                                style: AppTextStyles.bodyMedium(
                                  color: AppColors.primary,
                                ).copyWith(
                                  fontSize:
                                      TripOptionsFigmaTokens.seeAllFontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                        SizedBox(height: TripOptionsFigmaTokens.sectionBottom),
                      ],
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
                      if (_roomTypes.isNotEmpty) ...[
                        SizedBox(height: TripOptionsFigmaTokens.sectionBottom),
                        _SectionTitle(tr.bookingAccommodationOptions),
                        for (var i = 0; i < _roomTypes.length; i++) ...[
                          if (i > 0)
                            SizedBox(
                              height: TripOptionsFigmaTokens.travelerCardGap,
                            ),
                          _buildAccommodationCard(context, _roomTypes[i]),
                        ],
                      ],
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

  Widget _buildAccommodationCard(BuildContext context, TripRoomType room) {
    final count = _roomPersonCounts[room.key] ?? 1;

    return AccommodationCard(
      title: room.name,
      subtitle: room.description,
      priceLabel: _roomPriceLabel(context, room),
      personLabel: context.tr.bookingPerson,
      personCount: count,
      canDecrement: _canDecrementRoom(room, count),
      canIncrement: _canIncrementRoom(room, count),
      onDecrement: () => setState(() {
        _roomPersonCounts[room.key] = count - 1;
      }),
      onIncrement: () => setState(() {
        _roomPersonCounts[room.key] = count + 1;
      }),
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

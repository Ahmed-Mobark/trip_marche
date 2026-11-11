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
import 'package:trip_marche/features/booking/domain/entities/booking_price_selection.dart';
import 'package:trip_marche/features/booking/domain/entities/booking_optional_extra_selection.dart';
import 'package:trip_marche/features/trip_details/domain/entities/trip_details_entity.dart';
import 'package:trip_marche/features/trip_details/presentation/trip_details_ui_formatters.dart';
import 'contact_info_view.dart';
import 'package:trip_marche/core/config/dimensions/trip_options_figma_tokens.dart';
import 'package:trip_marche/core/widgets/bottom_booking_bar.dart';
import '../widgets/accommodation_card.dart';
import '../widgets/date_option_card.dart';
import '../widgets/traveler_counter_card.dart';
import '../widgets/optional_extra_card.dart';

class _TripDateOption {
  const _TripDateOption({
    required this.id,
    required this.range,
    required this.price,
    this.seatsLeft = 0,
    this.isFull = false,
  });

  final int id;
  final String range;
  final String price;
  final int seatsLeft;
  final bool isFull;
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
  late final Map<int, int> _extraQuantities;

  final Map<int, int> _priceQuantities = {};
  int _selectedDateIndex = 0;
  bool _datesExpanded = false;
  int _adults = 1;
  int _kids = 0;
  int _babies = 0;

  int get _travelersCount => _adults + _kids + _babies;

  @override
  void initState() {
    super.initState();
    final firstAvailable = widget.trip.departures.indexWhere((d) => !d.isFull);
    if (firstAvailable >= 0) {
      _selectedDateIndex = firstAvailable;
    }
    _roomTypes = List<TripRoomType>.of(widget.trip.roomTypes)
      ..sort((a, b) => a.capacity.compareTo(b.capacity));
    _roomPersonCounts = {
      for (final room in _roomTypes) room.key: _initialRoomPersonCount(room),
    };
    if (widget.trip.hasCustomPricing) _resetPriceSelections();
    _extraQuantities = {
      for (final extra in widget.trip.optionalExtras.where(
        (extra) => extra.isAvailable,
      ))
        extra.id: 0,
    };
  }

  List<TripPriceOption> get _activePriceOptions =>
      widget.trip.departures.isEmpty
      ? const []
      : widget
            .trip
            .departures[_selectedDateIndex.clamp(
              0,
              widget.trip.departures.length - 1,
            )]
            .priceOptions;

  void _resetPriceSelections() {
    _priceQuantities.clear();
    final adult = _activePriceOptions
        .where((option) => option.travelerType == 'adult')
        .firstOrNull;
    if (adult != null) _priceQuantities[adult.id] = 1;
    _updatePriceCounts();
  }

  void _updatePriceCounts() {
    int count(String type) => _activePriceOptions
        .where((option) => option.travelerType == type)
        .fold<int>(
          0,
          (sum, option) => sum + (_priceQuantities[option.id] ?? 0),
        );
    _adults = count('adult');
    _kids = count('kid');
    _babies = count('baby');
  }

  List<BookingPriceSelection> _selectedPriceOptions() => _activePriceOptions
      .where((option) => (_priceQuantities[option.id] ?? 0) > 0)
      .map(
        (option) => BookingPriceSelection(
          priceOptionId: option.id,
          travelerType: option.travelerType,
          label: option.label,
          unitPrice: option.price,
          quantity: _priceQuantities[option.id]!,
        ),
      )
      .toList();

  void _selectDate(int index) {
    final departures = widget.trip.departures;
    if (index >= 0 && index < departures.length && departures[index].isFull) {
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.bookingDepartureSoldOut,
      );
      return;
    }
    setState(() {
      _selectedDateIndex = index;
      if (widget.trip.hasCustomPricing) _resetPriceSelections();
    });
  }

  int _initialRoomPersonCount(TripRoomType room) {
    return 0;
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
            seatsLeft: departure.seatsLeft,
            isFull: departure.isFull,
          ),
        )
        .where((option) => option.range.isNotEmpty)
        .toList(growable: false);
  }

  void _onContinue() {
    final dateOptions = _buildDateOptions(context);
    final selectedRooms = _selectedRooms();
    final totalTravelers = _travelersCount;
    final totalRoomOccupants = selectedRooms.fold<int>(
      0,
      (sum, room) => sum + room.persons,
    );

    debugPrint('=== TRIP OPTIONS CONTINUE ===');
    debugPrint('Adults: $_adults');
    debugPrint('Kids: $_kids');
    debugPrint('Babies: $_babies');
    debugPrint('Total travelers: $totalTravelers');
    debugPrint('Total room occupants: $totalRoomOccupants');
    debugPrint(
      'Validation result: ${selectedRooms.isNotEmpty && totalRoomOccupants == totalTravelers}',
    );
    debugPrint('=============================');

    if (dateOptions.isEmpty) {
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.bookingTripUnavailableTitle,
      );
      return;
    }

    if (!widget.trip.hasCustomPricing && selectedRooms.isEmpty) {
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.bookingRoomsRequired,
      );
      return;
    }

    if (!widget.trip.hasCustomPricing && totalRoomOccupants != totalTravelers) {
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.bookingRoomOccupantsMismatch(totalTravelers),
      );
      return;
    }

    if (widget.trip.hasCustomPricing &&
        (_adults < 1 || _selectedPriceOptions().isEmpty)) {
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.bookingSelectPriceOption,
      );
      return;
    }

    final selectedDateIndex = _selectedDateIndex.clamp(
      0,
      dateOptions.length - 1,
    );

    final selectedDate = dateOptions[selectedDateIndex];

    final selectedDeparture = widget.trip.departures.firstWhere(
      (d) => d.id == selectedDate.id,
      orElse: () => widget.trip.departures[selectedDateIndex],
    );

    if (selectedDeparture.isFull) {
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.bookingDepartureSoldOut,
      );
      return;
    }

    if (selectedDeparture.seatsLeft < totalTravelers) {
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.bookingSeatsInsufficient(selectedDeparture.seatsLeft),
      );
      return;
    }

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
          priceSelections: widget.trip.hasCustomPricing
              ? _selectedPriceOptions()
              : const [],
          currency: widget.trip.currency,
          optionalExtras: _selectedOptionalExtras(),
        ),
      ),
    );
  }

  List<BookingOptionalExtraSelection> _selectedOptionalExtras() {
    final languageCode = Localizations.localeOf(context).languageCode;

    return widget.trip.optionalExtras
        .where((extra) => extra.isAvailable)
        .map(
          (extra) => BookingOptionalExtraSelection(
            extraId: extra.id,
            name: extra.nameForLanguage(languageCode),
            unitPrice: extra.unitPrice,
            currency: extra.currency,
            quantity: _extraQuantities[extra.id] ?? 0,
          ),
        )
        .where((extra) => extra.quantity > 0)
        .toList(growable: false);
  }

  List<BookingRoom> _selectedRooms() {
    if (widget.trip.hasCustomPricing || _roomTypes.isEmpty) {
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
    final languageCode = Localizations.localeOf(context).languageCode;

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
                  style:
                      AppTextStyles.heading3(
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
                          onSelected: _selectDate,
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
                                style:
                                    AppTextStyles.bodyMedium(
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
                      if (widget.trip.hasCustomPricing) ...[
                        Text(
                          tr.bookingCustomPriceHelp,
                          style: AppTextStyles.bodySmall(
                            color: AppColors.secondaryText(context),
                          ),
                        ),
                        for (final type in ['adult', 'kid', 'baby']) ...[
                          if (_activePriceOptions.any(
                            (option) => option.travelerType == type,
                          )) ...[
                            SizedBox(height: 12.h),
                            _SectionTitle(
                              type == 'adult'
                                  ? tr.bookingTravelerAdult
                                  : type == 'kid'
                                  ? tr.bookingTravelerKid
                                  : tr.bookingTravelerBaby,
                            ),
                            for (final option in _activePriceOptions.where(
                              (option) => option.travelerType == type,
                            ))
                              Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: _buildPriceOption(context, option),
                              ),
                          ],
                        ],
                      ] else ...[
                        _SectionTitle(tr.bookingHowManyTraveling),
                        TravelerCounterCard(
                          icon: Iconsax.profile_2user,
                          title: tr.bookingTravelerAdult,
                          count: _adults,
                          min: 1,
                          onDecrement: () => setState(() => _adults--),
                          onIncrement: () => setState(() => _adults++),
                        ),
                        SizedBox(
                          height: TripOptionsFigmaTokens.travelerCardGap,
                        ),
                        TravelerCounterCard(
                          icon: Iconsax.emoji_happy,
                          title: tr.bookingTravelerKid,
                          subtitle: tr.bookingTravelerKidAge,
                          count: _kids,
                          onDecrement: () => setState(() => _kids--),
                          onIncrement: () => setState(() => _kids++),
                        ),
                        SizedBox(
                          height: TripOptionsFigmaTokens.travelerCardGap,
                        ),
                        TravelerCounterCard(
                          icon: Iconsax.milk,
                          title: tr.bookingTravelerBaby,
                          subtitle: tr.bookingTravelerBabyAge,
                          count: _babies,
                          onDecrement: () => setState(() => _babies--),
                          onIncrement: () => setState(() => _babies++),
                        ),
                      ],
                      if (_extraQuantities.isNotEmpty) ...[
                        SizedBox(height: TripOptionsFigmaTokens.sectionBottom),
                        _SectionTitle(tr.bookingOptionalExtras),
                        for (final extra in widget.trip.optionalExtras.where(
                          (extra) => extra.isAvailable,
                        )) ...[
                          if (extra !=
                              widget.trip.optionalExtras
                                  .where((item) => item.isAvailable)
                                  .first)
                            SizedBox(
                              height: TripOptionsFigmaTokens.travelerCardGap,
                            ),
                          OptionalExtraCard(
                            name: extra.nameForLanguage(languageCode),
                            unitPrice: extra.unitPrice,
                            currency: extra.currency,
                            quantity: _extraQuantities[extra.id] ?? 0,
                            onDecrement: () => setState(() {
                              final quantity = _extraQuantities[extra.id] ?? 0;
                              _extraQuantities[extra.id] = quantity > 0
                                  ? quantity - 1
                                  : 0;
                            }),
                            onIncrement: () => setState(() {
                              _extraQuantities[extra.id] =
                                  (_extraQuantities[extra.id] ?? 0) + 1;
                            }),
                          ),
                        ],
                      ],
                      if (!widget.trip.hasCustomPricing &&
                          _roomTypes.isNotEmpty) ...[
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

  void _changePriceQuantity(TripPriceOption option, int delta) {
    final count = _priceQuantities[option.id] ?? 0;
    final total = _activePriceOptions
        .where((item) => item.travelerType == option.travelerType)
        .fold<int>(0, (sum, item) => sum + (_priceQuantities[item.id] ?? 0));
    if ((delta > 0 && total >= 50) || (delta < 0 && count <= 0)) return;
    setState(() {
      _priceQuantities[option.id] = count + delta;
      _updatePriceCounts();
    });
  }

  Widget _buildPriceOption(BuildContext context, TripPriceOption option) {
    final count = _priceQuantities[option.id] ?? 0;
    final totalOfType = _activePriceOptions
        .where((item) => item.travelerType == option.travelerType)
        .fold<int>(0, (sum, item) => sum + (_priceQuantities[item.id] ?? 0));
    return AccommodationCard(
      key: ValueKey('trip-price-option-${option.id}'),
      title: option.label,
      subtitle: '',
      priceLabel: TripDetailsUiFormatters.formatAmount(
        option.price,
        currency: widget.trip.currency,
      ),
      personLabel: context.tr.bookingPerson,
      personCount: count,
      canDecrement: count > 0,
      canIncrement: totalOfType < 50,
      onDecrement: () => _changePriceQuantity(option, -1),
      onIncrement: () => _changePriceQuantity(option, 1),
    );
  }

  Widget _buildAccommodationCard(BuildContext context, TripRoomType room) {
    final count = _roomPersonCounts[room.key] ?? 1;

    return AccommodationCard(
      title: room.name.replaceAll(
        RegExp(r'\btreble\b', caseSensitive: false),
        'Triple',
      ),
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
        style: AppTextStyles.subtitle(color: AppColors.tripDetailsFigmaBlack)
            .copyWith(
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
                  isFull: dates[i].isFull,
                  soldOutText: context.tr.tripDetailsSoldOut,
                  onTap: () => onSelected(i),
                ),
              ),
          ],
        );
      },
    );
  }
}

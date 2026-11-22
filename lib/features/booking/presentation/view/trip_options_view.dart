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
import 'package:trip_marche/features/booking/domain/entities/booking_occupancy_selection.dart';
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
  final Map<String, int> _occupancyQuantities = {
    'single': 1,
    'double': 0,
    'triple': 0,
    'quadruple': 0,
    'quintuple': 0,
  };
  int _childrenWithoutBed = 0;
  int _childrenWithBed = 0;
  int _selectedDateIndex = 0;
  int? _selectedAccommodationId;
  bool _datesExpanded = false;
  int _adults = 1;
  int _kids = 0;
  int _babies = 0;

  int get _travelersCount => _adults + _kids + _babies;
  TripDeparture? get _activeDeparture => widget.trip.departures.isEmpty
      ? null
      : widget.trip.departures[_selectedDateIndex.clamp(
          0,
          widget.trip.departures.length - 1,
        )];
  bool get _hasDepartureMatrix =>
      _activeDeparture != null &&
      (_activeDeparture!.pricingMethod == 'unified' ||
          _activeDeparture!.pricingMethod == 'hotel');
  bool get _usingOptionPricing =>
      widget.trip.hasCustomPricing && !_hasDepartureMatrix;
  List<TripOptionalExtra> get _activeExtras => widget.trip.optionalExtras
      .where(
        (extra) =>
            extra.isAvailable &&
            (extra.departureId == null ||
                extra.departureId == _activeDeparture?.id),
      )
      .toList(growable: false);

  @override
  void initState() {
    super.initState();
    final firstAvailable = widget.trip.departures.indexWhere((d) => !d.isFull);
    if (firstAvailable >= 0) {
      _selectedDateIndex = firstAvailable;
    }
    if (widget.trip.accommodations.length == 1) {
      _selectedAccommodationId = widget.trip.accommodations.single.id;
    }
    _roomTypes = List<TripRoomType>.of(widget.trip.roomTypes)
      ..sort((a, b) => a.capacity.compareTo(b.capacity));
    _roomPersonCounts = {
      for (final room in _roomTypes) room.key: _initialRoomPersonCount(room),
    };
    if (_usingOptionPricing) _resetPriceSelections();
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
      if (_usingOptionPricing) _resetPriceSelections();
      _extraQuantities.updateAll((_, __) => 0);
      _childrenWithoutBed = 0;
      _childrenWithBed = 0;
      if (_hasDepartureMatrix) _resetOccupancies();
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

    if (!widget.trip.hasCustomPricing &&
        !_hasDepartureMatrix &&
        selectedRooms.isEmpty) {
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.bookingRoomsRequired,
      );
      return;
    }

    if (!widget.trip.hasCustomPricing &&
        !_hasDepartureMatrix &&
        totalRoomOccupants != totalTravelers) {
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.bookingRoomOccupantsMismatch(totalTravelers),
      );
      return;
    }

    if (_usingOptionPricing &&
        (_adults < 1 || _selectedPriceOptions().isEmpty)) {
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.bookingSelectPriceOption,
      );
      return;
    }

    if (_hasDepartureMatrix &&
        (_adults < 1 ||
            _adultOccupancyTotal != _adults ||
            _childrenWithoutBed + _childrenWithBed != _kids)) {
      appToast(
        context: context,
        type: ToastType.error,
        message: Localizations.localeOf(context).languageCode == 'ar'
            ? 'وزّع البالغين والأطفال على فئات الأسعار قبل المتابعة.'
            : 'Assign adults and children to the displayed price categories before continuing.',
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
        message: context.tr.bookingSeatsInsufficient(
          selectedDeparture.seatsLeft,
        ),
      );
      return;
    }

    if (widget.trip.accommodations.length > 1 &&
        _selectedAccommodationId == null) {
      appToast(
        context: context,
        type: ToastType.error,
        message: context.tr.bookingHotelSelectionRequired,
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
          priceSelections: _usingOptionPricing
              ? _selectedPriceOptions()
              : const [],
          currency: widget.trip.currency,
          selectedAccommodationId: _selectedAccommodationId,
          optionalExtras: _selectedOptionalExtras(),
          occupancies: _hasDepartureMatrix ? _selectedOccupancies() : const [],
          childrenWithoutBed: _childrenWithoutBed,
          childrenWithBed: _childrenWithBed,
        ),
      ),
    );
  }

  List<BookingOptionalExtraSelection> _selectedOptionalExtras() {
    final languageCode = Localizations.localeOf(context).languageCode;

    return widget.trip.optionalExtras
        .where(
          (extra) =>
              extra.isAvailable &&
              (extra.departureId == null ||
                  extra.departureId == _activeDeparture?.id),
        )
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

  Widget _buildTripHotelChoice(BuildContext context, TripAccommodation hotel) {
    final selected = hotel.id != null && hotel.id == _selectedAccommodationId;
    return InkWell(
      onTap: hotel.id == null
          ? null
          : () => setState(() {
              _selectedAccommodationId = hotel.id;
              if (_usingOptionPricing) {
                _resetPriceSelections();
              }
              if (_hasDepartureMatrix) _resetOccupancies();
            }),
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: .06)
              : AppColors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border(context),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            if (hotel.images.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.network(
                  hotel.images.first,
                  width: 76.w,
                  height: 70.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _hotelImagePlaceholder(context),
                ),
              )
            else
              _hotelImagePlaceholder(context),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.name,
                    style: AppTextStyles.bodyMedium(
                      color: AppColors.tripDetailsFigmaBlack,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                  if (hotel.accommodationType.isNotEmpty) ...[
                    SizedBox(height: 3.h),
                    Text(
                      hotel.accommodationType,
                      style: AppTextStyles.bodySmall(
                        color: AppColors.secondaryText(context),
                      ),
                    ),
                  ],
                  if (hotel.city.isNotEmpty || hotel.country.isNotEmpty) ...[
                    SizedBox(height: 3.h),
                    Text(
                      [
                        hotel.city,
                        hotel.country,
                      ].where((value) => value.isNotEmpty).join(' · '),
                      style: AppTextStyles.bodySmall(
                        color: AppColors.secondaryText(context),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (widget.trip.accommodations.length > 1)
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: selected
                    ? AppColors.primary
                    : AppColors.secondaryText(context),
              ),
          ],
        ),
      ),
    );
  }

  Widget _hotelImagePlaceholder(BuildContext context) => Container(
    width: 76.w,
    height: 70.h,
    decoration: BoxDecoration(
      color: AppColors.border(context).withValues(alpha: .35),
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: Icon(Iconsax.building, color: AppColors.secondaryText(context)),
  );

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
                      if (widget.trip.accommodations.isNotEmpty) ...[
                        if (widget.trip.accommodations.length > 1)
                          _SectionTitle(tr.bookingChooseHotel),
                        for (
                          var i = 0;
                          i < widget.trip.accommodations.length;
                          i++
                        ) ...[
                          if (i > 0)
                            SizedBox(
                              height: TripOptionsFigmaTokens.travelerCardGap,
                            ),
                          _buildTripHotelChoice(
                            context,
                            widget.trip.accommodations[i],
                          ),
                        ],
                        SizedBox(height: TripOptionsFigmaTokens.sectionBottom),
                      ],
                      if (_hasDepartureMatrix) ...[
                        _SectionTitle(_localized('أسعار الغرف', 'Room prices')),
                        for (final category in const [
                          'single',
                          'double',
                          'triple',
                          'quadruple',
                          'quintuple',
                        ])
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: _buildOccupancyCard(context, category),
                          ),
                        SizedBox(height: 8.h),
                        _SectionTitle(
                          _localized(
                            'أسعار الأطفال والرضع',
                            'Children & infant prices',
                          ),
                        ),
                        TravelerCounterCard(
                          icon: Iconsax.emoji_happy,
                          title: _localized(
                            'طفل بدون سرير',
                            'Child without bed',
                          ),
                          subtitle: _localized(
                            'من سنتين إلى أقل من 12 سنة',
                            'Age 2 to under 12',
                          ),
                          count: _childrenWithoutBed,
                          onDecrement: () => setState(() {
                            if (_childrenWithoutBed > 0) {
                              _childrenWithoutBed--;
                              _kids--;
                            }
                          }),
                          onIncrement: () => setState(() {
                            if (_kids < 50) {
                              _childrenWithoutBed++;
                              _kids++;
                            }
                          }),
                        ),
                        _matrixCategoryPriceLabel('child_without_bed'),
                        SizedBox(
                          height: TripOptionsFigmaTokens.travelerCardGap,
                        ),
                        TravelerCounterCard(
                          icon: Iconsax.profile_2user,
                          title: _localized(
                            'طفل بسرير إضافي',
                            'Child with extra bed',
                          ),
                          subtitle: _localized(
                            'من سنتين إلى أقل من 12 سنة',
                            'Age 2 to under 12',
                          ),
                          count: _childrenWithBed,
                          onDecrement: () => setState(() {
                            if (_childrenWithBed > 0) {
                              _childrenWithBed--;
                              _kids--;
                            }
                          }),
                          onIncrement: () => setState(() {
                            if (_kids < 50) {
                              _childrenWithBed++;
                              _kids++;
                            }
                          }),
                        ),
                        _matrixCategoryPriceLabel('child_with_bed'),
                        SizedBox(
                          height: TripOptionsFigmaTokens.travelerCardGap,
                        ),
                        TravelerCounterCard(
                          icon: Iconsax.milk,
                          title: context.tr.bookingTravelerBaby,
                          subtitle: context.tr.bookingTravelerBabyAge,
                          count: _babies,
                          onDecrement: () => setState(() {
                            if (_babies > 0) _babies--;
                          }),
                          onIncrement: () => setState(() {
                            if (_babies < 50) _babies++;
                          }),
                        ),
                        _matrixCategoryPriceLabel('infant'),
                      ] else if (_usingOptionPricing) ...[
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
                      if (_activeExtras.isNotEmpty) ...[
                        SizedBox(height: TripOptionsFigmaTokens.sectionBottom),
                        _SectionTitle(tr.bookingOptionalExtras),
                        for (final extra in _activeExtras) ...[
                          if (extra != _activeExtras.first)
                            SizedBox(
                              height: TripOptionsFigmaTokens.travelerCardGap,
                            ),
                          OptionalExtraCard(
                            name: extra.nameForLanguage(languageCode),
                            unitPrice: extra.unitPrice,
                            pricingUnit: _pricingUnitLabel(extra.pricingUnit),
                            currency: extra.currency,
                            quantity: _extraQuantities[extra.id] ?? 0,
                            onDecrement: () => setState(() {
                              final quantity = _extraQuantities[extra.id] ?? 0;
                              _extraQuantities[extra.id] = quantity > 0
                                  ? quantity - 1
                                  : 0;
                            }),
                            onIncrement: () => setState(() {
                              final maximum = extra.maximumQuantity;
                              if (maximum == null ||
                                  (_extraQuantities[extra.id] ?? 0) < maximum) {
                                _extraQuantities[extra.id] =
                                    (_extraQuantities[extra.id] ?? 0) + 1;
                              }
                            }),
                          ),
                        ],
                      ],
                      if (!_usingOptionPricing &&
                          !_hasDepartureMatrix &&
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

  int get _adultOccupancyTotal =>
      _occupancyQuantities.values.fold<int>(0, (sum, count) => sum + count);

  void _resetOccupancies() {
    for (final key in _occupancyQuantities.keys.toList()) {
      _occupancyQuantities[key] = 0;
    }
    if (_adults > 0) _occupancyQuantities['single'] = _adults;
  }

  List<BookingOccupancySelection> _selectedOccupancies() => _occupancyQuantities
      .entries
      .where((entry) => entry.value > 0)
      .map(
        (entry) => BookingOccupancySelection(
          category: entry.key,
          travelers: entry.value,
        ),
      )
      .toList(growable: false);

  String _localized(String ar, String en) =>
      Localizations.localeOf(context).languageCode == 'ar' ? ar : en;

  String _pricingUnitLabel(String key) => switch (key) {
    'per_person' => _localized('للفرد', 'per person'),
    'per_night' => _localized('لليلة', 'per night'),
    'per_seat' => _localized('للمقعد', 'per seat'),
    'per_unit' => _localized('للوحدة', 'per unit'),
    _ => '',
  };

  double _matrixPrice(String category) {
    final departure = _activeDeparture;
    if (departure == null) return 0;
    final scope = departure.pricingMethod;
    return departure.hotelPrices
            .where(
              (price) =>
                  price.scope == scope &&
                  (scope == 'unified' ||
                      price.accommodationId == _selectedAccommodationId) &&
                  price.category == category,
            )
            .firstOrNull
            ?.amount ??
        0;
  }

  Widget _matrixCategoryPriceLabel(String category) => Padding(
    padding: EdgeInsetsDirectional.only(start: 12.w, top: 4.h),
    child: Text(
      '${_localized('السعر', 'Price')}: ${TripDetailsUiFormatters.formatAmount(_matrixPrice(category), currency: widget.trip.currency)}',
      style: AppTextStyles.bodySmall(color: AppColors.secondaryText(context)),
    ),
  );

  Widget _buildOccupancyCard(BuildContext context, String category) {
    final names = {
      'single': _localized('غرفة مفردة', 'Single room'),
      'double': _localized('غرفة مزدوجة', 'Double room'),
      'triple': _localized('غرفة ثلاثية', 'Triple room'),
      'quadruple': _localized('غرفة رباعية', 'Quadruple room'),
      'quintuple': _localized('غرفة خماسية', 'Quintuple room'),
    };
    final count = _occupancyQuantities[category] ?? 0;
    final total = _adultOccupancyTotal;
    final price = _matrixPrice(category);
    return AccommodationCard(
      key: ValueKey('departure-price-$category'),
      title: names[category]!,
      subtitle: '',
      priceLabel: TripDetailsUiFormatters.formatAmount(
        price,
        currency: widget.trip.currency,
      ),
      personLabel: context.tr.bookingPerson,
      personCount: count,
      canDecrement: count > 0 && _adults > 1,
      canIncrement: _adults < 50 && total < 50,
      onDecrement: () => setState(() {
        if (count > 0 && _adults > 1) {
          _occupancyQuantities[category] = count - 1;
          _adults--;
        }
      }),
      onIncrement: () => setState(() {
        if (_adults < 50 && total < 50) {
          _occupancyQuantities[category] = count + 1;
          _adults++;
        }
      }),
    );
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

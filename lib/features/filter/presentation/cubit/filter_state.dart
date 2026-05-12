import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trip_marche/features/filter/domain/entities/filter_destination.dart';
import 'package:trip_marche/features/filter/domain/entities/filter_metadata.dart';

enum FilterDestinationsStatus { initial, loading, success, failure }
enum FilterMetadataStatus { initial, loading, success, failure }

class FilterState extends Equatable {
  const FilterState({
    this.priceRange = const RangeValues(0, 0),
    this.initialPriceRange = const RangeValues(0, 0),
    this.tripType = '',
    this.departureCountry = '',
    this.departureCity = '',
    this.tripMonth = '',
    this.airline = '',
    this.travelAgency = '',
    this.otherCountries = const {},
    this.otherCities = const {},
    this.agencyRatings = const {},
    this.citiesCounts = const {},
    this.countriesCounts = const {},
    this.tripRatings = const {},
    this.selectedDurations = const {},
    this.selectedGroupSizes = const {},
    this.tripSeasons = const {},
    this.tripFeatures = const {},
    this.hasDiscountCode = false,
    this.freeCancellation = false,
    this.destinationsStatus = FilterDestinationsStatus.initial,
    this.availableDestinations = const [],
    this.selectedDestinationIds = const {},
    this.destinationsErrorMessage,
    this.metadataStatus = FilterMetadataStatus.initial,
    this.metadata,
    this.metadataErrorMessage,
    this.currencyCode = 'EGP',
    this.priceHistogram = const [],
  });

  final RangeValues priceRange;
  final RangeValues initialPriceRange;
  final String tripType;
  final String departureCountry;
  final String departureCity;
  final String tripMonth;
  final String airline;
  final String travelAgency;
  final Set<String> otherCountries;
  final Set<String> otherCities;

  /// Multi-select rating thresholds for the tourism company (1..5).
  final Set<int> agencyRatings;

  /// Multi-select number-of-cities options (1..5).
  final Set<int> citiesCounts;

  /// Multi-select number-of-countries options (1..5).
  final Set<int> countriesCounts;

  /// Multi-select trip rating options (1..5).
  final Set<int> tripRatings;

  final Set<String> selectedDurations;
  final Set<String> selectedGroupSizes;

  /// Multi-select trip seasons (spring | hajj | newYear).
  final Set<String> tripSeasons;

  final Set<String> tripFeatures;
  final bool hasDiscountCode;
  final bool freeCancellation;
  final FilterDestinationsStatus destinationsStatus;
  final List<FilterDestination> availableDestinations;
  final Set<int> selectedDestinationIds;
  final String? destinationsErrorMessage;
  final FilterMetadataStatus metadataStatus;
  final FilterMetadata? metadata;
  final String? metadataErrorMessage;
  final String currencyCode;

  /// Optional histogram of trip counts across [bucketCount] equal price
  /// buckets, derived from the caller's currently loaded result set. When
  /// empty, the filter view falls back to a deterministic synthetic curve.
  final List<int> priceHistogram;

  int get activeFilterSectionsCount {
    var count = 0;
    if (selectedDestinationIds.isNotEmpty) {
      count++;
    }
    if (!_isSameRange(priceRange, initialPriceRange)) {
      count++;
    }
    if (tripType.isNotEmpty) {
      count++;
    }
    if (departureCountry.isNotEmpty) {
      count++;
    }
    if (departureCity.isNotEmpty) {
      count++;
    }
    if (tripMonth.isNotEmpty) {
      count++;
    }
    if (airline.isNotEmpty) {
      count++;
    }
    if (travelAgency.isNotEmpty) {
      count++;
    }
    if (otherCountries.isNotEmpty) {
      count++;
    }
    if (otherCities.isNotEmpty) {
      count++;
    }
    if (agencyRatings.isNotEmpty) {
      count++;
    }
    if (citiesCounts.isNotEmpty) {
      count++;
    }
    if (countriesCounts.isNotEmpty) {
      count++;
    }
    if (selectedDurations.isNotEmpty) {
      count++;
    }
    if (selectedGroupSizes.isNotEmpty) {
      count++;
    }
    if (tripSeasons.isNotEmpty) {
      count++;
    }
    if (tripFeatures.isNotEmpty) {
      count++;
    }
    if (tripRatings.isNotEmpty) {
      count++;
    }
    if (hasDiscountCode) {
      count++;
    }
    if (freeCancellation) {
      count++;
    }
    return count;
  }

  FilterState copyWith({
    RangeValues? priceRange,
    RangeValues? initialPriceRange,
    String? tripType,
    String? departureCountry,
    String? departureCity,
    String? tripMonth,
    String? airline,
    String? travelAgency,
    Set<String>? otherCountries,
    Set<String>? otherCities,
    Set<int>? agencyRatings,
    Set<int>? citiesCounts,
    Set<int>? countriesCounts,
    Set<int>? tripRatings,
    Set<String>? selectedDurations,
    Set<String>? selectedGroupSizes,
    Set<String>? tripSeasons,
    Set<String>? tripFeatures,
    bool? hasDiscountCode,
    bool? freeCancellation,
    FilterDestinationsStatus? destinationsStatus,
    List<FilterDestination>? availableDestinations,
    Set<int>? selectedDestinationIds,
    String? destinationsErrorMessage,
    bool clearDestinationsError = false,
    FilterMetadataStatus? metadataStatus,
    FilterMetadata? metadata,
    String? metadataErrorMessage,
    bool clearMetadataError = false,
    String? currencyCode,
    List<int>? priceHistogram,
  }) {
    return FilterState(
      priceRange: priceRange ?? this.priceRange,
      initialPriceRange: initialPriceRange ?? this.initialPriceRange,
      tripType: tripType ?? this.tripType,
      departureCountry: departureCountry ?? this.departureCountry,
      departureCity: departureCity ?? this.departureCity,
      tripMonth: tripMonth ?? this.tripMonth,
      airline: airline ?? this.airline,
      travelAgency: travelAgency ?? this.travelAgency,
      otherCountries: otherCountries ?? this.otherCountries,
      otherCities: otherCities ?? this.otherCities,
      agencyRatings: agencyRatings ?? this.agencyRatings,
      citiesCounts: citiesCounts ?? this.citiesCounts,
      countriesCounts: countriesCounts ?? this.countriesCounts,
      tripRatings: tripRatings ?? this.tripRatings,
      selectedDurations: selectedDurations ?? this.selectedDurations,
      selectedGroupSizes: selectedGroupSizes ?? this.selectedGroupSizes,
      tripSeasons: tripSeasons ?? this.tripSeasons,
      tripFeatures: tripFeatures ?? this.tripFeatures,
      hasDiscountCode: hasDiscountCode ?? this.hasDiscountCode,
      freeCancellation: freeCancellation ?? this.freeCancellation,
      destinationsStatus: destinationsStatus ?? this.destinationsStatus,
      availableDestinations: availableDestinations ?? this.availableDestinations,
      selectedDestinationIds: selectedDestinationIds ?? this.selectedDestinationIds,
      destinationsErrorMessage: clearDestinationsError
          ? null
          : destinationsErrorMessage ?? this.destinationsErrorMessage,
      metadataStatus: metadataStatus ?? this.metadataStatus,
      metadata: metadata ?? this.metadata,
      metadataErrorMessage: clearMetadataError
          ? null
          : metadataErrorMessage ?? this.metadataErrorMessage,
      currencyCode: currencyCode ?? this.currencyCode,
      priceHistogram: priceHistogram ?? this.priceHistogram,
    );
  }

  @override
  List<Object?> get props => [
        priceRange,
        initialPriceRange,
        tripType,
        departureCountry,
        departureCity,
        tripMonth,
        airline,
        travelAgency,
        otherCountries,
        otherCities,
        agencyRatings,
        citiesCounts,
        countriesCounts,
        tripRatings,
        selectedDurations,
        selectedGroupSizes,
        tripSeasons,
        tripFeatures,
        hasDiscountCode,
        freeCancellation,
        destinationsStatus,
        availableDestinations,
        selectedDestinationIds,
        destinationsErrorMessage,
        metadataStatus,
        metadata,
        metadataErrorMessage,
        currencyCode,
        priceHistogram,
      ];

  static bool _isSameRange(RangeValues a, RangeValues b) {
    const epsilon = 0.0001;
    final startDiff = (a.start - b.start).abs();
    final endDiff = (a.end - b.end).abs();
    return startDiff < epsilon && endDiff < epsilon;
  }
}

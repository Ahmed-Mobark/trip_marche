import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trip_marche/features/filter/domain/entities/filter_destination.dart';
import 'package:trip_marche/features/filter/domain/entities/filter_metadata.dart';

enum FilterDestinationsStatus { initial, loading, success, failure }
enum FilterMetadataStatus { initial, loading, success, failure }

class FilterState extends Equatable {
  const FilterState({
    this.priceRange = const RangeValues(5000, 8000),
    this.initialPriceRange = const RangeValues(5000, 8000),
    this.tripType = '',
    this.departureCountry = '',
    this.departureCity = '',
    this.tripMonth = '',
    this.airline = '',
    this.travelAgency = '',
    this.otherCountries = const {},
    this.otherCities = const {},
    this.agencyRating = 0,
    this.citiesCount = 0,
    this.countriesCount = 0,
    this.tripRating = 0,
    this.selectedDurations = const {},
    this.selectedGroupSizes = const {},
    this.tripSeason = '',
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
  final int agencyRating;
  final int citiesCount;
  final int countriesCount;
  final int tripRating;
  final Set<String> selectedDurations;
  final Set<String> selectedGroupSizes;
  final String tripSeason;
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
    if (agencyRating > 0) {
      count++;
    }
    if (citiesCount > 0) {
      count++;
    }
    if (countriesCount > 0) {
      count++;
    }
    if (selectedDurations.isNotEmpty) {
      count++;
    }
    if (selectedGroupSizes.isNotEmpty) {
      count++;
    }
    if (tripSeason.isNotEmpty) {
      count++;
    }
    if (tripFeatures.isNotEmpty) {
      count++;
    }
    if (tripRating > 0) {
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
    int? agencyRating,
    int? citiesCount,
    int? countriesCount,
    int? tripRating,
    Set<String>? selectedDurations,
    Set<String>? selectedGroupSizes,
    String? tripSeason,
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
      agencyRating: agencyRating ?? this.agencyRating,
      citiesCount: citiesCount ?? this.citiesCount,
      countriesCount: countriesCount ?? this.countriesCount,
      tripRating: tripRating ?? this.tripRating,
      selectedDurations: selectedDurations ?? this.selectedDurations,
      selectedGroupSizes: selectedGroupSizes ?? this.selectedGroupSizes,
      tripSeason: tripSeason ?? this.tripSeason,
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
        agencyRating,
        citiesCount,
        countriesCount,
        tripRating,
        selectedDurations,
        selectedGroupSizes,
        tripSeason,
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
      ];

  static bool _isSameRange(RangeValues a, RangeValues b) {
    const epsilon = 0.0001;
    final startDiff = (a.start - b.start).abs();
    final endDiff = (a.end - b.end).abs();
    return startDiff < epsilon && endDiff < epsilon;
  }
}

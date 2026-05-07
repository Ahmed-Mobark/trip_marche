import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FilterState extends Equatable {
  const FilterState({
    this.priceRange = const RangeValues(5000, 8000),
    this.tripType = 'domestic',
    this.agencyRating = 5,
    this.citiesCount = 5,
    this.countriesCount = 5,
    this.tripRating = 5,
    this.selectedDurations = const {'1-3 Days', '5+ Days'},
    this.selectedGroupSizes = const {'5-10', '25+'},
    this.tripSeason = 'spring',
    this.tripFeatures = const {'noVisa'},
    this.hasDiscountCode = true,
    this.freeCancellation = false,
  });

  final RangeValues priceRange;
  final String tripType;
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

  FilterState copyWith({
    RangeValues? priceRange,
    String? tripType,
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
  }) {
    return FilterState(
      priceRange: priceRange ?? this.priceRange,
      tripType: tripType ?? this.tripType,
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
    );
  }

  @override
  List<Object?> get props => [
        priceRange,
        tripType,
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
      ];
}

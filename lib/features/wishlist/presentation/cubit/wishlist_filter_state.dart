import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class WishlistFilterState extends Equatable {
  const WishlistFilterState({
    this.priceRange = const RangeValues(1000, 8000),
    this.destination = '',
    this.departureCountry = '',
    this.departureCity = '',
    this.tripMonth = '',
    this.actions = '',
    this.agency = '',
    this.agencyRating = 0,
    this.otherCountries = '',
    this.otherCities = '',
    this.numberOfCities = 1,
    this.numberOfCountries = 1,
    this.tripType = 'domestic',
    this.duration = '',
    this.groupSize = '',
    this.tripSeason = '',
    this.tripFeatures = const <String>{},
    this.tripRating = 0,
    this.hasDiscountCode = false,
    this.freeCancellation = false,
  });

  final RangeValues priceRange;

  final String destination;
  final String departureCountry;
  final String departureCity;
  final String tripMonth;
  final String actions;
  final String agency;
  final int agencyRating;

  final String otherCountries;
  final String otherCities;

  final int numberOfCities;
  final int numberOfCountries;

  /// Values: 'domestic' | 'international'
  final String tripType;
  final String duration;
  final String groupSize;
  final String tripSeason;

  final Set<String> tripFeatures;
  final int tripRating;

  final bool hasDiscountCode;
  final bool freeCancellation;

  WishlistFilterState copyWith({
    RangeValues? priceRange,
    String? destination,
    String? departureCountry,
    String? departureCity,
    String? tripMonth,
    String? actions,
    String? agency,
    int? agencyRating,
    String? otherCountries,
    String? otherCities,
    int? numberOfCities,
    int? numberOfCountries,
    String? tripType,
    String? duration,
    String? groupSize,
    String? tripSeason,
    Set<String>? tripFeatures,
    int? tripRating,
    bool? hasDiscountCode,
    bool? freeCancellation,
  }) {
    return WishlistFilterState(
      priceRange: priceRange ?? this.priceRange,
      destination: destination ?? this.destination,
      departureCountry: departureCountry ?? this.departureCountry,
      departureCity: departureCity ?? this.departureCity,
      tripMonth: tripMonth ?? this.tripMonth,
      actions: actions ?? this.actions,
      agency: agency ?? this.agency,
      agencyRating: agencyRating ?? this.agencyRating,
      otherCountries: otherCountries ?? this.otherCountries,
      otherCities: otherCities ?? this.otherCities,
      numberOfCities: numberOfCities ?? this.numberOfCities,
      numberOfCountries: numberOfCountries ?? this.numberOfCountries,
      tripType: tripType ?? this.tripType,
      duration: duration ?? this.duration,
      groupSize: groupSize ?? this.groupSize,
      tripSeason: tripSeason ?? this.tripSeason,
      tripFeatures: tripFeatures ?? this.tripFeatures,
      tripRating: tripRating ?? this.tripRating,
      hasDiscountCode: hasDiscountCode ?? this.hasDiscountCode,
      freeCancellation: freeCancellation ?? this.freeCancellation,
    );
  }

  @override
  List<Object?> get props => [
    priceRange,
    destination,
    departureCountry,
    departureCity,
    tripMonth,
    actions,
    agency,
    agencyRating,
    otherCountries,
    otherCities,
    numberOfCities,
    numberOfCountries,
    tripType,
    duration,
    groupSize,
    tripSeason,
    tripFeatures,
    tripRating,
    hasDiscountCode,
    freeCancellation,
  ];
}

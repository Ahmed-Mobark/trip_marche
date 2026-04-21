import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:trip_marche/features/wishlist/presentation/cubit/wishlist_filter_state.dart';

class WishlistFilterCubit extends Cubit<WishlistFilterState> {
  WishlistFilterCubit() : super(const WishlistFilterState());

  void reset() => emit(const WishlistFilterState());

  void setPriceRange(RangeValues v) => emit(state.copyWith(priceRange: v));

  void setDestination(String v) => emit(state.copyWith(destination: v));
  void setDepartureCountry(String v) => emit(state.copyWith(departureCountry: v));
  void setDepartureCity(String v) => emit(state.copyWith(departureCity: v));
  void setTripMonth(String v) => emit(state.copyWith(tripMonth: v));
  void setActions(String v) => emit(state.copyWith(actions: v));
  void setAgency(String v) => emit(state.copyWith(agency: v));
  void setAgencyRating(int v) => emit(state.copyWith(agencyRating: v));

  void setOtherCountries(String v) => emit(state.copyWith(otherCountries: v));
  void setOtherCities(String v) => emit(state.copyWith(otherCities: v));

  void setNumberOfCities(int v) => emit(state.copyWith(numberOfCities: v));
  void setNumberOfCountries(int v) => emit(state.copyWith(numberOfCountries: v));

  void setTripType(String v) => emit(state.copyWith(tripType: v));
  void setDuration(String v) => emit(state.copyWith(duration: v));
  void setGroupSize(String v) => emit(state.copyWith(groupSize: v));
  void setTripSeason(String v) => emit(state.copyWith(tripSeason: v));

  void toggleTripFeature(String key, bool selected) {
    final updated = <String>{...state.tripFeatures};
    if (selected) {
      updated.add(key);
    } else {
      updated.remove(key);
    }
    emit(state.copyWith(tripFeatures: updated));
  }

  void setTripRating(int v) => emit(state.copyWith(tripRating: v));

  void setHasDiscountCode(bool v) => emit(state.copyWith(hasDiscountCode: v));
  void setFreeCancellation(bool v) => emit(state.copyWith(freeCancellation: v));
}


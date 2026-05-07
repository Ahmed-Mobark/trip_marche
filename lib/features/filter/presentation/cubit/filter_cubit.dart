import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/features/filter/presentation/cubit/filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterState());

  void resetFilters() => emit(const FilterState());

  void setPriceRange(RangeValues value) => emit(state.copyWith(priceRange: value));

  void setTripType(String value) => emit(state.copyWith(tripType: value));

  void setAgencyRating(int value) => emit(state.copyWith(agencyRating: value));

  void setCitiesCount(int value) => emit(state.copyWith(citiesCount: value));

  void setCountriesCount(int value) =>
      emit(state.copyWith(countriesCount: value));

  void setTripRating(int value) => emit(state.copyWith(tripRating: value));

  void setTripSeason(String value) => emit(state.copyWith(tripSeason: value));

  void setHasDiscountCode(bool value) =>
      emit(state.copyWith(hasDiscountCode: value));

  void setFreeCancellation(bool value) =>
      emit(state.copyWith(freeCancellation: value));

  void toggleDuration(String value) {
    final next = {...state.selectedDurations};
    if (next.contains(value)) {
      next.remove(value);
    } else {
      next.add(value);
    }
    emit(state.copyWith(selectedDurations: next));
  }

  void toggleGroupSize(String value) {
    final next = {...state.selectedGroupSizes};
    if (next.contains(value)) {
      next.remove(value);
    } else {
      next.add(value);
    }
    emit(state.copyWith(selectedGroupSizes: next));
  }

  void toggleTripFeature(String value) {
    final next = {...state.tripFeatures};
    if (next.contains(value)) {
      next.remove(value);
    } else {
      next.add(value);
    }
    emit(state.copyWith(tripFeatures: next));
  }
}

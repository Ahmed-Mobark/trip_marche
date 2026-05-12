import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/features/filter/domain/usecases/get_destinations_usecase.dart';
import 'package:trip_marche/features/filter/domain/usecases/get_filter_metadata_usecase.dart';
import 'package:trip_marche/features/filter/presentation/cubit/filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit(this._getDestinationsUseCase, this._getFilterMetadataUseCase)
      : super(const FilterState());

  final GetDestinationsUseCase _getDestinationsUseCase;
  final GetFilterMetadataUseCase _getFilterMetadataUseCase;

  void resetFilters() {
    if (isClosed) {
      return;
    }
    emit(const FilterState());
    loadInitialData();
  }

  void setPriceRange(RangeValues value) {
    emit(state.copyWith(priceRange: value));
  }

  void setTripType(String value) {
    emit(state.copyWith(tripType: value));
  }

  void setDepartureCountry(String value) {
    emit(state.copyWith(departureCountry: value));
  }

  void setDepartureCity(String value) {
    emit(state.copyWith(departureCity: value));
  }

  void setTripMonth(String value) {
    emit(state.copyWith(tripMonth: value));
  }

  void setAirline(String value) {
    emit(state.copyWith(airline: value));
  }

  void setTravelAgency(String value) {
    emit(state.copyWith(travelAgency: value));
  }

  void toggleOtherCountry(String value) {
    final next = {...state.otherCountries};
    if (next.contains(value)) {
      next.remove(value);
    } else {
      next.add(value);
    }
    emit(state.copyWith(otherCountries: next));
  }

  void toggleOtherCity(String value) {
    final next = {...state.otherCities};
    if (next.contains(value)) {
      next.remove(value);
    } else {
      next.add(value);
    }
    emit(state.copyWith(otherCities: next));
  }

  void toggleAgencyRating(int value) {
    final next = {...state.agencyRatings};
    if (next.contains(value)) {
      next.remove(value);
    } else {
      next.add(value);
    }
    emit(state.copyWith(agencyRatings: next));
  }

  void toggleCitiesCount(int value) {
    final next = {...state.citiesCounts};
    if (next.contains(value)) {
      next.remove(value);
    } else {
      next.add(value);
    }
    emit(state.copyWith(citiesCounts: next));
  }

  void toggleCountriesCount(int value) {
    final next = {...state.countriesCounts};
    if (next.contains(value)) {
      next.remove(value);
    } else {
      next.add(value);
    }
    emit(state.copyWith(countriesCounts: next));
  }

  void toggleTripRating(int value) {
    final next = {...state.tripRatings};
    if (next.contains(value)) {
      next.remove(value);
    } else {
      next.add(value);
    }
    emit(state.copyWith(tripRatings: next));
  }

  void toggleTripSeason(String value) {
    final next = {...state.tripSeasons};
    if (next.contains(value)) {
      next.remove(value);
    } else {
      next.add(value);
    }
    emit(state.copyWith(tripSeasons: next));
  }

  void setHasDiscountCode(bool value) {
    emit(state.copyWith(hasDiscountCode: value));
  }

  void setFreeCancellation(bool value) {
    emit(state.copyWith(freeCancellation: value));
  }

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

  /// Updates the visualised price histogram (counts per price bucket).
  /// Callers (e.g. SearchResultView) pass this when opening FilterView so
  /// the chart reflects the current result set instead of a static curve.
  void setPriceHistogram(List<int> counts) {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(priceHistogram: counts));
  }

  Future<void> loadInitialData() async {
    if (isClosed) {
      return;
    }
    await Future.wait([loadFilterMetadata(), loadDestinations()]);
  }

  Future<void> loadDestinations() async {
    if (isClosed) {
      return;
    }
    emit(
      state.copyWith(
        destinationsStatus: FilterDestinationsStatus.loading,
        clearDestinationsError: true,
      ),
    );
    final result = await _getDestinationsUseCase();
    if (isClosed) {
      return;
    }
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            destinationsStatus: FilterDestinationsStatus.failure,
            destinationsErrorMessage: failure.message,
          ),
        );
      },
      (destinations) {
        emit(
          state.copyWith(
            destinationsStatus: FilterDestinationsStatus.success,
            availableDestinations: destinations,
            selectedDestinationIds: state.selectedDestinationIds,
            clearDestinationsError: true,
          ),
        );
      },
    );
  }

  Future<void> loadFilterMetadata() async {
    if (isClosed) {
      return;
    }
    emit(
      state.copyWith(
        metadataStatus: FilterMetadataStatus.loading,
        clearMetadataError: true,
      ),
    );
    final result = await _getFilterMetadataUseCase();
    if (isClosed) {
      return;
    }
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            metadataStatus: FilterMetadataStatus.failure,
            metadataErrorMessage: failure.message,
          ),
        );
      },
      (metadata) {
        emit(
          state.copyWith(
            metadataStatus: FilterMetadataStatus.success,
            metadata: metadata,
            currencyCode: metadata.price.currency.isEmpty
                ? state.currencyCode
                : metadata.price.currency,
            clearMetadataError: true,
          ),
        );
      },
    );
  }

  void toggleDestinationSelection(int destinationId) {
    final next = {...state.selectedDestinationIds};
    if (next.contains(destinationId)) {
      next.remove(destinationId);
    } else {
      next.add(destinationId);
    }
    emit(state.copyWith(selectedDestinationIds: next));
  }
}

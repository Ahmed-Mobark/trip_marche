import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/special_trips_response.dart';
import '../../domain/repositories/home_repository.dart';
import 'special_trips_state.dart';

class SpecialTripsCubit extends Cubit<SpecialTripsState> {
  SpecialTripsCubit(this._homeRepository) : super(const SpecialTripsState());

  final HomeRepository _homeRepository;

  /// Load first page of special trips for given category
  Future<void> loadTrips(int categoryId) async {
    emit(state.copyWith(
      status: SpecialTripsStatus.loading,
      categoryId: categoryId,
      trips: [],
    ));

    final result = await _homeRepository.getSpecialTrips(
      categoryId: categoryId,
      page: 1,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: SpecialTripsStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (data) {
        final response = SpecialTripsResponse.fromJson(data);
        emit(state.copyWith(
          status: SpecialTripsStatus.success,
          trips: response.trips,
          meta: response.meta,
        ));
      },
    );
  }

  /// Load next page (horizontal pagination)
  Future<void> loadMore() async {
    if (!state.hasMore ||
        state.status == SpecialTripsStatus.loadingMore ||
        state.categoryId == null) {
      return;
    }

    emit(state.copyWith(status: SpecialTripsStatus.loadingMore));

    final result = await _homeRepository.getSpecialTrips(
      categoryId: state.categoryId!,
      page: state.nextPage,
    );

    result.fold(
      (failure) {
        // Revert to success so user can retry
        emit(state.copyWith(status: SpecialTripsStatus.success));
      },
      (data) {
        final response = SpecialTripsResponse.fromJson(data);
        emit(state.copyWith(
          status: SpecialTripsStatus.success,
          trips: [...state.trips, ...response.trips],
          meta: response.meta,
        ));
      },
    );
  }
}

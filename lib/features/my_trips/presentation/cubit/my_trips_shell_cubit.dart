import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_state.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_tab.dart';

class MyTripsShellCubit extends Cubit<MyTripsShellState> {
  MyTripsShellCubit() : super(_initial);

  static const MyTripsShellState _initial = MyTripsShellState(
    trips: [
      MyTripRowUiModel(
        id: 1,
        title: 'Dahab Trip',
        rating: 4.9,
        reviewCount: 112,
        locationLabel: 'From Cairo',
        dateRange: '27 Nov → 4 Dec',
        isWishlisted: true,
      ),
      MyTripRowUiModel(
        id: 2,
        title: 'Dahab Trip',
        rating: 4.9,
        reviewCount: 112,
        locationLabel: 'From Cairo',
        dateRange: '27 Nov → 4 Dec',
        isWishlisted: true,
      ),
      MyTripRowUiModel(
        id: 3,
        title: 'Dahab Trip',
        rating: 4.9,
        reviewCount: 112,
        locationLabel: 'From Cairo',
        dateRange: '27 Nov → 4 Dec',
        isWishlisted: true,
        useDownloadPdfWhenActive: true,
      ),
    ],
  );

  void selectTab(MyTripsShellTab tab) => emit(state.copyWith(tab: tab));

  void setSearchQuery(String query) =>
      emit(state.copyWith(searchQuery: query));

  void toggleWishlist(int id) {
    final next = state.trips
        .map(
          (t) => t.id == id ? t.copyWith(isWishlisted: !t.isWishlisted) : t,
        )
        .toList();
    emit(state.copyWith(trips: next));
  }
}

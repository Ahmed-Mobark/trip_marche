import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_state.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_shell_tab.dart';

class MyTripsShellCubit extends Cubit<MyTripsShellState> {
  MyTripsShellCubit() : super(const MyTripsShellState());

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

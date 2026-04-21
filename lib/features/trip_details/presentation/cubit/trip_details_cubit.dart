import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trip_marche/features/trip_details/presentation/cubit/trip_details_state.dart';

class TripDetailsCubit extends Cubit<TripDetailsState> {
  TripDetailsCubit() : super(const TripDetailsState());

  void toggleFavorite() => emit(state.copyWith(isFavorite: !state.isFavorite));

  void toggleExpandedDay(int index) {
    emit(state.copyWith(
      expandedDayIndex: state.expandedDayIndex == index ? -1 : index,
    ));
  }

  void toggleActivity(String id) {
    final next = Set<String>.from(state.addedActivityIds);
    if (next.contains(id)) {
      next.remove(id);
    } else {
      next.add(id);
    }
    emit(state.copyWith(addedActivityIds: next));
  }
}


import 'package:equatable/equatable.dart';

class TripDetailsState extends Equatable {
  const TripDetailsState({
    this.isFavorite = false,
    this.expandedDayIndex = -1,
    this.addedActivityIds = const <String>{},
  });

  final bool isFavorite;
  final int expandedDayIndex;
  final Set<String> addedActivityIds;

  TripDetailsState copyWith({
    bool? isFavorite,
    int? expandedDayIndex,
    Set<String>? addedActivityIds,
  }) {
    return TripDetailsState(
      isFavorite: isFavorite ?? this.isFavorite,
      expandedDayIndex: expandedDayIndex ?? this.expandedDayIndex,
      addedActivityIds: addedActivityIds ?? this.addedActivityIds,
    );
  }

  @override
  List<Object?> get props => [isFavorite, expandedDayIndex, addedActivityIds];
}

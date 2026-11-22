import 'package:equatable/equatable.dart';

class BookingOccupancySelection extends Equatable {
  const BookingOccupancySelection({
    required this.category,
    required this.travelers,
  });

  final String category;
  final int travelers;

  @override
  List<Object?> get props => [category, travelers];
}

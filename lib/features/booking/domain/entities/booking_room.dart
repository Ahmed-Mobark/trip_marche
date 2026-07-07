import 'package:equatable/equatable.dart';

class BookingRoom extends Equatable {
  const BookingRoom({
    required this.roomTypeId,
    required this.persons,
  });

  final int roomTypeId;
  final int persons;

  @override
  List<Object?> get props => [roomTypeId, persons];
}

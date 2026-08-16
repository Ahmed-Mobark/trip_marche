import 'package:equatable/equatable.dart';
import 'package:trip_marche/features/my_trips/domain/entities/booking_entity.dart';

enum BookingsStatus { initial, loading, loadingMore, success, failure }

class BookingsState extends Equatable {
  const BookingsState({
    this.status = BookingsStatus.initial,
    this.bookings = const [],
    this.meta,
    this.errorMessage,
  });

  final BookingsStatus status;
  final List<Booking> bookings;
  final BookingPaginationMeta? meta;
  final String? errorMessage;

  bool get hasMore => meta?.hasMore ?? false;
  int get nextPage => (meta?.currentPage ?? 0) + 1;

  BookingsState copyWith({
    BookingsStatus? status,
    List<Booking>? bookings,
    BookingPaginationMeta? meta,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return BookingsState(
      status: status ?? this.status,
      bookings: bookings ?? this.bookings,
      meta: meta ?? this.meta,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, bookings, meta, errorMessage];
}

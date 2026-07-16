import 'package:equatable/equatable.dart';

class BookingPdfState extends Equatable {
  const BookingPdfState({
    this.status = BookingPdfStatus.initial,
    this.loadingBookingId,
    this.filePath,
    this.errorMessage,
  });

  final BookingPdfStatus status;
  final int? loadingBookingId;
  final String? filePath;
  final String? errorMessage;

  bool isLoadingFor(int bookingId) =>
      status == BookingPdfStatus.loading && loadingBookingId == bookingId;

  BookingPdfState copyWith({
    BookingPdfStatus? status,
    int? loadingBookingId,
    String? filePath,
    String? errorMessage,
    bool clearError = false,
  }) {
    return BookingPdfState(
      status: status ?? this.status,
      loadingBookingId: loadingBookingId ?? this.loadingBookingId,
      filePath: filePath ?? this.filePath,
      errorMessage: clearError
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, loadingBookingId, filePath, errorMessage];
}

enum BookingPdfStatus { initial, loading, success, failure }

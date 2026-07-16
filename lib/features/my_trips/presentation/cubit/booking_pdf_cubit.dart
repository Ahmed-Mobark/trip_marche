import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/features/my_trips/domain/usecases/fetch_booking_pdf_usecase.dart';
import 'booking_pdf_state.dart';

class BookingPdfCubit extends Cubit<BookingPdfState> {
  BookingPdfCubit(this._fetchBookingPdf) : super(const BookingPdfState());

  final FetchBookingPdfUseCase _fetchBookingPdf;

  Future<void> fetchAndOpen(int bookingId) async {
    if (state.status == BookingPdfStatus.loading) {
      return;
    }
    emit(state.copyWith(
      status: BookingPdfStatus.loading,
      loadingBookingId: bookingId,
      clearError: true,
    ));

    final result = await _fetchBookingPdf(bookingId);

    result.fold(
      (failure) {
        if (!isClosed) {
          emit(state.copyWith(
            status: BookingPdfStatus.failure,
            errorMessage: failure.message,
          ));
        }
      },
      (filePath) {
        if (!isClosed) {
          emit(state.copyWith(
            status: BookingPdfStatus.success,
            filePath: filePath,
          ));
        }
      },
    );
  }

  void reset() {
    if (!isClosed) {
      emit(const BookingPdfState());
    }
  }
}

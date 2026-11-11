import '../../domain/usecases/quote_booking_usecase.dart';
import '../../domain/entities/booking_review_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/booking/domain/usecases/validate_coupon_usecase.dart';
import 'coupon_state.dart';

class CouponCubit extends Cubit<CouponState> {
  CouponCubit(this._validateCouponUseCase, {QuoteBookingUseCase? quoteBooking})
    : _quoteBooking = quoteBooking,
      super(const CouponState());

  final QuoteBookingUseCase? _quoteBooking;
  BookingReviewData? _reviewData;
  int _quoteSerial = 0;
  String? _pendingCouponCode;

  Future<void> loadBookingQuote(
    BookingReviewData data, {
    String? couponCode,
  }) async {
    _reviewData = data;
    final useCase = _quoteBooking;
    if (useCase == null) return;
    final serial = ++_quoteSerial;
    _pendingCouponCode = couponCode;
    emit(
      state.copyWith(
        status: CouponStatus.loading,
        clearQuote: true,
        clearMessages: true,
      ),
    );
    final result = await useCase(data, couponCode: couponCode);
    if (isClosed || serial != _quoteSerial) return;
    _pendingCouponCode = null;
    result.fold(
      (failure) => emit(
        CouponState(
          status: CouponStatus.error,
          errorMessage: failure.message,
          showNetworkError: failure is NetworkFailure,
        ),
      ),
      (quote) => emit(
        CouponState(
          status: quote.coupon == null
              ? CouponStatus.initial
              : CouponStatus.applied,
          quote: quote,
          coupon: quote.coupon,
          appliedCode: quote.coupon?.code,
        ),
      ),
    );
  }

  final ValidateCouponUseCase _validateCouponUseCase;

  void onCodeChanged(String code) {
    final trimmed = code.trim();
    if ((state.appliedCode != null && trimmed != state.appliedCode) ||
        (state.isLoading &&
            _pendingCouponCode != null &&
            trimmed != _pendingCouponCode)) {
      if (_reviewData != null) {
        loadBookingQuote(_reviewData!);
        return;
      }
      emit(const CouponState(status: CouponStatus.initial));
    } else if (state.status == CouponStatus.error) {
      emit(state.copyWith(clearMessages: true, status: CouponStatus.initial));
    }
  }

  Future<void> applyCoupon({
    required String code,
    required int tripId,
    required double amount,
  }) async {
    final trimmed = code.trim();
    if (trimmed.isEmpty) {
      return;
    }

    if (_reviewData != null && _quoteBooking != null) {
      await loadBookingQuote(_reviewData!, couponCode: trimmed);
      return;
    }

    if (state.isApplied && state.appliedCode == trimmed) {
      return;
    }

    emit(
      state.copyWith(
        status: CouponStatus.loading,
        clearMessages: true,
        showNetworkError: false,
      ),
    );

    final result = await _validateCouponUseCase(
      code: trimmed,
      tripId: tripId,
      amount: amount,
    );

    result.fold(
      (failure) {
        if (failure is NetworkFailure) {
          emit(
            state.copyWith(
              status: CouponStatus.error,
              clearCoupon: true,
              showNetworkError: true,
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            status: CouponStatus.error,
            clearCoupon: true,
            errorMessage: failure.message,
            showNetworkError: false,
          ),
        );
      },
      (coupon) {
        emit(
          CouponState(
            status: CouponStatus.applied,
            coupon: coupon,
            successMessage: coupon.message,
            appliedCode: trimmed,
          ),
        );
      },
    );
  }

  void clearNetworkErrorFlag() {
    if (state.showNetworkError) {
      emit(state.copyWith(showNetworkError: false));
    }
  }
}

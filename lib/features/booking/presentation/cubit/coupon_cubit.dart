import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/booking/domain/usecases/validate_coupon_usecase.dart';
import 'coupon_state.dart';

class CouponCubit extends Cubit<CouponState> {
  CouponCubit(this._validateCouponUseCase) : super(const CouponState());

  final ValidateCouponUseCase _validateCouponUseCase;

  void onCodeChanged(String code) {
    final trimmed = code.trim();
    if (state.appliedCode != null && trimmed != state.appliedCode) {
      emit(
        const CouponState(
          status: CouponStatus.initial,
        ),
      );
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

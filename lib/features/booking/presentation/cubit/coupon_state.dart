import 'package:equatable/equatable.dart';
import 'package:trip_marche/features/booking/domain/entities/coupon_validation.dart';

enum CouponStatus { initial, loading, applied, error }

class CouponState extends Equatable {
  const CouponState({
    this.status = CouponStatus.initial,
    this.coupon,
    this.successMessage,
    this.errorMessage,
    this.appliedCode,
    this.showNetworkError = false,
  });

  final CouponStatus status;
  final CouponValidation? coupon;
  final String? successMessage;
  final String? errorMessage;
  final String? appliedCode;
  final bool showNetworkError;

  bool get isLoading => status == CouponStatus.loading;
  bool get isApplied => status == CouponStatus.applied && coupon != null;

  CouponState copyWith({
    CouponStatus? status,
    CouponValidation? coupon,
    String? successMessage,
    String? errorMessage,
    String? appliedCode,
    bool? showNetworkError,
    bool clearCoupon = false,
    bool clearMessages = false,
  }) {
    return CouponState(
      status: status ?? this.status,
      coupon: clearCoupon ? null : (coupon ?? this.coupon),
      successMessage:
          clearMessages ? null : (successMessage ?? this.successMessage),
      errorMessage: clearMessages ? null : (errorMessage ?? this.errorMessage),
      appliedCode: clearCoupon ? null : (appliedCode ?? this.appliedCode),
      showNetworkError: showNetworkError ?? this.showNetworkError,
    );
  }

  @override
  List<Object?> get props => [
        status,
        coupon,
        successMessage,
        errorMessage,
        appliedCode,
        showNetworkError,
      ];
}

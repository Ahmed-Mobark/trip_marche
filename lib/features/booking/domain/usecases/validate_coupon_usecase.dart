import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/booking/data/models/validate_coupon_request.dart';
import 'package:trip_marche/features/booking/domain/entities/coupon_validation.dart';
import 'package:trip_marche/features/booking/domain/repositories/coupon_repository.dart';

class ValidateCouponUseCase {
  const ValidateCouponUseCase(this._repository);

  final CouponRepository _repository;

  Future<Either<Failure, CouponValidation>> call({
    required String code,
    required int tripId,
    required double amount,
  }) {
    return _repository.validateCoupon(
      ValidateCouponRequest(code: code, tripId: tripId, amount: amount),
    );
  }
}

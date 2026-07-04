import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/booking/data/models/validate_coupon_request.dart';
import 'package:trip_marche/features/booking/domain/entities/coupon_validation.dart';

abstract class CouponRepository {
  Future<Either<Failure, CouponValidation>> validateCoupon(
    ValidateCouponRequest request,
  );
}

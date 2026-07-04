import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/core/network/network_service/repository_helper.dart';
import 'package:trip_marche/features/booking/data/datasources/coupon_remote_data_source.dart';
import 'package:trip_marche/features/booking/data/models/validate_coupon_request.dart';
import 'package:trip_marche/features/booking/domain/entities/coupon_validation.dart';
import 'package:trip_marche/features/booking/domain/repositories/coupon_repository.dart';

class CouponRepositoryImpl with RepositoryHelper implements CouponRepository {
  CouponRepositoryImpl(this._remote);

  final CouponRemoteDataSource _remote;

  @override
  Future<Either<Failure, CouponValidation>> validateCoupon(
    ValidateCouponRequest request,
  ) =>
      handleEither(() async {
        final model = await _remote.validateCoupon(request);
        return model.toEntity();
      });
}

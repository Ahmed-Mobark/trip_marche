import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/profile/domain/entities/follow_vendor_entity.dart';
import 'package:trip_marche/features/profile/domain/repositories/profile_repository.dart';

class ToggleFollowVendorUseCase {
  const ToggleFollowVendorUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Either<Failure, FollowVendorEntity>> call(int vendorId) {
    return _repository.toggleFollowVendor(vendorId);
  }
}

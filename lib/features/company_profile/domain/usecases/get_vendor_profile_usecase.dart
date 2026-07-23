import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/company_profile/domain/repositories/vendor_profile_repository.dart';
import 'package:trip_marche/features/company_profile/data/models/vendor_profile_model.dart';

class GetVendorProfileUseCase {
  GetVendorProfileUseCase(this._repository);

  final VendorProfileRepository _repository;

  Future<Either<Failure, VendorProfileModel>> call(int vendorId) {
    if (vendorId <= 0) {
      return Future.value(
        Left(ValidationFailure(message: 'Invalid vendor ID')),
      );
    }
    return _repository.getVendorProfile(vendorId);
  }
}

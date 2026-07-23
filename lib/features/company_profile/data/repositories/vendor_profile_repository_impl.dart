import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/core/network/network_service/repository_helper.dart';
import 'package:trip_marche/features/company_profile/data/datasources/vendor_profile_remote_data_source.dart';
import 'package:trip_marche/features/company_profile/data/models/vendor_profile_model.dart';
import 'package:trip_marche/features/company_profile/domain/repositories/vendor_profile_repository.dart';

class VendorProfileRepositoryImpl
    with RepositoryHelper
    implements VendorProfileRepository {
  VendorProfileRepositoryImpl(this._remote);

  final VendorProfileRemoteDataSource _remote;

  @override
  Future<Either<Failure, VendorProfileModel>> getVendorProfile(int vendorId) {
    return handleEither(() async {
      final model = await _remote.getVendorProfile(vendorId);
      return model;
    });
  }
}

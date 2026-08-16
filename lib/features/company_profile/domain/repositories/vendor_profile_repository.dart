import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/company_profile/data/models/vendor_profile_model.dart';

abstract class VendorProfileRepository {
  Future<Either<Failure, VendorProfileModel>> getVendorProfile(int vendorId);
}

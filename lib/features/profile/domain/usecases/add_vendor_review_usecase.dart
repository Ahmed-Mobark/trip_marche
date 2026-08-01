import 'package:dartz/dartz.dart';
import '../../../../core/network/network_service/failures.dart';
import '../repositories/profile_repository.dart';

class AddVendorReviewUseCase {
  final ProfileRepository _repository;

  AddVendorReviewUseCase(this._repository);

  Future<Either<Failure, Map<String, dynamic>>> call({
    required int vendorId,
    required double rating,
    required String comment,
  }) {
    return _repository.addVendorReview(vendorId, rating, comment);
  }
}

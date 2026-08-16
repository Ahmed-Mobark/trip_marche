import 'package:dartz/dartz.dart';
import '../../../../core/network/network_service/failures.dart';
import '../repositories/profile_repository.dart';
import '../../data/models/submit_review_request.dart';

class AddVendorReviewUseCase {
  final ProfileRepository _repository;

  AddVendorReviewUseCase(this._repository);

  Future<Either<Failure, Map<String, dynamic>>> call(
    SubmitReviewRequest request,
  ) {
    return _repository.submitReviews(request);
  }
}

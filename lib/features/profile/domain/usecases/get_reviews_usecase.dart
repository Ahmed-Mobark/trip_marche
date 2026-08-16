import 'package:dartz/dartz.dart';
import '../../../../core/network/network_service/failures.dart';
import '../../data/models/review_model.dart';
import '../entities/review_entity.dart';
import '../repositories/profile_repository.dart';

class GetReviewsUseCase {
  final ProfileRepository _repository;

  GetReviewsUseCase(this._repository);

  Future<Either<Failure, ({List<ReviewEntity> reviews, ReviewMetaEntity meta})>> call() async {
    final result = await _repository.getReviews();
    return result.map((response) {
      final dataList = (response['data'] as List<dynamic>? ?? [])
          .map((item) => ReviewModel.fromJson(item as Map<String, dynamic>).toEntity())
          .toList();

      final metaJson = response['meta'] as Map<String, dynamic>? ?? {};
      final meta = ReviewMetaModel.fromJson(metaJson).toEntity();

      return (reviews: dataList, meta: meta);
    });
  }
}

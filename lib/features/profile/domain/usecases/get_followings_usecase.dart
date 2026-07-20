import 'package:dartz/dartz.dart';
import '../../../../core/network/network_service/failures.dart';
import '../entities/following_entity.dart';
import '../repositories/profile_repository.dart';

class GetFollowingsUseCase {
  final ProfileRepository _repository;

  GetFollowingsUseCase(this._repository);

  Future<Either<Failure, ({List<FollowingEntity> companies, FollowingMetaEntity meta})>> call() async {
    final result = await _repository.getFollowings();
    return result.map((response) {
      final dataList = (response['data'] as List<dynamic>? ?? [])
          .map((item) => FollowingEntity(
                id: (item['id'] as num?)?.toInt() ?? 0,
                name: item['name'] as String? ?? '',
                avatar: item['avatar'] as String? ?? '',
                company: item['company'] as String? ?? '',
                about: item['about'] as String? ?? '',
                website: item['website'] as String? ?? '',
                rating: (item['rating'] as num?)?.toDouble() ?? 0.0,
                reviewsCount: (item['reviews_count'] as num?)?.toInt() ?? 0,
                tripsCount: (item['trips_count'] as num?)?.toInt() ?? 0,
                followersCount: (item['followers_count'] as num?)?.toInt() ?? 0,
                isFollowing: item['is_following'] as bool? ?? false,
              ))
          .toList();

      final metaJson = response['meta'] as Map<String, dynamic>? ?? {};
      final meta = FollowingMetaEntity(
        currentPage: (metaJson['current_page'] as num?)?.toInt() ?? 1,
        lastPage: (metaJson['last_page'] as num?)?.toInt() ?? 1,
        perPage: (metaJson['per_page'] as num?)?.toInt() ?? 10,
        total: (metaJson['total'] as num?)?.toInt() ?? 0,
      );

      return (companies: dataList, meta: meta);
    });
  }
}

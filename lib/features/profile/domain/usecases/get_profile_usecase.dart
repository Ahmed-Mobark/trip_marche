import 'package:dartz/dartz.dart';
import '../../../../core/network/network_service/failures.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository _repository;

  GetProfileUseCase(this._repository);

  Future<Either<Failure, ProfileEntity>> call() async {
    final result = await _repository.getProfile();
    return result.map((response) {
      final payload = response['data'] as Map<String, dynamic>? ?? response;
      final id = (payload['id'] as num?)?.toInt() ?? 0;
      final name = payload['name'] as String? ?? '';
      final email = payload['email'] as String? ?? '';
      final avatar = payload['avatar'] as String?;
      final country = payload['country'] as String?;
      final city = payload['city'] as String?;
      final createdAt = payload['created_at'] as String? ?? '';
      final phoneJson = payload['phone'] as Map<String, dynamic>?;
      final phone = phoneJson != null
          ? ProfilePhoneEntity(
              countryCode: phoneJson['country_code'] as String? ?? '',
              number: phoneJson['number'] as String? ?? '',
              full: phoneJson['full'] as String? ?? '',
            )
          : null;
      final statsJson = payload['stats'] as Map<String, dynamic>? ?? {};
      final stats = ProfileStatsEntity(
        tripsBooked: (statsJson['trips_booked'] as num?)?.toInt() ?? 0,
        reviews: (statsJson['reviews'] as num?)?.toInt() ?? 0,
        following: (statsJson['following'] as num?)?.toInt() ?? 0,
      );
      return ProfileEntity(
        id: id,
        name: name,
        email: email,
        avatar: avatar,
        phone: phone,
        country: country,
        city: city,
        stats: stats,
        createdAt: createdAt,
      );
    });
  }
}

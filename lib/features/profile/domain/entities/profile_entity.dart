class ProfilePhoneEntity {
  final String countryCode;
  final String number;
  final String full;

  const ProfilePhoneEntity({
    required this.countryCode,
    required this.number,
    required this.full,
  });
}

class ProfileStatsEntity {
  final int tripsBooked;
  final int reviews;
  final int following;

  const ProfileStatsEntity({
    required this.tripsBooked,
    required this.reviews,
    required this.following,
  });
}

class ProfileEntity {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  final ProfilePhoneEntity? phone;
  final String? country;
  final String? city;
  final ProfileStatsEntity stats;
  final String createdAt;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.phone,
    this.country,
    this.city,
    required this.stats,
    required this.createdAt,
  });
}

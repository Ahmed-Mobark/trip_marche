class ProfilePhoneModel {
  final String countryCode;
  final String number;
  final String full;

  const ProfilePhoneModel({
    required this.countryCode,
    required this.number,
    required this.full,
  });

  factory ProfilePhoneModel.fromJson(Map<String, dynamic> json) {
    return ProfilePhoneModel(
      countryCode: json['country_code'] as String? ?? '',
      number: json['number'] as String? ?? '',
      full: json['full'] as String? ?? '',
    );
  }
}

class ProfileStatsModel {
  final int tripsBooked;
  final int reviews;
  final int following;

  const ProfileStatsModel({
    required this.tripsBooked,
    required this.reviews,
    required this.following,
  });

  factory ProfileStatsModel.fromJson(Map<String, dynamic> json) {
    return ProfileStatsModel(
      tripsBooked: (json['trips_booked'] as num?)?.toInt() ?? 0,
      reviews: (json['reviews'] as num?)?.toInt() ?? 0,
      following: (json['following'] as num?)?.toInt() ?? 0,
    );
  }
}

class ProfileModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  final ProfilePhoneModel? phone;
  final String? country;
  final String? city;
  final ProfileStatsModel stats;
  final String createdAt;

  const ProfileModel({
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

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final phoneJson = data['phone'] as Map<String, dynamic>?;
    final statsJson = data['stats'] as Map<String, dynamic>? ?? {};
    return ProfileModel(
      id: (data['id'] as num?)?.toInt() ?? 0,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      avatar: data['avatar'] as String?,
      phone: phoneJson != null ? ProfilePhoneModel.fromJson(phoneJson) : null,
      country: data['country'] as String?,
      city: data['city'] as String?,
      stats: ProfileStatsModel.fromJson(statsJson),
      createdAt: data['created_at'] as String? ?? '',
    );
  }
}

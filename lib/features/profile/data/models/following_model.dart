class FollowingMetaModel {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const FollowingMetaModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory FollowingMetaModel.fromJson(Map<String, dynamic> json) {
    return FollowingMetaModel(
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      perPage: (json['per_page'] as num?)?.toInt() ?? 10,
      total: (json['total'] as num?)?.toInt() ?? 0,
    );
  }
}

class FollowingModel {
  final int id;
  final String name;
  final String avatar;
  final String company;
  final String about;
  final String website;
  final double rating;
  final int reviewsCount;
  final int tripsCount;
  final int followersCount;
  final bool isFollowing;

  const FollowingModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.company,
    required this.about,
    required this.website,
    required this.rating,
    required this.reviewsCount,
    required this.tripsCount,
    required this.followersCount,
    required this.isFollowing,
  });

  factory FollowingModel.fromJson(Map<String, dynamic> json) {
    return FollowingModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      company: json['company'] as String? ?? '',
      about: json['about'] as String? ?? '',
      website: json['website'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: (json['reviews_count'] as num?)?.toInt() ?? 0,
      tripsCount: (json['trips_count'] as num?)?.toInt() ?? 0,
      followersCount: (json['followers_count'] as num?)?.toInt() ?? 0,
      isFollowing: json['is_following'] as bool? ?? false,
    );
  }
}

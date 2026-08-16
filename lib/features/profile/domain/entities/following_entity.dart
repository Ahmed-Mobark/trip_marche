class FollowingMetaEntity {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const FollowingMetaEntity({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });
}

class FollowingEntity {
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

  const FollowingEntity({
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

  FollowingEntity copyWith({
    int? id,
    String? name,
    String? avatar,
    String? company,
    String? about,
    String? website,
    double? rating,
    int? reviewsCount,
    int? tripsCount,
    int? followersCount,
    bool? isFollowing,
  }) {
    return FollowingEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      company: company ?? this.company,
      about: about ?? this.about,
      website: website ?? this.website,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      tripsCount: tripsCount ?? this.tripsCount,
      followersCount: followersCount ?? this.followersCount,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}

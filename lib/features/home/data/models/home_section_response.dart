class HomeSectionsResponse {
  final List<HomeSectionModel> sections;

  const HomeSectionsResponse({required this.sections});

  factory HomeSectionsResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>? ?? [];
    return HomeSectionsResponse(
      sections: data
          .map((e) => HomeSectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class HomeSectionModel {
  final String key;
  final String title;
  final String itemType;
  final List<DestinationModel> destinations;
  final List<TripModel> trips;

  const HomeSectionModel({
    required this.key,
    required this.title,
    required this.itemType,
    this.destinations = const [],
    this.trips = const [],
  });

  factory HomeSectionModel.fromJson(Map<String, dynamic> json) {
    final itemType = json['item_type'] as String? ?? '';
    final items = json['items'] as List<dynamic>? ?? [];

    return HomeSectionModel(
      key: json['key'] as String? ?? '',
      title: json['title'] as String? ?? '',
      itemType: itemType,
      destinations: itemType == 'destination'
          ? items
                .map(
                  (e) => DestinationModel.fromJson(e as Map<String, dynamic>),
                )
                .toList()
          : [],
      trips: itemType == 'trip'
          ? items
                .map((e) => TripModel.fromJson(e as Map<String, dynamic>))
                .toList()
          : [],
    );
  }
}

class DestinationModel {
  final int id;
  final String name;
  final String slug;
  final String country;
  final String image;
  final int trendingRank;

  const DestinationModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.country,
    required this.image,
    required this.trendingRank,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      country: json['country'] as String? ?? '',
      image: json['image'] as String? ?? '',
      trendingRank: json['trending_rank'] as int? ?? 0,
    );
  }
}

class TripModel {
  final int id;
  final String title;
  final String slug;
  final String coverImage;
  final String fromLocation;
  final String startDate;
  final String endDate;
  final double price;
  final double? discountPrice;
  final String currency;
  final double rating;
  final int reviewsCount;
  final String? badge;
  final TripFlags flags;
  final bool isWishlisted;

  const TripModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.coverImage,
    required this.fromLocation,
    required this.startDate,
    required this.endDate,
    required this.price,
    this.discountPrice,
    this.currency = 'EGP',
    required this.rating,
    required this.reviewsCount,
    this.badge,
    required this.flags,
    required this.isWishlisted,
  });

  String get dateRange => '$startDate - $endDate';

  TripModel copyWith({
    int? id,
    String? title,
    String? slug,
    String? coverImage,
    String? fromLocation,
    String? startDate,
    String? endDate,
    double? price,
    double? discountPrice,
    String? currency,
    double? rating,
    int? reviewsCount,
    String? badge,
    TripFlags? flags,
    bool? isWishlisted,
  }) {
    return TripModel(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      coverImage: coverImage ?? this.coverImage,
      fromLocation: fromLocation ?? this.fromLocation,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      currency: currency ?? this.currency,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      badge: badge ?? this.badge,
      flags: flags ?? this.flags,
      isWishlisted: isWishlisted ?? this.isWishlisted,
    );
  }

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      coverImage: json['cover_image'] as String? ?? '',
      fromLocation: json['from_location'] as String? ?? '',
      startDate: json['start_date'] as String? ?? '',
      endDate: json['end_date'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPrice: (json['discount_price'] as num?)?.toDouble(),
      currency: (json['currency'] as String?)?.trim().isNotEmpty == true
          ? (json['currency'] as String).trim()
          : 'EGP',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: json['reviews_count'] as int? ?? 0,
      badge: json['badge'] as String?,
      flags: TripFlags.fromJson(json['flags'] as Map<String, dynamic>? ?? {}),
      isWishlisted: json['is_wishlisted'] as bool? ?? false,
    );
  }
}

class TripFlags {
  final bool popular;
  final bool sponsored;
  final bool recommended;
  final bool topRated;
  final bool special;
  final bool international;

  const TripFlags({
    this.popular = false,
    this.sponsored = false,
    this.recommended = false,
    this.topRated = false,
    this.special = false,
    this.international = false,
  });

  factory TripFlags.fromJson(Map<String, dynamic> json) {
    return TripFlags(
      popular: json['popular'] as bool? ?? false,
      sponsored: json['sponsored'] as bool? ?? false,
      recommended: json['recommended'] as bool? ?? false,
      topRated: json['top_rated'] as bool? ?? false,
      special: json['special'] as bool? ?? false,
      international: json['international'] as bool? ?? false,
    );
  }
}

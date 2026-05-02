import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';

class WishlistTripFlagsModel {
  const WishlistTripFlagsModel({
    required this.popular,
    required this.sponsored,
    required this.recommended,
    required this.topRated,
    required this.special,
    required this.international,
  });

  final bool popular;
  final bool sponsored;
  final bool recommended;
  final bool topRated;
  final bool special;
  final bool international;

  factory WishlistTripFlagsModel.fromJson(Map<String, dynamic> json) {
    return WishlistTripFlagsModel(
      popular: json['popular'] as bool? ?? false,
      sponsored: json['sponsored'] as bool? ?? false,
      recommended: json['recommended'] as bool? ?? false,
      topRated: json['top_rated'] as bool? ?? false,
      special: json['special'] as bool? ?? false,
      international: json['international'] as bool? ?? false,
    );
  }

  WishlistTripFlags toEntity() => WishlistTripFlags(
        popular: popular,
        sponsored: sponsored,
        recommended: recommended,
        topRated: topRated,
        special: special,
        international: international,
      );
}

class WishlistPaginationMetaModel {
  const WishlistPaginationMetaModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  factory WishlistPaginationMetaModel.fromJson(Map<String, dynamic> json) {
    return WishlistPaginationMetaModel(
      currentPage: json['current_page'] as int? ?? 1,
      lastPage: json['last_page'] as int? ?? 1,
      perPage: json['per_page'] as int? ?? 10,
      total: json['total'] as int? ?? 0,
    );
  }

  WishlistPaginationMeta toEntity() => WishlistPaginationMeta(
        currentPage: currentPage,
        lastPage: lastPage,
        perPage: perPage,
        total: total,
      );
}

class WishlistTripItemModel {
  const WishlistTripItemModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.coverImage,
    required this.fromLocation,
    required this.startDate,
    required this.endDate,
    required this.price,
    this.discountPrice,
    required this.rating,
    required this.reviewsCount,
    this.badge,
    required this.flags,
    required this.isWishlisted,
  });

  final int id;
  final String title;
  final String slug;
  final String coverImage;
  final String fromLocation;
  final String startDate;
  final String endDate;
  final double price;
  final double? discountPrice;
  final double rating;
  final int reviewsCount;
  final String? badge;
  final WishlistTripFlagsModel flags;
  final bool isWishlisted;

  factory WishlistTripItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistTripItemModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      coverImage: json['cover_image'] as String? ?? '',
      fromLocation: json['from_location'] as String? ?? '',
      startDate: json['start_date'] as String? ?? '',
      endDate: json['end_date'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPrice: (json['discount_price'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: json['reviews_count'] as int? ?? 0,
      badge: json['badge'] as String?,
      flags: WishlistTripFlagsModel.fromJson(
        json['flags'] as Map<String, dynamic>? ?? {},
      ),
      isWishlisted: json['is_wishlisted'] as bool? ?? false,
    );
  }

  WishlistTripItem toEntity() => WishlistTripItem(
        id: id,
        title: title,
        slug: slug,
        coverImage: coverImage,
        fromLocation: fromLocation,
        startDate: startDate,
        endDate: endDate,
        price: price,
        discountPrice: discountPrice,
        rating: rating,
        reviewsCount: reviewsCount,
        badge: badge,
        flags: flags.toEntity(),
        isWishlisted: isWishlisted,
      );
}

class WishlistTripsPageModel {
  const WishlistTripsPageModel({required this.trips, required this.meta});

  final List<WishlistTripItemModel> trips;
  final WishlistPaginationMetaModel meta;

  factory WishlistTripsPageModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>? ?? [];
    return WishlistTripsPageModel(
      trips: data
          .map((e) => WishlistTripItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: WishlistPaginationMetaModel.fromJson(
        json['meta'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  WishlistTripsPage toEntity() => WishlistTripsPage(
        trips: trips.map((e) => e.toEntity()).toList(),
        meta: meta.toEntity(),
      );
}

import 'package:equatable/equatable.dart';

/// Pure wishlist domain types (no JSON). Parsing: `features/wishlist/data/models/`.

class WishlistPaginationMeta extends Equatable {
  const WishlistPaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [currentPage, lastPage, perPage, total];
}

class WishlistTripFlags extends Equatable {
  const WishlistTripFlags({
    this.popular = false,
    this.sponsored = false,
    this.recommended = false,
    this.topRated = false,
    this.special = false,
    this.international = false,
  });

  final bool popular;
  final bool sponsored;
  final bool recommended;
  final bool topRated;
  final bool special;
  final bool international;

  @override
  List<Object?> get props =>
      [popular, sponsored, recommended, topRated, special, international];
}

class WishlistTripItem extends Equatable {
  const WishlistTripItem({
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
  final WishlistTripFlags flags;
  final bool isWishlisted;

  String get dateRange => '$startDate - $endDate';

  WishlistTripItem copyWith({
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
    WishlistTripFlags? flags,
    bool? isWishlisted,
  }) {
    return WishlistTripItem(
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

  @override
  List<Object?> get props => [
        id,
        title,
        slug,
        coverImage,
        fromLocation,
        startDate,
        endDate,
        price,
        discountPrice,
        currency,
        rating,
        reviewsCount,
        badge,
        flags,
        isWishlisted,
      ];
}

class WishlistTripsPage extends Equatable {
  const WishlistTripsPage({required this.trips, required this.meta});

  final List<WishlistTripItem> trips;
  final WishlistPaginationMeta meta;

  @override
  List<Object?> get props => [trips, meta];
}

class WishlistToggleResult extends Equatable {
  const WishlistToggleResult({
    required this.isWishlisted,
    required this.message,
  });

  final bool isWishlisted;
  final String message;

  @override
  List<Object?> get props => [isWishlisted, message];
}

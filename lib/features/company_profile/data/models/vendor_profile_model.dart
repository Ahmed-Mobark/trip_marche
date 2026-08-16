import 'package:trip_marche/core/utils/json_parser.dart';
import 'package:equatable/equatable.dart';

class VendorModel extends Equatable {
  const VendorModel({
    required this.id,
    required this.name,
    this.avatar,
    this.rating,
    this.reviewsCount,
    this.followersCount,
    this.tripsCount,
    this.isFollowing,
    this.isVerified,
  });

  final int id;
  final String name;
  final String? avatar;
  final double? rating;
  final int? reviewsCount;
  final int? followersCount;
  final int? tripsCount;
  final bool? isFollowing;
  final bool? isVerified;

  VendorModel copyWith({
    int? id,
    String? name,
    String? avatar,
    double? rating,
    int? reviewsCount,
    int? followersCount,
    int? tripsCount,
    bool? isFollowing,
    bool? isVerified,
  }) {
    return VendorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      followersCount: followersCount ?? this.followersCount,
      tripsCount: tripsCount ?? this.tripsCount,
      isFollowing: isFollowing ?? this.isFollowing,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'] as int? ?? 0,
      name: json['name']?.toString() ?? '',
      avatar: json['avatar']?.toString(),
      rating: (json['rating'] as num?)?.toDouble(),
      reviewsCount: json['reviews_count'] as int?,
      followersCount: json['followers_count'] as int?,
      tripsCount: json['trips_count'] as int?,
      isFollowing: JsonParser.asBool(json['is_following']),
      isVerified: JsonParser.asBool(json['verified'] ?? json['is_verified']),
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    avatar,
    rating,
    reviewsCount,
    followersCount,
    tripsCount,
    isFollowing,
    isVerified,
  ];
}

class ContactModel extends Equatable {
  const ContactModel({this.phone, this.phoneAlt, this.whatsapp, this.email});

  final String? phone;
  final String? phoneAlt;
  final String? whatsapp;
  final String? email;

  factory ContactModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const ContactModel();
    }
    return ContactModel(
      phone: json['phone']?.toString(),
      phoneAlt: json['phone_alt']?.toString(),
      whatsapp: json['whatsapp']?.toString(),
      email: json['email']?.toString(),
    );
  }

  @override
  List<Object?> get props => [phone, phoneAlt, whatsapp, email];
}

class SocialModel extends Equatable {
  const SocialModel({
    this.website,
    this.facebook,
    this.instagram,
    this.tiktok,
    this.youtube,
  });

  final String? website;
  final String? facebook;
  final String? instagram;
  final String? tiktok;
  final String? youtube;

  factory SocialModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const SocialModel();
    }
    return SocialModel(
      website: json['website']?.toString(),
      facebook: json['facebook']?.toString(),
      instagram: json['instagram']?.toString(),
      tiktok: json['tiktok']?.toString(),
      youtube: json['youtube']?.toString(),
    );
  }

  @override
  List<Object?> get props => [website, facebook, instagram, tiktok, youtube];
}

class CompanyDetailsModel extends Equatable {
  const CompanyDetailsModel({
    this.about,
    this.location,
    this.locationLat,
    this.locationLng,
    this.email,
    this.yearEstablished,
    this.commercialRegistration,
    this.businessLicense,
    this.taxCard,
  });

  final String? about;
  final String? location;
  final double? locationLat;
  final double? locationLng;
  final String? email;
  final String? yearEstablished;
  final String? commercialRegistration;
  final String? businessLicense;
  final String? taxCard;

  factory CompanyDetailsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const CompanyDetailsModel();
    }
    return CompanyDetailsModel(
      about: json['about']?.toString(),
      location: json['location']?.toString(),
      locationLat: (json['location_lat'] as num?)?.toDouble(),
      locationLng: (json['location_lng'] as num?)?.toDouble(),
      email: json['email']?.toString(),
      yearEstablished: json['year_established']?.toString(),
      commercialRegistration: json['commercial_registration']?.toString(),
      businessLicense: json['business_license']?.toString(),
      taxCard: json['tax_card']?.toString(),
    );
  }

  @override
  List<Object?> get props => [
    about,
    location,
    locationLat,
    locationLng,
    email,
    yearEstablished,
    commercialRegistration,
    businessLicense,
    taxCard,
  ];
}

class CategoryModel extends Equatable {
  const CategoryModel({required this.id, required this.name, this.slug});

  final int id;
  final String name;
  final String? slug;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int? ?? 0,
      name: json['name']?.toString() ?? '',
      slug: json['slug']?.toString(),
    );
  }

  @override
  List<Object?> get props => [id, name, slug];
}

class TeamMemberApiModel extends Equatable {
  const TeamMemberApiModel({
    required this.name,
    required this.title,
    this.avatar,
  });

  final String name;
  final String title;
  final String? avatar;

  factory TeamMemberApiModel.fromJson(Map<String, dynamic> json) {
    return TeamMemberApiModel(
      name: json['name']?.toString() ?? '',
      title: json['title']?.toString() ?? json['role']?.toString() ?? '',
      avatar: json['avatar']?.toString(),
    );
  }

  @override
  List<Object?> get props => [name, title, avatar];
}

class ReviewerModel extends Equatable {
  const ReviewerModel({
    required this.name,
    this.avatar,
    required this.country,
    required this.countryCode,
  });

  final String name;
  final String? avatar;
  final String country;
  final String countryCode;

  factory ReviewerModel.fromJson(Map<String, dynamic> json) {
    return ReviewerModel(
      name: json['name']?.toString() ?? '',
      avatar: json['avatar']?.toString(),
      country: json['country']?.toString() ?? '',
      countryCode:
          json['country_code']?.toString() ??
          json['countryCode']?.toString() ??
          '',
    );
  }

  @override
  List<Object?> get props => [name, avatar, country, countryCode];
}

class TripFlagsModel extends Equatable {
  const TripFlagsModel({
    required this.topRated,
    required this.recommended,
    required this.popular,
    required this.special,
  });

  final bool topRated;
  final bool recommended;
  final bool popular;
  final bool special;

  factory TripFlagsModel.fromJson(Map<String, dynamic> json) {
    return TripFlagsModel(
      topRated: JsonParser.asBool(json['top_rated']),
      recommended: JsonParser.asBool(json['recommended']),
      popular: JsonParser.asBool(json['popular']),
      special: JsonParser.asBool(json['special']),
    );
  }

  @override
  List<Object?> get props => [topRated, recommended, popular, special];
}

class AvailableTripModel extends Equatable {
  const AvailableTripModel({
    required this.id,
    required this.coverImage,
    required this.title,
    required this.rating,
    required this.reviewsCount,
    required this.fromLocation,
    required this.startDate,
    required this.endDate,
    required this.price,
    this.discountPrice,
    this.currency = '\$',
    required this.flags,
    this.isWishlisted = false,
    this.isFavorite = false,
  });

  final int id;
  final String coverImage;
  final String title;
  final double rating;
  final int reviewsCount;
  final String fromLocation;
  final String startDate;
  final String endDate;
  final double price;
  final double? discountPrice;
  final String currency;
  final TripFlagsModel flags;
  final bool isWishlisted;
  final bool isFavorite;

  factory AvailableTripModel.fromJson(Map<String, dynamic> json) {
    final rawCurrency = (json['currency']?.toString() ?? '').trim();
    return AvailableTripModel(
      id: json['id'] as int? ?? 0,
      coverImage: json['cover_image']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: json['reviews_count'] as int? ?? 0,
      fromLocation: json['from_location']?.toString() ?? '',
      startDate: json['start_date']?.toString() ?? '',
      endDate: json['end_date']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPrice: (json['discount_price'] as num?)?.toDouble(),
      currency: rawCurrency.isNotEmpty ? rawCurrency : '\$',
      flags: TripFlagsModel.fromJson(
        json['flags'] as Map<String, dynamic>? ?? {},
      ),
      isWishlisted: JsonParser.asBool(json['is_wishlisted']),
      isFavorite: JsonParser.asBool(json['is_favorite']),
    );
  }

  AvailableTripModel copyWith({
    int? id,
    String? coverImage,
    String? title,
    double? rating,
    int? reviewsCount,
    String? fromLocation,
    String? startDate,
    String? endDate,
    double? price,
    double? discountPrice,
    String? currency,
    TripFlagsModel? flags,
    bool? isWishlisted,
    bool? isFavorite,
  }) {
    return AvailableTripModel(
      id: id ?? this.id,
      coverImage: coverImage ?? this.coverImage,
      title: title ?? this.title,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      fromLocation: fromLocation ?? this.fromLocation,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      currency: currency ?? this.currency,
      flags: flags ?? this.flags,
      isWishlisted: isWishlisted ?? this.isWishlisted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  String? get primaryBadge {
    if (flags.topRated && flags.recommended) {
      return 'Top Rated';
    }
    if (flags.topRated) return 'Top Rated';
    if (flags.recommended) return 'Recommended';
    if (flags.popular) return 'Popular';
    if (flags.special) return 'Special';
    return null;
  }

  @override
  List<Object?> get props => [
    id,
    coverImage,
    title,
    rating,
    reviewsCount,
    fromLocation,
    startDate,
    endDate,
    price,
    discountPrice,
    currency,
    flags,
    isWishlisted,
    isFavorite,
  ];
}

class ReviewModelApi extends Equatable {
  const ReviewModelApi({
    required this.reviewer,
    required this.rating,
    required this.comment,
    required this.images,
    this.createdAt,
  });

  final ReviewerModel reviewer;
  final double rating;
  final String comment;
  final List<String> images;
  final String? createdAt;

  factory ReviewModelApi.fromJson(Map<String, dynamic> json) {
    final imagesJson = json['images'] as List<dynamic>? ?? [];
    return ReviewModelApi(
      reviewer: ReviewerModel.fromJson(
        json['reviewer'] as Map<String, dynamic>? ?? {},
      ),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      comment: json['comment']?.toString() ?? '',
      images: imagesJson.map((e) => e is String ? e : e.toString()).toList(),
      createdAt: json['created_at']?.toString(),
    );
  }

  @override
  List<Object?> get props => [reviewer, rating, comment, images, createdAt];
}

class FAQModelApi extends Equatable {
  const FAQModelApi({required this.question, required this.answer});

  final String question;
  final String answer;

  factory FAQModelApi.fromJson(Map<String, dynamic> json) {
    return FAQModelApi(
      question: json['question']?.toString() ?? '',
      answer: json['answer']?.toString() ?? '',
    );
  }

  @override
  List<Object?> get props => [question, answer];
}

class VendorProfileModel extends Equatable {
  const VendorProfileModel({
    required this.vendor,
    required this.contact,
    required this.social,
    required this.companyDetails,
    required this.categories,
    required this.team,
    required this.reviews,
    required this.availableTrips,
    required this.faqs,
  });

  final VendorModel vendor;
  final ContactModel contact;
  final SocialModel social;
  final CompanyDetailsModel companyDetails;
  final List<CategoryModel> categories;
  final List<TeamMemberApiModel> team;
  final List<ReviewModelApi> reviews;
  final List<AvailableTripModel> availableTrips;
  final List<FAQModelApi> faqs;

  VendorProfileModel copyWith({
    VendorModel? vendor,
    ContactModel? contact,
    SocialModel? social,
    CompanyDetailsModel? companyDetails,
    List<CategoryModel>? categories,
    List<TeamMemberApiModel>? team,
    List<ReviewModelApi>? reviews,
    List<AvailableTripModel>? availableTrips,
    List<FAQModelApi>? faqs,
  }) {
    return VendorProfileModel(
      vendor: vendor ?? this.vendor,
      contact: contact ?? this.contact,
      social: social ?? this.social,
      companyDetails: companyDetails ?? this.companyDetails,
      categories: categories ?? this.categories,
      team: team ?? this.team,
      reviews: reviews ?? this.reviews,
      availableTrips: availableTrips ?? this.availableTrips,
      faqs: faqs ?? this.faqs,
    );
  }

  factory VendorProfileModel.fromJson(Map<String, dynamic> json) {
    final dataPayload = json['data'] as Map<String, dynamic>? ?? json;
    final categoriesJson = dataPayload['categories'] as List<dynamic>? ?? [];
    final teamJson = dataPayload['team'] as List<dynamic>? ?? [];
    final reviewsJson = dataPayload['reviews'] as List<dynamic>? ?? [];
    final tripsJson = dataPayload['available_trips'] as List<dynamic>? ?? [];
    final faqsJson = dataPayload['faqs'] as List<dynamic>? ?? [];

    return VendorProfileModel(
      vendor: VendorModel.fromJson(dataPayload),
      contact: ContactModel.fromJson(dataPayload['contact'] as Map<String, dynamic>?),
      social: SocialModel.fromJson(dataPayload['social'] as Map<String, dynamic>?),
      companyDetails: CompanyDetailsModel.fromJson(
        dataPayload['company_details'] as Map<String, dynamic>?,
      ),
      categories: categoriesJson
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      team: teamJson
          .map((e) => TeamMemberApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: reviewsJson
          .map((e) => ReviewModelApi.fromJson(e as Map<String, dynamic>))
          .toList(),
      availableTrips: tripsJson
          .map((e) => AvailableTripModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      faqs: faqsJson
          .map((e) => FAQModelApi.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
    vendor,
    contact,
    social,
    companyDetails,
    categories,
    team,
    reviews,
    availableTrips,
    faqs,
  ];
}

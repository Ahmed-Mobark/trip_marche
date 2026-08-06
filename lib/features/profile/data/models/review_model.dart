import '../../domain/entities/review_entity.dart';

class ReviewTripModel {
  final int id;
  final int vendorId;
  final String title;
  final String coverImage;
  final bool isReviewed;
  final String fromLocation;
  final String startDate;
  final String endDate;

  const ReviewTripModel({
    required this.id,
    required this.vendorId,
    required this.title,
    required this.coverImage,
    required this.isReviewed,
    this.fromLocation = '',
    this.startDate = '',
    this.endDate = '',
  });

  factory ReviewTripModel.fromJson(Map<String, dynamic> json) {
    return ReviewTripModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      vendorId: (json['vendor_id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      coverImage: json['cover_image'] as String? ?? '',
      isReviewed: json['is_reviewed'] as bool? ?? false,
      fromLocation: json['from_location'] as String? ?? '',
      startDate: json['start_date'] as String? ?? '',
      endDate: json['end_date'] as String? ?? '',
    );
  }

  TripReviewEntity toEntity() {
    return TripReviewEntity(
      id: id,
      vendorId: vendorId,
      title: title,
      coverImage: coverImage,
      isReviewed: isReviewed,
      fromLocation: fromLocation,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

class ReviewVendorModel {
  final int id;
  final String name;
  final String avatar;

  const ReviewVendorModel({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory ReviewVendorModel.fromJson(Map<String, dynamic> json) {
    return ReviewVendorModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
    );
  }

  VendorReviewEntity toEntity() {
    return VendorReviewEntity(
      id: id,
      name: name,
      avatar: avatar,
    );
  }
}

class ReviewMetaModel {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const ReviewMetaModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory ReviewMetaModel.fromJson(Map<String, dynamic> json) {
    return ReviewMetaModel(
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      perPage: (json['per_page'] as num?)?.toInt() ?? 15,
      total: (json['total'] as num?)?.toInt() ?? 0,
    );
  }

  ReviewMetaEntity toEntity() {
    return ReviewMetaEntity(
      currentPage: currentPage,
      lastPage: lastPage,
      perPage: perPage,
      total: total,
    );
  }
}

class ReviewModel {
  final int id;
  final String type;
  final double rating;
  final String comment;
  final List<String> images;
  final String createdAt;
  final ReviewTripModel? trip;
  final ReviewVendorModel? vendor;

  const ReviewModel({
    required this.id,
    required this.type,
    required this.rating,
    required this.comment,
    this.images = const [],
    required this.createdAt,
    this.trip,
    this.vendor,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    final imagesList = (json['images'] as List<dynamic>? ?? [])
        .map((e) => e as String)
        .toList();

    return ReviewModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      type: json['type'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      comment: json['comment'] as String? ?? '',
      images: imagesList,
      createdAt: json['created_at'] as String? ?? '',
      trip: json['trip'] != null && json['trip'] is Map<String, dynamic>
          ? ReviewTripModel.fromJson(json['trip'] as Map<String, dynamic>)
          : null,
      vendor: json['vendor'] != null && json['vendor'] is Map<String, dynamic>
          ? ReviewVendorModel.fromJson(json['vendor'] as Map<String, dynamic>)
          : null,
    );
  }

  ReviewEntity toEntity() {
    return ReviewEntity(
      id: id,
      type: type,
      rating: rating,
      comment: comment,
      images: images,
      createdAt: createdAt,
      trip: trip?.toEntity(),
      vendor: vendor?.toEntity(),
    );
  }
}

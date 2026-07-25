import '../../domain/entities/review_entity.dart';

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
  final ReviewVendorModel? vendor;
  final String createdAt;

  const ReviewModel({
    required this.id,
    required this.type,
    required this.rating,
    required this.comment,
    this.vendor,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      type: json['type'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      comment: json['comment'] as String? ?? '',
      vendor: json['vendor'] != null && json['vendor'] is Map<String, dynamic>
          ? ReviewVendorModel.fromJson(json['vendor'] as Map<String, dynamic>)
          : null,
      createdAt: json['created_at'] as String? ?? '',
    );
  }

  ReviewEntity toEntity() {
    return ReviewEntity(
      id: id,
      type: type,
      rating: rating,
      comment: comment,
      vendorId: vendor?.id,
      vendorName: vendor?.name,
      vendorAvatar: vendor?.avatar,
      createdAt: createdAt,
    );
  }
}

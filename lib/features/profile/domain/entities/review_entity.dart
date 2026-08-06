import 'package:equatable/equatable.dart';

class TripReviewEntity {
  final int id;
  final int vendorId;
  final String title;
  final String coverImage;
  final bool isReviewed;
  final String fromLocation;
  final String startDate;
  final String endDate;

  const TripReviewEntity({
    required this.id,
    required this.vendorId,
    required this.title,
    required this.coverImage,
    required this.isReviewed,
    this.fromLocation = '',
    this.startDate = '',
    this.endDate = '',
  });
}

class VendorReviewEntity {
  final int id;
  final String name;
  final String avatar;

  const VendorReviewEntity({
    required this.id,
    required this.name,
    required this.avatar,
  });
}

class ReviewEntity extends Equatable {
  final int id;
  final String type;
  final double rating;
  final String comment;
  final List<String> images;
  final String createdAt;
  final TripReviewEntity? trip;
  final VendorReviewEntity? vendor;

  const ReviewEntity({
    required this.id,
    required this.type,
    required this.rating,
    required this.comment,
    this.images = const [],
    required this.createdAt,
    this.trip,
    this.vendor,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        rating,
        comment,
        images,
        createdAt,
        trip,
        vendor,
      ];
}

class ReviewMetaEntity {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const ReviewMetaEntity({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });
}

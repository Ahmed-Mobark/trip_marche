class ReviewEntity {
  final int id;
  final String type;
  final double rating;
  final String comment;
  final int? vendorId;
  final String? vendorName;
  final String? vendorAvatar;
  final String createdAt;

  const ReviewEntity({
    required this.id,
    required this.type,
    required this.rating,
    required this.comment,
    this.vendorId,
    this.vendorName,
    this.vendorAvatar,
    required this.createdAt,
  });
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

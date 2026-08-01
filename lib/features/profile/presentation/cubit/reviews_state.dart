import 'package:equatable/equatable.dart';
import '../../domain/entities/review_entity.dart';

enum ReviewsStatus { initial, loading, success, failure }

class ReviewsState extends Equatable {
  final ReviewsStatus status;
  final List<ReviewEntity> reviews;
  final ReviewMetaEntity? meta;
  final String? errorMessage;

  const ReviewsState({
    this.status = ReviewsStatus.initial,
    this.reviews = const [],
    this.meta,
    this.errorMessage,
  });

  ReviewsState copyWith({
    ReviewsStatus? status,
    List<ReviewEntity>? reviews,
    ReviewMetaEntity? meta,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ReviewsState(
      status: status ?? this.status,
      reviews: reviews ?? this.reviews,
      meta: meta ?? this.meta,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, reviews, meta, errorMessage];
}

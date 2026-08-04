class ReviewItemRequest {
  final String type;
  final int targetId;
  final int rating;
  final String comment;

  ReviewItemRequest({
    required this.type,
    required this.targetId,
    required this.rating,
    required this.comment,
  });

  Map<String, dynamic> toJson() => {
        'type': type,
        'target_id': targetId,
        'rating': rating,
        'comment': comment,
      };
}

class SubmitReviewRequest {
  final List<ReviewItemRequest> reviews;

  SubmitReviewRequest({required this.reviews});

  Map<String, dynamic> toJson() => {
        'reviews': reviews.map((e) => e.toJson()).toList(),
      };
}
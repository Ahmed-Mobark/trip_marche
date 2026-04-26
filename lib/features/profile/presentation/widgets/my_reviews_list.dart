import 'package:flutter/material.dart';
import 'review_card.dart';

class MyReviewsList extends StatelessWidget {
  const MyReviewsList({
    super.key,
    required this.reviews,
  });

  final List<Map<String, dynamic>> reviews;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: reviews.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final review = reviews[index];
        return ReviewCard(
          tripImage: review['tripImage'] as String,
          tripName: review['tripName'] as String,
          date: review['date'] as String,
          rating: review['rating'] as double,
          review: review['review'] as String,
        );
      },
    );
  }
}


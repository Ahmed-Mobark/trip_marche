import 'package:equatable/equatable.dart';

class WishlistFeedback extends Equatable {
  const WishlistFeedback({
    required this.message,
    required this.isError,
  });

  final String message;
  final bool isError;

  @override
  List<Object?> get props => [message, isError];
}

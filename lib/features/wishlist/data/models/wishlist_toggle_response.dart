import 'package:trip_marche/features/wishlist/domain/entities/wishlist_entities.dart';

class WishlistToggleResponse {
  const WishlistToggleResponse({
    required this.success,
    required this.message,
    required this.isWishlisted,
  });

  final bool success;
  final String message;
  final bool isWishlisted;

  factory WishlistToggleResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    var wishlisted = false;
    if (data is Map<String, dynamic>) {
      wishlisted = data['is_wishlisted'] as bool? ?? false;
    }
    return WishlistToggleResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      isWishlisted: wishlisted,
    );
  }

  WishlistToggleResult toEntity() => WishlistToggleResult(
        isWishlisted: isWishlisted,
        message: message,
      );
}

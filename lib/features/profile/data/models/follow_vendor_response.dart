import 'package:trip_marche/features/profile/domain/entities/follow_vendor_entity.dart';

class FollowVendorResponse {
  const FollowVendorResponse({
    required this.success,
    required this.message,
    required this.isFollowing,
  });

  final bool success;
  final String message;
  final bool isFollowing;

  factory FollowVendorResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    return FollowVendorResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      isFollowing: data['is_following'] as bool? ?? false,
    );
  }

  FollowVendorEntity toEntity() => FollowVendorEntity(
        isFollowing: isFollowing,
        message: message,
      );
}

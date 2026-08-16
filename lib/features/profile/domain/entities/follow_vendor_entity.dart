import 'package:equatable/equatable.dart';

class FollowVendorEntity extends Equatable {
  const FollowVendorEntity({
    required this.isFollowing,
    required this.message,
  });

  final bool isFollowing;
  final String message;

  @override
  List<Object?> get props => [isFollowing, message];
}

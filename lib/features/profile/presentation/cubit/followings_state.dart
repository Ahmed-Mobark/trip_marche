import 'package:equatable/equatable.dart';
import '../../domain/entities/following_entity.dart';

enum FollowingsStatus { initial, loading, success, failure }

class FollowingsState extends Equatable {
  final FollowingsStatus status;
  final List<FollowingEntity> companies;
  final String? errorMessage;
  final Set<int> busyVendorIds;
  final String? toggleMessage;
  final bool toggleMessageIsError;

  const FollowingsState({
    this.status = FollowingsStatus.initial,
    this.companies = const [],
    this.errorMessage,
    this.busyVendorIds = const {},
    this.toggleMessage,
    this.toggleMessageIsError = false,
  });

  FollowingsState copyWith({
    FollowingsStatus? status,
    List<FollowingEntity>? companies,
    String? errorMessage,
    Set<int>? busyVendorIds,
    String? toggleMessage,
    bool? toggleMessageIsError,
    bool clearError = false,
  }) {
    return FollowingsState(
      status: status ?? this.status,
      companies: companies ?? this.companies,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      busyVendorIds: busyVendorIds ?? this.busyVendorIds,
      toggleMessage: toggleMessage,
      toggleMessageIsError: toggleMessageIsError ?? this.toggleMessageIsError,
    );
  }

  @override
  List<Object?> get props => [
        status,
        companies,
        errorMessage,
        busyVendorIds,
        toggleMessage,
        toggleMessageIsError,
      ];
}

import 'package:equatable/equatable.dart';

enum UpdateProfileStatus { initial, loading, success, failure }

class UpdateProfileState extends Equatable {
  final UpdateProfileStatus status;
  final String? errorMessage;

  const UpdateProfileState({
    this.status = UpdateProfileStatus.initial,
    this.errorMessage,
  });

  UpdateProfileState copyWith({
    UpdateProfileStatus? status,
    String? errorMessage,
  }) {
    return UpdateProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}

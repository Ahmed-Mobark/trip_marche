import 'dart:io';

import 'package:equatable/equatable.dart';

enum UpdateProfileStatus { initial, loading, success, failure }

class UpdateProfileState extends Equatable {
  final UpdateProfileStatus status;
  final String? errorMessage;
  final File? selectedAvatarFile;
  final String? avatarPreviewPath;

  const UpdateProfileState({
    this.status = UpdateProfileStatus.initial,
    this.errorMessage,
    this.selectedAvatarFile,
    this.avatarPreviewPath,
  });

  UpdateProfileState copyWith({
    UpdateProfileStatus? status,
    String? errorMessage,
    File? selectedAvatarFile,
    String? avatarPreviewPath,
    bool clearError = false,
    bool clearAvatar = false,
  }) {
    return UpdateProfileState(
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      selectedAvatarFile: clearAvatar ? null : (selectedAvatarFile ?? this.selectedAvatarFile),
      avatarPreviewPath: clearAvatar ? null : (avatarPreviewPath ?? this.avatarPreviewPath),
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, selectedAvatarFile, avatarPreviewPath];
}

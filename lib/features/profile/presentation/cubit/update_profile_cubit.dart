import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/enums/media_type.dart';
import '../../../../core/services/media_service/media_services.dart';
import '../../../../core/injection/injection_container.dart';
import '../../data/models/profile_update_request.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this._updateProfileUseCase)
      : super(const UpdateProfileState());

  final UpdateProfileUseCase _updateProfileUseCase;

  Future<void> updateProfile({
    String? name,
    String? phoneCountryCode,
    String? phoneNumber,
    File? avatarFile,
  }) async {
    if (state.status == UpdateProfileStatus.loading) return;
    emit(state.copyWith(status: UpdateProfileStatus.loading, clearError: true));

    debugPrint("name: $name");
    debugPrint("phone_country_code: $phoneCountryCode");
    debugPrint("phone_number: $phoneNumber");
    debugPrint("avatar: ${avatarFile?.path}");

    final effectiveAvatar = avatarFile ?? state.selectedAvatarFile;

    final request = ProfileUpdateRequest(
      name: name,
      phoneCountryCode: phoneCountryCode,
      phoneNumber: phoneNumber,
      avatarFile: effectiveAvatar,
    );

    final result = await _updateProfileUseCase(request);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: UpdateProfileStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (_) {
        emit(state.copyWith(
          status: UpdateProfileStatus.success,
          errorMessage: null,
          clearAvatar: true,
        ));
      },
    );
  }

  Future<void> pickAvatarImage(BuildContext context) async {
    final mediaService = sl<MediaService>();
    final pickedFile = await mediaService.uploadImage(
      context,
      AppImageSource.gallery,
    );

    if (pickedFile == null || !context.mounted) return;

    emit(state.copyWith(
      selectedAvatarFile: pickedFile,
      avatarPreviewPath: pickedFile.path,
    ));
  }

  void setAvatarPreview(File file) {
    emit(state.copyWith(
      selectedAvatarFile: file,
      avatarPreviewPath: file.path,
    ));
  }

  void clearAvatar() {
    emit(state.copyWith(clearAvatar: true));
  }

  void reset() {
    emit(const UpdateProfileState());
  }
}

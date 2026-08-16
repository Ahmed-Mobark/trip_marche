import 'dart:io';

import 'package:flutter/material.dart';

import '../../enums/media_type.dart';
import '../../extensions/localization.dart';
import '../../injection/injection_container.dart';
import '../../toast/app_toast.dart';
import 'media_services.dart';
import 'media_service_exceptions.dart';

class ImagePickerHelper {
  static Future<File?> pickImage(
    BuildContext context,
    AppImageSource source,
  ) async {
    try {
      final mediaService = sl<MediaService>();
      final file = await mediaService.uploadImage(context, source);
      if (file != null && await file.exists()) {
        return file;
      }
      return null;
    } on PermissionException catch (_) {
      if (context.mounted) {
        appToast(
          context: context,
          type: ToastType.error,
          message: context.tr.profilePhotoPermissionRequired,
        );
      }
      return null;
    } on CameraUnavailableException catch (_) {
      if (context.mounted) {
        appToast(
          context: context,
          type: ToastType.error,
          message: context.tr.profilePhotoCameraUnavailable,
        );
      }
      return null;
    } on InvalidFileException catch (_) {
      if (context.mounted) {
        appToast(
          context: context,
          type: ToastType.error,
          message: context.tr.profilePhotoInvalidFile,
        );
      }
      return null;
    } on FileTooLargeException catch (_) {
      if (context.mounted) {
        appToast(
          context: context,
          type: ToastType.error,
          message: context.tr.profilePhotoTooLarge,
        );
      }
      return null;
    } catch (_) {
      if (context.mounted) {
        appToast(
          context: context,
          type: ToastType.error,
          message: context.tr.profilePhotoPickFailed,
        );
      }
      return null;
    }
  }
}

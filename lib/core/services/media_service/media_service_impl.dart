import 'dart:io';
import 'dart:math';
import '../../enums/media_type.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'media_services.dart';
import 'media_service_exceptions.dart';

class MediaServiceImpl implements MediaService {
  @override
  Future<File?> uploadImage(
    BuildContext context,
    AppImageSource appImageSource,
  ) async {
    try {
      File? processedPickedImageFile;
      ImageSource? imageSource = ImageSource.values.byName(appImageSource.name);
      final imagePicker = ImagePicker();
      final rawPickedImageFile = await imagePicker.pickImage(
        source: imageSource,
        imageQuality: 50,
      );
      if (rawPickedImageFile != null) {
        processedPickedImageFile = File(rawPickedImageFile.path);
        if (!await processedPickedImageFile.exists()) {
          throw InvalidFileException('Selected file does not exist');
        }
        processedPickedImageFile = await compressFile(processedPickedImageFile);
        if (processedPickedImageFile == null) {
          throw InvalidFileException('Failed to process image');
        }
        return processedPickedImageFile;
      }
      return null;
    } on PlatformException catch (e) {
      if (e.code == 'camera_access_denied' ||
          e.code == 'photo_access_denied' ||
          e.code == 'permission_denied') {
        throw PermissionException(e.message ?? 'Permission denied');
      }
      if (e.code == 'camera_unavailable') {
        throw CameraUnavailableException(e.message ?? 'Camera unavailable');
      }
      throw Exception(e.message ?? 'Failed to pick image');
    } catch (e) {
      if (e is PermissionException ||
          e is CameraUnavailableException ||
          e is InvalidFileException) {
        rethrow;
      }
      throw Exception('Failed to pick image: $e');
    }
  }

  @override
  Future<List<File?>?> uploadMultiImage(BuildContext context) async {
    try {
      List<File?> pickedImageFiles = [];
      final imagePicker = ImagePicker();
      final rawPickedImageFiles = await imagePicker.pickMultiImage(
        imageQuality: 50,
      );
      if (rawPickedImageFiles.isNotEmpty) {
        pickedImageFiles.clear();
        for (var file in rawPickedImageFiles) {
          final processedPickedImageFile = await compressFile(File(file.path));
          pickedImageFiles.add(processedPickedImageFile);
        }
        return pickedImageFiles;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<File?>?> uploadFiles(BuildContext context) async {
    try {
      List<File?> pickedFiles = [];
      final rawPickedFiles = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );
      if (rawPickedFiles != null && rawPickedFiles.paths.isNotEmpty) {
        pickedFiles.clear();
        for (var path in rawPickedFiles.paths) {
          String extension = path!.split('.').last.toLowerCase();
          if (extension == 'png' ||
              extension == 'jpg' ||
              extension == 'jpeg' ||
              extension == 'heic') {
            final processedPickedFile = await compressFile(File(path));
            pickedFiles.add(processedPickedFile);
          } else {
            pickedFiles.add(File(path));
          }
        }
        return pickedFiles;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<File?> compressFile(File file, {int quality = 30}) async {
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath =
        '${dir.absolute.path}/${Random().nextInt(1000)}-temp.jpg';
    XFile? compressedXFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: quality,
    );
    File? compressedFile = compressedXFile != null
        ? File(compressedXFile.path)
        : null;
    return compressedFile;
  }
}

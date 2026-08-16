import 'dart:io';

import 'package:dio/dio.dart';

class ProfileUpdateRequest {
  final String? name;
  final String? phoneCountryCode;
  final String? phoneNumber;
  final File? avatarFile;

  const ProfileUpdateRequest({
    this.name,
    this.phoneCountryCode,
    this.phoneNumber,
    this.avatarFile,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (name != null && name!.trim().isNotEmpty) {
      map['name'] = name!.trim();
    }
    if (phoneCountryCode != null && phoneCountryCode!.trim().isNotEmpty) {
      map['phone_country_code'] = phoneCountryCode!.trim();
    }
    if (phoneNumber != null && phoneNumber!.trim().isNotEmpty) {
      map['phone_number'] = phoneNumber!.trim();
    }
    return map;
  }

  Future<FormData?> toFormData() async {
    final hasAnyField = name != null ||
        phoneCountryCode != null ||
        phoneNumber != null ||
        avatarFile != null;
    if (!hasAnyField) return null;

    final formData = FormData();
    final json = toJson();
    for (final entry in json.entries) {
      formData.fields.add(MapEntry(entry.key, entry.value.toString()));
    }
    if (avatarFile != null) {
      formData.files.add(MapEntry(
        'avatar',
        await MultipartFile.fromFile(
          avatarFile!.path,
          filename: avatarFile!.path.split('/').last,
        ),
      ));
    }
    return formData;
  }
}

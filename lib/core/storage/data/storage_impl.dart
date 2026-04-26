import 'storage.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

class StorageImpl implements Storage {
  final Box<String> stringBox;
  final Box<bool> boolBox;
  // final Box<UserModel> userBox;

  static const String _user = "user";
  static const String _token = "token";
  static const String _language = "language";
  static const String _onboarding = "onboarding";

  StorageImpl({required this.stringBox, required this.boolBox});

  //* user storage
  @override
  Future<void> storeUser({required Map<String, dynamic> userJson}) async {
    await stringBox.put(_user, jsonEncode(userJson));
  }

  @override
  Map<String, dynamic>? getUserJson() {
    final raw = stringBox.get(_user);
    if (raw == null || raw.isEmpty) return null;
    final decoded = jsonDecode(raw);
    return decoded is Map<String, dynamic> ? decoded : null;
  }

  @override
  Future<void> deleteUser() async {
    await stringBox.delete(_user);
  }

  //* token storage
  @override
  Future<void> storeToken({required String token}) async {
    await stringBox.put(_token, token);
  }

  @override
  String? getToken() => stringBox.get(_token);

  @override
  Future<void> deleteToken() async {
    await stringBox.delete(_token);
  }

  //* onboarding storage
  @override
  bool isOnboardingCompleted() => boolBox.get(_onboarding) ?? false;

  @override
  Future<void> storeOnboardingCompleted({
    required bool isOnboardingCompleted,
  }) async {
    await boolBox.put(_onboarding, isOnboardingCompleted);
  }

  //* language storage
  @override
  Future<void> storeLang({required String langCode}) async {
    await stringBox.put(_language, langCode);
  }

  @override
  String getLang() => stringBox.get(_language) ?? "en";

  @override
  Future<void> deleteLang() async {
    await stringBox.delete(_language);
  }

  //* check token
  @override
  bool isAuthorized() => stringBox.get(_token) != null;

  //* check language
  @override
  bool isSelectLang() => stringBox.get(_language) != null;
}

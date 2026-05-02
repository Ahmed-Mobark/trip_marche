abstract class Storage {
  // User Storage
  Future<void> storeUser({required Map<String, dynamic> userJson});
  Map<String, dynamic>? getUserJson();
  Future<void> deleteUser();

  // Token Storage
  Future<void> storeToken({required String token});
  String? getToken();
  Future<void> deleteToken();

  // Check Token
  bool isAuthorized();

  // Check Onboarding
  bool isOnboardingCompleted();
  Future<void> storeOnboardingCompleted({required bool isOnboardingCompleted});

  // Language Storage
  Future<void> storeLang({required String langCode});
  String getLang();
  Future<void> deleteLang();

  // Check Language
  bool isSelectLang();

  // Theme Storage
  /// Persists the active app theme mode (`light`, `dark` or `system`).
  Future<void> storeThemeMode({required String themeMode});

  /// Returns the persisted theme mode key, or `null` when never set.
  String? getThemeMode();

  Future<void> deleteThemeMode();
}

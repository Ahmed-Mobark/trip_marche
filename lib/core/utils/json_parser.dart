class JsonParser {
  static bool asBool(dynamic v, [bool fallback = false]) {
    if (v is bool) {
      return v;
    }
    if (v is num) {
      return v != 0;
    }
    if (v is String) {
      final s = v.toLowerCase();
      return s == '1' || s == 'true' || s == 'yes';
    }
    return fallback;
  }

  static bool parseFavorite(dynamic value) {
    if (value is bool) return value;
    if (value is int) return value == 1;
    if (value is String) {
      return value == '1' || value.toLowerCase() == 'true';
    }
    return false;
  }
}

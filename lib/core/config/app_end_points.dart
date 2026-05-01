class AppEndpoints {
  static String baseUrl = "https://api.tripmarche.com/api/";

  static const String authRegister = "auth/register";
  static const String authLogin = "auth/login";
  static const String authVerifyEmail = "auth/verify-email";
  static const String authSendOtp = "auth/send-otp";
  static const String authVerifyOtp = "auth/verify-otp";
  static const String authResetPassword = "auth/reset-password";
  static const String authLogout = "auth/logout";

  // Home
  static const String homeSections = "home/sections";
  static const String homeBanners = "home/banners";
  static const String homeCategories = "home/categories";
  static const String homeSpecialTrips = "home/special-trips";

  /// GET — paginated trips catalog (query: page, per_page, search?, destination_id?).
  static const String trips = 'trips';

  /// GET — paginated wishlist (query: current_page, per_page).
  static const String wishlist = 'wishlist';

  /// POST — toggles wishlist for [tripId]. Response includes `is_wishlisted`.
  static String wishlistToggle(int tripId) => 'wishlist/$tripId/toggle';
}

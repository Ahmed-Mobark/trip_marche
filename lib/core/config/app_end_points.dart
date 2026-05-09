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
  static const String homeTrendingDestinationsItems =
      "home/sections/trending_destinations/items";
  static const String homePopularTripsItems =
      "home/sections/popular_trips/items";
  static const String homeSponsoredTripsItems =
      "home/sections/sponsored_trips/items";
  static const String homeDomesticTripsItems =
      "home/sections/domestic_trips/items";
  static const String homeInternationalTripsItems =
      "home/sections/international_trips/items";
  static const String homeRecommendedForYouItems =
      "home/sections/recommended_for_you/items";
  static const String destinations = "destinations";

  /// POST — paginated trips catalog (body: page, per_page, search?, destination_id?).
  static const String trips = 'trips';
  static const String tripsFilters = 'trips/filters';

  /// POST — trip detail by id (body may be empty `{}`).
  static String tripById(int tripId) => 'trips/$tripId';

  /// GET — paginated wishlist (query: current_page, per_page).
  static const String wishlist = 'wishlist';

  /// POST — toggles wishlist for [tripId]. Response includes `is_wishlisted`.
  static String wishlistToggle(int tripId) => 'wishlist/$tripId/toggle';
}

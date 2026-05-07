class AppImages {
  static const String _iconsPath = 'assets/icons/';
  static const String _imagesPath = 'assets/images/';

  // Image paths
  /// Fallback bundled image used by screens that do not have a dedicated asset.
  static const String _fallbackPng = '${_iconsPath}app_icon_bg.png';

  static const String loginIllustration = _fallbackPng;

  static const String avatarPlaceholder = _fallbackPng;
  static const String companyPlaceholder = _fallbackPng;
  static const String tripPlaceholder = _fallbackPng;
  static const String searchResultTrip1 =
      '${_imagesPath}search_result_trip_1.png';
  static const String searchResultTrip2 =
      '${_imagesPath}search_result_trip_2.png';
  static const String searchResultTrip3 =
      '${_imagesPath}search_result_trip_3.png';

  static const String logo = _fallbackPng;
  static const String logoApp = _fallbackPng;
  static const String logoSmall = _fallbackPng;
  static const String splashLogo = _fallbackPng;
  static const String onBoarding = _fallbackPng;
  static const String onboarding1 = _fallbackPng;
  static const String onboarding2 = _fallbackPng;
  static const String onboarding3 = _fallbackPng;
  static const String onboarding4 = _fallbackPng;

  /// Trip details accommodation map chip (replace with Figma export for pixel parity).
  static const String tripDetailsMapMarker =
      '${_iconsPath}trip_details_map_marker.svg';
}

/// Splash and other video/GIF assets under assets/videos/
class AppVideos {
  static const String _path = 'assets/videos/';
  static const String splashVideo = '${_path}splash_video.gif';
}

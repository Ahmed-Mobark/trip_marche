class AppImages {
  static const String _iconsPath = 'assets/icons/';

  // Image paths
  /// Note: this repo currently doesn't include `assets/images/` files.
  /// Keep these constants pointing to bundled assets to prevent runtime crashes.
  static const String _fallbackPng = '${_iconsPath}app_icon_bg.png';

  static const String loginIllustration = _fallbackPng;

  static const String avatarPlaceholder = _fallbackPng;
  static const String companyPlaceholder = _fallbackPng;
  static const String tripPlaceholder = _fallbackPng;

  static const String logo = _fallbackPng;
  static const String logoApp = _fallbackPng;
  static const String logoSmall = _fallbackPng;
  static const String splashLogo = _fallbackPng;
  static const String onBoarding = _fallbackPng;
  static const String onboarding1 = _fallbackPng;
  static const String onboarding2 = _fallbackPng;
  static const String onboarding3 = _fallbackPng;
  static const String onboarding4 = _fallbackPng;

}

/// Splash and other video/GIF assets under assets/videos/
class AppVideos {
  static const String _path = 'assets/videos/';
  static const String splashVideo = '${_path}splash_video.gif';
}

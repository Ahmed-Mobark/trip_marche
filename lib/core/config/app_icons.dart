import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  AppIcons._();

  static const String _path = 'assets/icons/';

  // Icon paths
  static const String icSms = '${_path}ic_sms.svg';
  static const String icLock = '${_path}ic_lock.svg';
  static const String icEyeSlash = '${_path}ic_eye_slash.svg';
  static const String icGoogle = '${_path}ic_google.svg';
  static const String icApple = '${_path}ic_apple.svg';
  static const String icLogo = '${_path}ic_logo.svg';

  static const String lloPng = '${_path}llo.png';
  static const String llo2Png = '${_path}llog2.png';
  static const String logoPng = '${_path}logo.png';

  static const String unseen = '${_path}unseen.svg';
  static const String seen = '${_path}seen.svg';
  static const String close = '${_path}close.svg';
  static const String camera = '${_path}camera.svg';
  static const String gallery = '${_path}gallery.svg';
  static const String file = '${_path}file.svg';
  static const String basket = '${_path}basket.png';
  static const String filter = '${_path}filter.png';
  static const String homeIcon = '${_path}home_icon.png';
  static const String productsIcon = '${_path}products_icon.png';
  static const String projectsIcon = '${_path}projects_icon.png';
  static const String contactIcon = '${_path}contact_us_icon.png';
  static const String languageIcon = '${_path}language_icon.png';
  static const String googleIcon = '${_path}google_icon.svg';
  static const String appleIcon = '${_path}apple_icon.svg';
  static const String verifyIcon = '${_path}verify_number.svg';
  static const String authIllustration = '${_path}auth_illustration.svg';
  static const String bookIcon = '${_path}book_icon.png';
  static const String homeIconSvg = '${_path}home_icon.svg';
  static const String homeIconFilledSvg = '${_path}home_icon_filled.svg';
  static const String tripsIconSvg = '${_path}trips_icon.svg';
  static const String tripsIconFilledSvg = '${_path}trips_icon_filled.svg';
  static const String wishlistIconSvg = '${_path}wishlist_icon.svg';
  static const String wishlistIconFilledSvg = '${_path}wishlist_icon_filled.svg';
  static const String accountIconSvg = '${_path}account_icon.svg';
  static const String accountIconFilledSvg = '${_path}account_icon_filled.svg';
  static const String googleMapsIcon = '${_path}google-map-icon.svg';

  // Method to render SVG as a widget
  static Widget icon({required String icon, double size = 24, Color? color}) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        icon,
        fit: BoxFit.contain,
        colorFilter: color == null
            ? null
            : ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}

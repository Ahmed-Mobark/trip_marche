import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF9B36D5);
  static const Color primaryDark = Color(0xFF511C6F);

  // Accent
  static const Color accent = Color(0xFFFBB532);
  static const Color accentGold = Color(0xFFFBB532);

  // Text
  static const Color darkText = Color(0xFF131213);
  static const Color secondaryText = Color(0xFF373F46);
  static const Color greyText = Color(0xFF7C818A);
  static const Color lightGrey = Color(0xFF556371);

  // Borders
  static const Color border = Color(0xFFE5E7EB);
  static const Color lightBorder = Color(0xFFD5D9DF);

  // Backgrounds
  static const Color background = Color(0xFFFFFFFF);
  static const Color lightBg = Color(0xFFFAFAFA);
  static const Color cardBg = Color(0xFFFEFCFF);
  static const Color inputBg = Color(0xFFE8ECF4);
  static const Color darkBg = Color(0xFF28282A);
  static const Color darkBgAlt = Color(0xFF263238);

  // Error / Red
  static const Color error = Color(0xFFF32858);
  static const Color errorAlt = Color(0xFFE91A1A);

  // Star
  static const Color starYellow = Color(0xFFFFD43B);

  // Figma purple
  static const Color figmaPurple = Color(0xFF9747FF);

  // White
  static const Color white = Color(0xFFFFFFFF);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF9B36D5), Color(0xFF511C6F)],
  );
}

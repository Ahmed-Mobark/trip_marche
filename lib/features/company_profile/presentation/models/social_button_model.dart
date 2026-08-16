import 'package:flutter/material.dart';

class SocialButtonModel {
  const SocialButtonModel({
    required this.icon,
    required this.iconColor,
    required this.borderColor,
    this.onTap,
  });

  final Widget icon;
  final Color iconColor;
  final Color borderColor;
  final VoidCallback? onTap;
}

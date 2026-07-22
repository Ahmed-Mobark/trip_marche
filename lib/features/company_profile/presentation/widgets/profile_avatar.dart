import 'package:flutter/material.dart';

import '../../../../core/config/app_images.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.imageUrl,
    required this.size,
    this.borderRadius,
    this.fallbackAsset,
  });

  final String imageUrl;
  final double size;
  final double? borderRadius;
  final String? fallbackAsset;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? size / 2;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: borderRadius == null ? BoxShape.circle : BoxShape.rectangle,
          border: Border.all(color: AppColors.surfaceDivider(context)),
        ),
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.asset(
                  fallbackAsset ?? AppImages.logo,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                ),
              )
            : Image.asset(
                fallbackAsset ?? AppImages.logo,
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

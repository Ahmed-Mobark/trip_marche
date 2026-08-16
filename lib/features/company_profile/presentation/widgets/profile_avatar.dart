import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_cached_network_image.dart';

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
        child: AppCachedNetworkImage(
          imageUrl: imageUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

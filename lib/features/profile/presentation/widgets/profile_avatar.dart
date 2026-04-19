import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/config/app_images.dart';

class ProfileAvatar extends StatelessWidget {
  final double radius;
  final ImageProvider? backgroundImage;
  final IconData editIcon;
  final double editButtonSize;
  final double editIconSize;
  final VoidCallback? onEditTap;

  const ProfileAvatar({
    super.key,
    this.radius = 40,
    this.backgroundImage,
    this.editIcon = Iconsax.edit_2,
    this.editButtonSize = 28,
    this.editIconSize = 14,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: AppColors.lightBg,
          backgroundImage: backgroundImage ??
              const AssetImage(AppImages.avatarPlaceholder),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onEditTap,
            child: Container(
              width: editButtonSize,
              height: editButtonSize,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                editIcon,
                color: Colors.white,
                size: editIconSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

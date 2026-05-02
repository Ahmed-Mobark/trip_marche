import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/config/app_images.dart';

class ProfileAvatar extends StatelessWidget {
  final double radius;
  final double borderRadius;
  final ImageProvider? backgroundImage;
  final IconData editIcon;
  final double editButtonSize;
  final double editIconSize;
  final VoidCallback? onEditTap;

  const ProfileAvatar({
    super.key,
    this.radius = 40,
    this.borderRadius = 16,
    this.backgroundImage,
    this.editIcon = Iconsax.edit_2,
    this.editButtonSize = 28,
    this.editIconSize = 14,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = radius * 2;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: AppColors.lightBg,
              image: DecorationImage(
                image:
                    backgroundImage ??
                    const AssetImage(AppImages.avatarPlaceholder),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        PositionedDirectional(
          bottom: 0,
          end: 0,
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
                color: AppColors.onImage,
                size: editIconSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

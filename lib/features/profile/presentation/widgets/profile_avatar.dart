import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/theme/app_colors.dart';
import '../theme/profile_handoff_tokens.dart';

/// Profile photo — Figma **1:22365**: 108×108 @ 430 frame, corner radius ~11.32,
/// camera control bottom-end, rgba black 60% + white hairline border.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.backgroundImage,
    this.editIcon = Iconsax.camera,
    this.onEditTap,
  });

  final ImageProvider? backgroundImage;
  final IconData editIcon;
  final VoidCallback? onEditTap;

  @override
  Widget build(BuildContext context) {
    final t = ProfileHandoffTokens.of(context);
    final side = t.w(80);
    final rRect = t.w(8.4);
    final editSize = t.w(28);
    final editIconExtent = t.w(11);
    final borderW = t.w(0.713);
    final hasImage = backgroundImage != null;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(rRect),
          child: Container(
            width: side,
            height: side,
            decoration: BoxDecoration(
              color: AppColors.lightBg(context),
              image: hasImage
                  ? DecorationImage(
                      image: backgroundImage!,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            alignment: Alignment.center,
            child: hasImage
                ? null
                : Icon(
                    Iconsax.user,
                    size: side * 0.42,
                    color: AppColors.greyText(context),
                  ),
          ),
        ),
        PositionedDirectional(
          bottom: 0,
          end: 0,
          child: GestureDetector(
            onTap: onEditTap,
            child: Container(
              width: editSize,
              height: editSize,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.60),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white,
                  width: borderW.clamp(0.5, 1.5),
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                editIcon,
                color: AppColors.onImage,
                size: editIconExtent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

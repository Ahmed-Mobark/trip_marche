import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/data/dummy_data.dart';

class DestinationGridItem extends StatelessWidget {
  final DestinationItem destination;
  final VoidCallback? onTap;

  const DestinationGridItem({super.key, required this.destination, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: destination.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(color: AppColors.inputBg(context)),
              errorWidget: (context, url, error) => Container(
                color: AppColors.inputBg(context),
                child: Icon(Icons.image, color: AppColors.greyText(context)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.transparent,
                    AppColors.shadow.withValues(alpha: 0.55),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                destination.name,
                style: AppTextStyles.subtitle(
                  color: AppColors.onImage,
                ).copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

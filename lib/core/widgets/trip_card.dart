import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/data/dummy_data.dart';

/// Compact trip card for horizontal lists (~180w x 230h)
class TripCard extends StatelessWidget {
  final TripItem trip;
  final double width;
  final double height;
  final VoidCallback? onTap;

  const TripCard({
    super.key,
    required this.trip,
    this.width = 180,
    this.height = 230,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: trip.imageUrl,
                    width: width,
                    height: height * 0.45,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppColors.inputBg,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.inputBg,
                      child: const Icon(
                        Icons.image_not_supported,
                        color: AppColors.greyText,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      trip.isFavorite ? Iconsax.heart5 : Iconsax.heart,
                      size: 16,
                      color: trip.isFavorite
                          ? AppColors.error
                          : AppColors.greyText,
                    ),
                  ),
                ),
                if (trip.badge != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        trip.badge!,
                        style: AppTextStyles.caption(
                          color: AppColors.white,
                        ).copyWith(fontSize: 10, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
              ],
            ),
            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.title,
                      style: AppTextStyles.subtitle().copyWith(fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.star1,
                          size: 12,
                          color: AppColors.starYellow,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${trip.rating}',
                          style: AppTextStyles.bodySmall().copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          ' (${trip.reviewCount})',
                          style: AppTextStyles.caption().copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      trip.location,
                      style: AppTextStyles.caption().copyWith(fontSize: 11),
                    ),
                    Text(
                      trip.dateRange,
                      style: AppTextStyles.caption().copyWith(fontSize: 11),
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${trip.price.toInt()}',
                          style: AppTextStyles.subtitle(
                            color: AppColors.primary,
                          ).copyWith(fontSize: 15),
                        ),
                        const SizedBox(width: 2),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 1),
                          child: Text(
                            '/Person',
                            style: AppTextStyles.caption().copyWith(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Wide trip card for special trips vertical list (image left, info right)
class TripCardWide extends StatelessWidget {
  final TripItem trip;
  final VoidCallback? onTap;

  const TripCardWide({super.key, required this.trip, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: trip.imageUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 120,
                      height: 120,
                      color: AppColors.inputBg,
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 120,
                      height: 120,
                      color: AppColors.inputBg,
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                  if (trip.badge != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          trip.badge!,
                          style: AppTextStyles.caption(
                            color: AppColors.darkText,
                          ).copyWith(fontSize: 10, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.title,
                      style: AppTextStyles.subtitle().copyWith(fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.star1,
                          size: 12,
                          color: AppColors.starYellow,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${trip.rating}',
                          style: AppTextStyles.caption(
                            color: AppColors.darkText,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          ' (${trip.reviewCount})',
                          style: AppTextStyles.caption(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.location,
                          size: 12,
                          color: AppColors.greyText,
                        ),
                        const SizedBox(width: 4),
                        Text(trip.location, style: AppTextStyles.caption()),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.calendar_1,
                          size: 12,
                          color: AppColors.greyText,
                        ),
                        const SizedBox(width: 4),
                        Text(trip.dateRange, style: AppTextStyles.caption()),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        if (trip.oldPrice != null) ...[
                          Text(
                            '\$${trip.oldPrice!.toInt()}',
                            style: AppTextStyles.caption().copyWith(
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          '\$${trip.price.toInt()}',
                          style: AppTextStyles.subtitle(
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          '/Person',
                          style: AppTextStyles.caption().copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                trip.isFavorite ? Iconsax.heart5 : Iconsax.heart,
                size: 20,
                color: trip.isFavorite ? AppColors.error : AppColors.greyText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Grid trip card for wishlist / search results (2-column grid)
class TripCardGrid extends StatelessWidget {
  final TripItem trip;
  final VoidCallback? onTap;

  const TripCardGrid({super.key, required this.trip, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: trip.imageUrl,
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(height: 120, color: AppColors.inputBg),
                    errorWidget: (context, url, error) => Container(
                      height: 120,
                      color: AppColors.inputBg,
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      trip.isFavorite ? Iconsax.heart5 : Iconsax.heart,
                      size: 16,
                      color: trip.isFavorite
                          ? AppColors.error
                          : AppColors.greyText,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip.title,
                    style: AppTextStyles.subtitle().copyWith(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Iconsax.star1,
                        size: 11,
                        color: AppColors.starYellow,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${trip.rating}',
                        style: AppTextStyles.caption(
                          color: AppColors.darkText,
                        ).copyWith(fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        ' (${trip.reviewCount})',
                        style: AppTextStyles.caption().copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    trip.location,
                    style: AppTextStyles.caption().copyWith(fontSize: 11),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '\$${trip.price.toInt()}',
                        style: AppTextStyles.subtitle(
                          color: AppColors.primary,
                        ).copyWith(fontSize: 14),
                      ),
                      Text(
                        '/Person',
                        style: AppTextStyles.caption().copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

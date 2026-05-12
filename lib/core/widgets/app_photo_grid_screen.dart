import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import 'package:trip_marche/core/widgets/app_image_gallery_screen.dart';

/// 2-column photo grid (like Get Your Guide). Tapping any photo opens the
/// full-screen swipe viewer at that index.
class AppPhotoGridScreen extends StatelessWidget {
  const AppPhotoGridScreen({super.key, required this.imageUrls});

  final List<String> imageUrls;

  static Future<void> open(
    BuildContext context, {
    required List<String> imageUrls,
  }) {
    final urls =
        imageUrls.map((u) => u.trim()).where((u) => u.isNotEmpty).toList();
    if (urls.isEmpty) return Future.value();
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => AppPhotoGridScreen(imageUrls: urls),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBg(context),
      appBar: AppBar(
        backgroundColor: AppColors.cardBg(context),
        elevation: 0,
        scrolledUnderElevation: 0.5,
        leading: Padding(
          padding: EdgeInsetsDirectional.only(start: 8.w, top: 4.h),
          child: _CircleCloseButton(
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          '${imageUrls.length} Photos',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.darkText(context),
          ),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsetsDirectional.all(8.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.h,
          crossAxisSpacing: 8.w,
          childAspectRatio: 1.0,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => AppImageGalleryScreen.open(
              context,
              imageUrls: imageUrls,
              initialIndex: index,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: AppCachedNetworkImage(
                imageUrl: imageUrls[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CircleCloseButton extends StatelessWidget {
  const _CircleCloseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.r,
        height: 36.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.darkText(context).withValues(alpha: 0.08),
        ),
        child: Icon(
          Icons.close_rounded,
          size: 20.sp,
          color: AppColors.darkText(context),
        ),
      ),
    );
  }
}

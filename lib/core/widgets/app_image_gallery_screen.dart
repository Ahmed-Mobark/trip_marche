import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';

/// Full-screen gallery: swipe between photos, pinch / double-tap zoom.
class AppImageGalleryScreen extends StatefulWidget {
  const AppImageGalleryScreen({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
  });

  final List<String> imageUrls;
  final int initialIndex;

  /// Opens the gallery, or no-ops when [imageUrls] has no valid URLs.
  static Future<void> open(
    BuildContext context, {
    required List<String> imageUrls,
    int initialIndex = 0,
  }) {
    final urls = imageUrls.map((u) => u.trim()).where((u) => u.isNotEmpty).toList();
    if (urls.isEmpty) {
      return Future.value();
    }
    final i = initialIndex.clamp(0, urls.length - 1);
    return Navigator.of(context, rootNavigator: true).push<void>(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 300),
        opaque: true,
        pageBuilder: (context, animation, secondaryAnimation) {
          return AppImageGalleryScreen(imageUrls: urls, initialIndex: i);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.ease));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  State<AppImageGalleryScreen> createState() => _AppImageGalleryScreenState();
}

class _AppImageGalleryScreenState extends State<AppImageGalleryScreen> {
  late final PageController _pageController;
  late int _displayIndex;

  @override
  void initState() {
    super.initState();
    _displayIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.imageUrls.length;
    final closeLabel = MaterialLocalizations.of(context).closeButtonTooltip;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            PhotoViewGallery.builder(
                scrollPhysics: const ClampingScrollPhysics(),
                pageController: _pageController,
                itemCount: total,
                backgroundDecoration: const BoxDecoration(color: Colors.black),
                onPageChanged: (index) {
                  setState(() => _displayIndex = index);
                },
                loadingBuilder: (context, event) => Center(
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColors.primary.withValues(alpha: 0.9),
                      value: event == null || event.expectedTotalBytes == null
                          ? null
                          : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                    ),
                  ),
                ),
                builder: (context, index) {
                  final url = widget.imageUrls[index];
                  return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(url),
                    initialScale: PhotoViewComputedScale.contained,
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 4,
                    filterQuality: FilterQuality.high,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                        color: Colors.white.withValues(alpha: 0.5),
                        size: 56,
                      ),
                    ),
                  );
                },
              ),
            SafeArea(
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: closeLabel,
                  icon: const Icon(Icons.close, color: Colors.white, size: 26),
                ),
              ),
            ),
            if (total > 1)
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        child: Text(
                          context.tr.imageGalleryPosition(_displayIndex + 1, total),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

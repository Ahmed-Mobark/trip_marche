import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/config/app_icons.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/search/presentation/view/destination_search_view.dart';

/// Collapsing home header used as a [SliverPersistentHeader].
///
/// Expanded: logo + notification bell, search bar (full width), location row.
/// Collapsed: search bar (shrunk, 25% opacity) + notification bell on its right.
class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  HomeHeaderDelegate({
    required this.searchHint,
    this.searchHintDestinations = const [],
    required this.locationText,
    required this.topPadding,
    this.onNotificationsTap,
    this.hasNotification = true,
  });

  final String searchHint;
  final List<String> searchHintDestinations;
  final String locationText;
  final double topPadding;
  final VoidCallback? onNotificationsTap;
  final bool hasNotification;

  static double expandedHeight(double topPadding) =>
      topPadding + 4.h + 40.h + 8.h + 42.h + 6.h + 18.h + 8.h;

  static double collapsedHeight(double topPadding) =>
      topPadding + 8.h + 42.h + 8.h;

  @override
  double get maxExtent => expandedHeight(topPadding);

  @override
  double get minExtent => collapsedHeight(topPadding);

  @override
  bool shouldRebuild(covariant HomeHeaderDelegate oldDelegate) =>
      searchHint != oldDelegate.searchHint ||
      !listEquals(searchHintDestinations, oldDelegate.searchHintDestinations) ||
      locationText != oldDelegate.locationText ||
      topPadding != oldDelegate.topPadding ||
      hasNotification != oldDelegate.hasNotification;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final range = maxExtent - minExtent;
    final t = (shrinkOffset / range).clamp(0.0, 1.0);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: 16.w,
            end: 16.w,
            top: topPadding + 4.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo row — fades out
              if (t < 1.0)
                Opacity(
                  opacity: (1.0 - t * 2).clamp(0.0, 1.0),
                  child: SizedBox(
                    height: (40.h * (1.0 - t)).clamp(0.0, 40.h),
                    child: Row(
                      children: [
                        Image.asset(AppIcons.llo2Png, width: 90.w),
                        const Spacer(),
                        if (t <= 0.3)
                          _NotificationButton(
                            onTap: onNotificationsTap,
                            hasNotification: hasNotification,
                          ),
                      ],
                    ),
                  ),
                ),

              SizedBox(height: (8.h * (1.0 - t)).clamp(0.0, 8.h)),

              // Search row — shrinks + fades + bell moves beside it
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => sl<AppNavigator>().push(
                        screen: const DestinationSearchView(),
                      ),
                      child: _SearchField(
                        hint: searchHint,
                        destinations: searchHintDestinations,
                        collapseProgress: t,
                      ),
                    ),
                  ),
                  // Bell appears next to search when collapsed
                  if (t > 0.3)
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 8.w),
                      child: Opacity(
                        opacity: ((t - 0.3) / 0.7).clamp(0.0, 1.0),
                        child: _NotificationButton(
                          onTap: onNotificationsTap,
                          hasNotification: hasNotification,
                        ),
                      ),
                    ),
                ],
              ),

              // Location row — fades out
              if (t < 1.0) ...[
                SizedBox(height: (7.h * (1.0 - t)).clamp(0.0, 6.h)),
                Opacity(
                  opacity: (1.0 - t * 2.5).clamp(0.0, 1.0),
                  child: SizedBox(
                    height: (18.h * (1.0 - t)).clamp(0.0, 18.h),
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.location,
                          size: 16.sp,
                          color: AppColors.yellow2,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          locationText,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.yellow2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatefulWidget {
  const _SearchField({
    required this.hint,
    required this.destinations,
    this.collapseProgress = 0.0,
  });

  final String hint;
  final List<String> destinations;
  final double collapseProgress;

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  /// Time between rotating destination hints.
  static const Duration _swapEvery = Duration(milliseconds: 2600);

  /// Long enough to read; slide uses [Interval] so motion starts after a beat.
  static const Duration _transitionDuration = Duration(milliseconds: 560);

  Timer? _timer;
  int _index = 0;

  List<String> get _destinations => widget.destinations
      .map((name) => name.trim())
      .where((name) => name.isNotEmpty)
      .toSet()
      .take(8)
      .toList(growable: false);

  @override
  void initState() {
    super.initState();
    _syncTimer();
  }

  @override
  void didUpdateWidget(covariant _SearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.destinations, widget.destinations)) {
      _index = 0;
      _syncTimer();
    }
  }

  void _syncTimer() {
    _timer?.cancel();
    final destinations = _destinations;
    if (destinations.length <= 1) {
      return;
    }
    _timer = Timer.periodic(_swapEvery, (_) {
      if (!mounted) return;
      setState(() {
        _index = (_index + 1) % _destinations.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _currentHint(BuildContext context) {
    final destinations = _destinations;
    if (destinations.isEmpty) {
      return widget.hint;
    }
    final safeIndex = _index.clamp(0, destinations.length - 1);
    return context.tr.homeSearchHintDestination(destinations[safeIndex]);
  }

  @override
  Widget build(BuildContext context) {
    final hint = _currentHint(context);
    final t = widget.collapseProgress;
    final bgColor = Color.lerp(
      AppColors.cardBg(context),
      Colors.white.withValues(alpha: 0.85),
      t,
    )!;
    return Container(
      height: 42.h,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.search_normal_1,
            size: 20.sp,
            color: AppColors.greyText(context).withValues(alpha: 0.85),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: ClipRect(
              clipBehavior: Clip.hardEdge,
              child: AnimatedSwitcher(
                duration: _transitionDuration,
                switchInCurve: Curves.easeInCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  final isIncoming =
                      animation.status == AnimationStatus.forward ||
                      animation.status == AnimationStatus.completed;
                  final slide =
                      Tween<Offset>(
                        begin: Offset(0, isIncoming ? 0.55 : -0.55),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        ),
                      );
                  final fade = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  );
                  return FadeTransition(
                    opacity: fade,
                    child: SlideTransition(position: slide, child: child),
                  );
                },
                child: SizedBox(
                  key: ValueKey<String>(hint),
                  width: double.infinity,
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      hint,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      // Start of line = beside the search icon in both LTR and RTL.
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyText(
                          context,
                        ).withValues(alpha: 0.9),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton({this.onTap, required this.hasNotification});

  final VoidCallback? onTap;
  final bool hasNotification;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        width: 40.w,
        height: 40.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Iconsax.notification, size: 22.sp, color: AppColors.onImage),
            if (hasNotification)
              PositionedDirectional(
                top: 8.w,
                end: 8.w,
                child: Container(
                  width: 9.w,
                  height: 9.w,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.onImage.withValues(alpha: 0.6),
                      width: 1,
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

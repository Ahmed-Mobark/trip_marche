import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/config/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/presentation/view/home_view.dart';
import '../../../my_trips/presentation/view/my_trips_view.dart';
import '../../../wishlist/presentation/view/wishlist_view.dart';
import '../../../profile/presentation/view/profile_view.dart';
import '../../../../core/extensions/localization.dart';

class MainNavView extends StatefulWidget {
  const MainNavView({super.key});

  @override
  State<MainNavView> createState() => _MainNavViewState();
}

class _MainNavViewState extends State<MainNavView> {
  int _currentIndex = 0;
  final GlobalKey<HomeViewState> _homeKey = GlobalKey<HomeViewState>();
  final GlobalKey<WishlistViewState> _wishlistKey =
      GlobalKey<WishlistViewState>();

  late final List<Widget> _pages = [
    HomeView(key: _homeKey),
    const MyTripsView(),
    WishlistView(key: _wishlistKey),
    const ProfileView(),
  ];

  /// BottomNavigationBar measures icon vs activeIcon in the same slot; mixed
  /// intrinsic sizes (SVG vs Icon) can clip the last tab on RTL / small widths.
  /// A fixed box keeps every tab aligned and avoids the selected icon vanishing.
  Widget _navIconSlot(Widget child) {
    return SizedBox(width: 28, height: 28, child: Center(child: child));
  }

  Widget _navItemIcon(
    BuildContext context,
    int tabIndex, {
    required bool selected,
  }) {
    final primary = AppColors.primary;
    final muted = AppColors.greyText(context);

    Widget svgAsset(String path, {required bool isSelected}) {
      return SvgPicture.asset(
        path,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
        colorFilter: ColorFilter.mode(
          isSelected ? primary : muted,
          BlendMode.srcIn,
        ),
      );
    }

    switch (tabIndex) {
      case 0:
        if (selected) {
          return _navIconSlot(Icon(Iconsax.home5, size: 24, color: primary));
        }
        return _navIconSlot(svgAsset(AppIcons.homeIconSvg, isSelected: false));
      case 1:
        // My Trips: always outline SVG (no filled variant when selected).
        return _navIconSlot(
          svgAsset(AppIcons.tripsIconSvg, isSelected: selected),
        );
      case 2:
        if (selected) {
          return _navIconSlot(Icon(Iconsax.heart5, size: 24, color: primary));
        }
        return _navIconSlot(
          svgAsset(AppIcons.wishlistIconSvg, isSelected: false),
        );
      case 3:
        if (selected) {
          // Iconsax user5 can fail to paint on some iOS/font combos; Material
          // icon is always available for a reliable "filled" account glyph.
          return _navIconSlot(Icon(Icons.person, size: 26, color: primary));
        }
        return _navIconSlot(
          svgAsset(AppIcons.accountIconSvg, isSelected: false),
        );
      default:
        return _navIconSlot(const SizedBox.shrink());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          const itemCount = 4;
          final itemW = constraints.maxWidth / itemCount;
          final isRtl = Directionality.of(context) == TextDirection.rtl;
          final indicatorLeft = isRtl
              ? constraints.maxWidth - ((_currentIndex + 1) * itemW)
              : _currentIndex * itemW;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBg(context),
                  border: Border(
                    top: BorderSide(
                      color: AppColors.border(context),
                      width: 0.5,
                    ),
                  ),
                ),
                child: BottomNavigationBar(
                  iconSize: 26,
                  currentIndex: _currentIndex,
                  onTap: (index) async {
                    setState(() {
                      _currentIndex = index;
                    });
                    if (index == 0) {
                      await _homeKey.currentState?.refreshFromNavBarTap();
                    }
                    if (index == 2) {
                      await _wishlistKey.currentState?.refreshFromNavBarTap();
                    }
                  },
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: AppColors.cardBg(context),
                  elevation: 0,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: AppColors.greyText(context),
                  selectedLabelStyle: Theme.of(context).textTheme.bodyMedium!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                  unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                  items: [
                    BottomNavigationBarItem(
                      icon: _navItemIcon(context, 0, selected: false),
                      activeIcon: _navItemIcon(context, 0, selected: true),
                      label: context.tr.navHome,
                    ),
                    BottomNavigationBarItem(
                      icon: _navItemIcon(context, 1, selected: false),
                      activeIcon: _navItemIcon(context, 1, selected: true),
                      label: context.tr.navTrips,
                    ),
                    BottomNavigationBarItem(
                      icon: _navItemIcon(context, 2, selected: false),
                      activeIcon: _navItemIcon(context, 2, selected: true),
                      label: context.tr.navWishlist,
                    ),
                    BottomNavigationBarItem(
                      icon: _navItemIcon(context, 3, selected: false),
                      activeIcon: _navItemIcon(context, 3, selected: true),
                      label: context.tr.navAccount,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: indicatorLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  width: itemW,
                  height: 3,
                  alignment: Alignment.center,
                  child: Container(
                    width: 48,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

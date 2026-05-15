import 'package:flutter/material.dart';

import '../../../../core/config/app_icons.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/presentation/view/home_view.dart';
import '../../../my_trips/presentation/view/my_trips_view.dart';
import '../../../profile/presentation/view/profile_view.dart';
import '../../../wishlist/presentation/view/wishlist_view.dart';
import '../theme/nav_bar_handoff_tokens.dart';
import '../widgets/nav_bar_svg_icon.dart';

class MainNavView extends StatefulWidget {
  const MainNavView({super.key});

  @override
  State<MainNavView> createState() => _MainNavViewState();
}

class _MainNavViewState extends State<MainNavView> {
  static const int _itemCount = 4;

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

  Widget _navIconSlot(NavBarHandoffTokens nav, Widget child) {
    return SizedBox(
      width: nav.w(28),
      height: nav.w(28),
      child: Center(child: child),
    );
  }

  BottomNavigationBarItem _item(
    NavBarHandoffTokens nav, {
    required String svgAsset,
    required String label,
    required Color primary,
    required Color muted,
    required bool selected,
  }) {
    final size = nav.w(24);
    final slot = _navIconSlot(
      nav,
      NavBarSvgIcon(
        assetPath: svgAsset,
        selected: selected,
        primaryColor: primary,
        inactiveColor: muted,
        size: size,
      ),
    );
    return BottomNavigationBarItem(icon: slot, activeIcon: slot, label: label);
  }

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;
    final muted = AppColors.greyText(context);
    final nav = NavBarHandoffTokens.of(context);
    final hInset = nav.w(20);
    final vInset = nav.w(16);

    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          final outerW = constraints.maxWidth;
          final innerW = outerW - 2 * hInset;
          final itemW = innerW / _itemCount;
          final isRtl = Directionality.of(context) == TextDirection.rtl;
          final indicatorPhysicalLeft = isRtl
              ? hInset +
                  (_itemCount - 1 - _currentIndex) * itemW
              : hInset + _currentIndex * itemW;
          final labelSize = nav.w(14);

          return DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.cardBg(context),
              border: const Border(
                top: BorderSide(color: NavBarHandoffTokens.borderTop, width: 1),
              ),
              boxShadow: NavBarHandoffTokens.topShadow(),
            ),
            child: SafeArea(
              top: false,
              maintainBottomViewPadding: true,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: hInset,
                      end: hInset,
                      top: vInset,
                      bottom: vInset,
                    ),
                    child: BottomNavigationBar(
                      iconSize: nav.w(24),
                      selectedIconTheme: IconThemeData(size: nav.w(24)),
                      unselectedIconTheme: IconThemeData(size: nav.w(24)),
                      currentIndex: _currentIndex,
                      onTap: (index) async {
                        setState(() => _currentIndex = index);
                        if (index == 0) {
                          await _homeKey.currentState?.refreshFromNavBarTap();
                        }
                        if (index == 2) {
                          await _wishlistKey.currentState
                              ?.refreshFromNavBarTap();
                        }
                      },
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      selectedItemColor: primary,
                      unselectedItemColor: muted,
                      selectedLabelStyle: TextStyle(
                        fontSize: labelSize,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: labelSize,
                        fontWeight: FontWeight.w500,
                      ),
                      items: [
                        _item(
                          nav,
                          svgAsset: AppIcons.homeIconSvg,
                          label: context.tr.navHome,
                          primary: primary,
                          muted: muted,
                          selected: _currentIndex == 0,
                        ),
                        _item(
                          nav,
                          svgAsset: AppIcons.tripsIconSvg,
                          label: context.tr.navTrips,
                          primary: primary,
                          muted: muted,
                          selected: _currentIndex == 1,
                        ),
                        _item(
                          nav,
                          svgAsset: AppIcons.wishlistIconSvg,
                          label: context.tr.navWishlist,
                          primary: primary,
                          muted: muted,
                          selected: _currentIndex == 2,
                        ),
                        _item(
                          nav,
                          svgAsset: AppIcons.accountIconSvg,
                          label: context.tr.navAccount,
                          primary: primary,
                          muted: muted,
                          selected: _currentIndex == 3,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: indicatorPhysicalLeft,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOutCubic,
                      width: itemW,
                      height: 3,
                      alignment: Alignment.center,
                      child: Container(
                        width: nav.w(56),
                        height: 3,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

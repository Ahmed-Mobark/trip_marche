import 'package:flutter/material.dart';
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

  Widget _navIcon(
    BuildContext context,
    String asset, {
    required bool selected,
  }) {
    return AppIcons.icon(
      icon: asset,
      size: selected ? 25 : 24,
      color: selected ? AppColors.primary : AppColors.greyText(context),
    );
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
                      icon: _navIcon(
                        context,
                        AppIcons.homeIconSvg,
                        selected: false,
                      ),
                      activeIcon: _navIcon(
                        context,
                        AppIcons.homeIconSvg,
                        selected: true,
                      ),
                      label: context.tr.navHome,
                    ),
                    BottomNavigationBarItem(
                      icon: _navIcon(
                        context,
                        AppIcons.tripsIconSvg,
                        selected: false,
                      ),
                      activeIcon: _navIcon(
                        context,
                        AppIcons.tripsIconSvg,
                        selected: true,
                      ),
                      label: context.tr.navTrips,
                    ),
                    BottomNavigationBarItem(
                      icon: _navIcon(
                        context,
                        AppIcons.wishlistIconSvg,
                        selected: false,
                      ),
                      activeIcon: _navIcon(
                        context,
                        AppIcons.wishlistIconSvg,
                        selected: true,
                      ),
                      label: context.tr.navWishlist,
                    ),
                    BottomNavigationBarItem(
                      icon: _navIcon(
                        context,
                        AppIcons.accountIconSvg,
                        selected: false,
                      ),
                      activeIcon: _navIcon(
                        context,
                        AppIcons.accountIconSvg,
                        selected: true,
                      ),
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

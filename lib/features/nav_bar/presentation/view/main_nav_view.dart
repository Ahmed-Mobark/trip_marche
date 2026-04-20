import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/features/home/presentation/view/home_view.dart';
import 'package:trip_marche/features/my_trips/presentation/view/my_trips_view.dart';
import 'package:trip_marche/features/wishlist/presentation/view/wishlist_view.dart';
import 'package:trip_marche/features/profile/presentation/view/profile_view.dart';
import 'package:trip_marche/core/extensions/localization.dart';

class MainNavView extends StatefulWidget {
  const MainNavView({super.key});

  @override
  State<MainNavView> createState() => _MainNavViewState();
}

class _MainNavViewState extends State<MainNavView> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeView(),
    MyTripsView(),
    WishlistView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
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
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  border: Border(
                    top: BorderSide(color: AppColors.border, width: 0.5),
                  ),
                ),
                child: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: AppColors.white,
                  elevation: 0,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: AppColors.greyText,
                  selectedLabelStyle: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  items: [
                    BottomNavigationBarItem(
                      icon: const Icon(Iconsax.home),
                      activeIcon: const Icon(Iconsax.home_15),
                      label: context.tr.navHome,
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Iconsax.map),
                      activeIcon: const Icon(Iconsax.map5),
                      label: context.tr.navTrips,
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Iconsax.heart),
                      activeIcon: const Icon(Iconsax.heart5),
                      label: context.tr.navWishlist,
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Iconsax.user),
                      activeIcon: const Icon(Iconsax.user),
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

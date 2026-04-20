import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_icons.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/storage/data/storage.dart';
import 'package:trip_marche/features/auth/presentation/view/login_view.dart';
import 'package:trip_marche/features/nav_bar/presentation/view/main_nav_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Start fade-in after a brief delay
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });

    // Navigate after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        final isLoggedIn = sl<Storage>().isAuthorized();
        if (isLoggedIn) {
          sl<AppNavigator>().pushReplacement(screen: const MainNavView());
        } else {
          sl<AppNavigator>().pushReplacement(screen: const LoginView());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: Center(
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeIn,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Image.asset(AppIcons.lloPng, width: 200.w)],
            ),
          ),
        ),
      ),
    );
  }
}

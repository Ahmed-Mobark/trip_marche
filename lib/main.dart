import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/navigation/app_router.dart';
import 'package:trip_marche/features/splash/presentation/view/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'TripMarche',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            scaffoldBackgroundColor: AppColors.background,
            textTheme: GoogleFonts.interTextTheme(),
            useMaterial3: true,
          ),
          home: const SplashView(),
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}

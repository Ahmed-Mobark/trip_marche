import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:trip_marche/core/app/app_state.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/navigation/route_observer.dart';
import 'package:trip_marche/core/network/connectivity/connectivity_cubit.dart';
import 'package:trip_marche/core/network/connectivity/offline_screen.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/core/storage/data/storage.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_theme.dart';
import 'package:trip_marche/core/translation/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.initialThemeMode});

  /// Persisted theme read in `main()` via [AppState.bootThemeMode].
  final AdaptiveThemeMode initialThemeMode;

  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Locale _locale = Locale(sl<Storage>().getLang());

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
    sl<ApiBaseHelper>().updateLocaleInHeaders(sl<Storage>().getLang());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) => AdaptiveTheme(
        light: AppTheme.appLightTheme,
        dark: AppTheme.appDarkTheme,
        initial: widget.initialThemeMode,
        debugShowFloatingThemeButton: false,
        builder: (theme, darkTheme) => MaterialApp(
          debugShowCheckedModeBanner: false,
          scrollBehavior: const ScrollBehavior().copyWith(
            physics: const BouncingScrollPhysics(),
          ),
          theme: theme,
          darkTheme: darkTheme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          navigatorObservers: [ObserverUtils.routeObserver],
          locale: _locale,
          navigatorKey: sl<AppNavigator>().navigatorKey,
          builder: (context, child) {
            // Single source of truth for [AppColors.brightness]: the resolved
            // [Theme] applied by [AdaptiveTheme]. This handles `system` mode
            // correctly (where `mode.isDark` would always be false).
            AppColors.brightness = Theme.of(context).brightness;
            return BlocProvider.value(
              value: sl<ConnectivityCubit>(),
              child: BlocBuilder<ConnectivityCubit, bool>(
                builder: (context, isConnected) {
                  return Stack(
                    children: [
                      child ?? const SizedBox.shrink(),
                      if (!isConnected) const OfflineScreen(),
                    ],
                  );
                },
              ),
            );
          },
          home: AppState.currentScreen(),
        ),
      ),
    );
  }
}

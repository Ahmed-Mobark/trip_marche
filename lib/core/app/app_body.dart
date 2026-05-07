import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_marche/core/app/app_state.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/navigation/route_observer.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/core/storage/data/storage.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_theme.dart';
import 'package:trip_marche/core/translation/app_localizations.dart';

class _NoOverScrollBehavior extends ScrollBehavior {
  const _NoOverScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.initialThemeMode});

  final AdaptiveThemeMode initialThemeMode;

  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Locale _locale = Locale(sl<Storage>().getLang());

  Future<void> setLocale(Locale locale) async {
    final code = locale.languageCode;
    await sl<Storage>().storeLang(langCode: code);
    if (!mounted) {
      return;
    }
    setState(() {
      _locale = Locale(code);
    });
    sl<ApiBaseHelper>().updateLocaleInHeaders(code);
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
          scrollBehavior: const _NoOverScrollBehavior(),
          theme: theme,
          darkTheme: darkTheme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          navigatorObservers: [ObserverUtils.routeObserver],
          locale: _locale,
          navigatorKey: sl<AppNavigator>().navigatorKey,
          builder: (context, child) {
            AppColors.brightness = Theme.of(context).brightness;
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
              ),
              child: DecoratedBox(
                decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
                child: SafeArea(
                  top: true,
                  bottom: false,
                  child: child ?? const SizedBox.shrink(),
                ),
              ),
            );
          },
          home: AppState.currentScreen(),
        ),
      ),
    );
  }
}

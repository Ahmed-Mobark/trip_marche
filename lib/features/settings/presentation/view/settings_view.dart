import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../widgets/settings_row.dart';
import 'notification_settings_view.dart';
import 'language_view.dart';
import '../../../../core/extensions/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Rebuild the whole screen when theme mode changes so AppColors.* and
    // scaffold colors update immediately (not only after popping the route).
    return ValueListenableBuilder<AdaptiveThemeMode>(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (context, mode, __) {
        // Use [mode] from the notifier (not Theme/AppColors) so the sheet repaints
        // on the same frame as setThemeMode — notifier fires before MaterialApp.
        final isDark = mode.isDark;
        AppColors.brightness = isDark ? Brightness.dark : Brightness.light;
        final pageBg = AppColors.background;
        final titleColor = AppColors.bodyText;
        final muted = AppColors.greyText;
        final borderTone = AppColors.border;

        return Scaffold(
          backgroundColor: pageBg,
          appBar: AppBar(
            backgroundColor: pageBg,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: titleColor),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              context.tr.settingsTitle,
              style: AppTextStyles.subtitle(color: titleColor),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsetsDirectional.only(
              start: 20.w,
              end: 20.w,
              top: 6.h,
            ),
            child: Column(
              children: [
                SettingsRow(
                  icon: Iconsax.notification,
                  title: context.tr.settingsNotificationSetting,
                  foregroundColor: titleColor,
                  trailing: Icon(Iconsax.arrow_right_3, size: 18, color: muted),
                  onTap: () {
                    sl<AppNavigator>().push(
                      screen: const NotificationSettingsView(),
                    );
                  },
                ),
                _DividerLine(color: borderTone),
                SettingsRow(
                  icon: Iconsax.global,
                  title: context.tr.settingsLanguage,
                  foregroundColor: titleColor,
                  trailing: Icon(Iconsax.arrow_right_3, size: 18, color: muted),
                  onTap: () {
                    sl<AppNavigator>().push(screen: const LanguageView());
                  },
                ),
                _DividerLine(color: borderTone),
                SettingsRow(
                  icon: Iconsax.dollar_circle,
                  title: context.tr.settingsCurrency,
                  foregroundColor: titleColor,
                  trailing: Icon(Iconsax.arrow_right_3, size: 18, color: muted),
                  onTap: () {},
                ),
                _DividerLine(color: borderTone),
                SettingsRow(
                  icon: Iconsax.moon,
                  title: context.tr.settingsDarkMode,
                  foregroundColor: titleColor,
                  trailing: Switch.adaptive(
                    value: isDark,
                    onChanged: (value) =>
                        AdaptiveTheme.of(context).setThemeMode(
                          value
                              ? AdaptiveThemeMode.dark
                              : AdaptiveThemeMode.light,
                        ),
                    activeThumbColor: AppColors.onImage,
                    activeTrackColor: AppColors.primary.withValues(alpha: 0.45),
                    inactiveTrackColor: borderTone,
                  ),
                  onTap: null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(height: 1.h, color: color);
  }
}

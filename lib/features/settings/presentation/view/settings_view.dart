import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/features/settings/presentation/widgets/settings_row.dart';
import 'package:trip_marche/features/settings/presentation/view/notification_settings_view.dart';
import 'package:trip_marche/features/settings/presentation/view/language_view.dart';
import 'package:trip_marche/core/extensions/localization.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          context.tr.settingsTitle,
          style: AppTextStyles.subtitle(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            // Notification Setting
            SettingsRow(
              icon: Iconsax.notification,
              title: context.tr.settingsNotificationSetting,
              trailing: const Icon(
                Iconsax.arrow_right_3,
                size: 18,
                color: AppColors.greyText,
              ),
              onTap: () {
                sl<AppNavigator>().push(
                  screen: const NotificationSettingsView(),
                );
              },
            ),
            const Divider(height: 1, color: AppColors.border),

            // Language
            SettingsRow(
              icon: Iconsax.language_square,
              title: context.tr.settingsLanguage,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.tr.settingsEnglish,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyText,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Iconsax.arrow_right_3,
                    size: 18,
                    color: AppColors.greyText,
                  ),
                ],
              ),
              onTap: () {
                sl<AppNavigator>().push(screen: const LanguageView());
              },
            ),
            const Divider(height: 1, color: AppColors.border),

            // Dark Mode
            SettingsRow(
              icon: Iconsax.moon,
              title: context.tr.settingsDarkMode,
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                },
                activeThumbColor: AppColors.primary,
              ),
              onTap: null,
            ),
            const Divider(height: 1, color: AppColors.border),

            const Spacer(),

            // App Version
            Text(
              context.tr.settingsAppVersion('1.0.0'),
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.greyText,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/features/settings/presentation/widgets/settings_row.dart';
import 'package:trip_marche/features/settings/presentation/view/notification_settings_view.dart';
import 'package:trip_marche/features/settings/presentation/view/language_view.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.darkText,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          context.tr.settingsTitle,
          style: AppTextStyles.subtitle(color: AppColors.darkText),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 6.h),
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
            _DividerLine(),

            // Language
            SettingsRow(
              icon: Iconsax.global,
              title: context.tr.settingsLanguage,
              trailing: const Icon(
                Iconsax.arrow_right_3,
                size: 18,
                color: AppColors.greyText,
              ),
              onTap: () {
                sl<AppNavigator>().push(screen: const LanguageView());
              },
            ),
            _DividerLine(),

            // Currency
            SettingsRow(
              icon: Iconsax.dollar_circle,
              title: context.tr.settingsCurrency,
              trailing: const Icon(
                Iconsax.arrow_right_3,
                size: 18,
                color: AppColors.greyText,
              ),
              onTap: () {},
            ),
            _DividerLine(),

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
                activeTrackColor: AppColors.primary,
                inactiveTrackColor: AppColors.border,
                thumbColor: WidgetStateProperty.resolveWith<Color>(
                  (states) => AppColors.white,
                ),
              ),
              onTap: null,
            ),
          ],
        ),
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 1.h, color: AppColors.border);
  }
}

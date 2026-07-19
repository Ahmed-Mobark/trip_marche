import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/app/app_state.dart';
import '../../../../core/widgets/app_theme_mode_toggle.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/toast/app_toast.dart';
import '../../../../core/widgets/app_confirmation_bottom_sheet.dart';
import '../../../../core/widgets/app_confirm_dialog.dart';
import '../../../../features/auth/presentation/cubit/logout/logout_cubit.dart';
import '../../../../features/auth/presentation/cubit/logout/logout_state.dart';
import '../../../../features/auth/presentation/view/login_view.dart';
import '../../../../features/profile/presentation/cubit/delete_account_cubit.dart';
import '../../../../features/profile/presentation/cubit/delete_account_state.dart';
import '../widgets/settings_row.dart';
import 'notification_settings_view.dart';
import 'language_view.dart';
import '../../../../core/extensions/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<LogoutCubit>()),
        BlocProvider(create: (_) => sl<DeleteAccountCubit>()),
      ],
      child: const _SettingsViewContent(),
    );
  }
}

class _SettingsViewContent extends StatelessWidget {
  const _SettingsViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AdaptiveThemeMode>(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (context, _, __) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final pageBg = AppColors.background(context);
        final titleColor = AppColors.bodyText(context);
        final muted = AppColors.greyText(context);
        final borderTone = AppColors.border(context);

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
                  trailing: Icon(Icons.chevron_right, size: 22, color: muted),
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
                  trailing: Icon(Icons.chevron_right, size: 22, color: muted),
                  onTap: () {
                    sl<AppNavigator>().push(screen: const LanguageView());
                  },
                ),
                _DividerLine(color: borderTone),
                SettingsRow(
                  icon: Iconsax.dollar_circle,
                  title: context.tr.settingsCurrency,
                  foregroundColor: titleColor,
                  trailing: Icon(Icons.chevron_right, size: 22, color: muted),
                  onTap: () {},
                ),
                _DividerLine(color: borderTone),
                SettingsRow(
                  icon: Iconsax.moon,
                  title: context.tr.settingsDarkMode,
                  foregroundColor: titleColor,
                  trailing: AppThemeModeToggle(
                    semanticsLabel: context.tr.settingsDarkMode,
                    value: isDark,
                    onChanged: (darkEnabled) async {
                      final mode = darkEnabled
                          ? AdaptiveThemeMode.dark
                          : AdaptiveThemeMode.light;
                      AdaptiveTheme.of(context).setThemeMode(mode);
                      await AppState.storeThemeMode(mode);
                    },
                  ),
                  onTap: null,
                ),
                _DividerLine(color: borderTone),
                SettingsRow(
                  icon: Iconsax.logout_1,
                  title: context.tr.logout,
                  foregroundColor: AppColors.red,
                  trailing: const SizedBox.shrink(),
                  onTap: () => _showLogoutBottomSheet(context),
                ),
                _DividerLine(color: borderTone),
                SettingsRow(
                  icon: Iconsax.trash,
                  title: context.tr.deleteAccount,
                  foregroundColor: AppColors.red,
                  trailing: const SizedBox.shrink(),
                  onTap: () => _showDeleteAccountFlow(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLogoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (sheetContext) => BlocConsumer<LogoutCubit, LogoutState>(
        listener: (context, state) {
          debugPrint("Current Logout State: ${state.status}");
          if (state.status == LogoutStatus.failure) {
            Navigator.pop(sheetContext);
            context.read<LogoutCubit>().clearError();
          } else if (state.status == LogoutStatus.success) {
            Navigator.pop(sheetContext);
            _handleLogoutSuccess(context);
          }
        },
        builder: (context, state) {
          final isLoading = state.status == LogoutStatus.loading;
          return AppConfirmationBottomSheet(
            icon: Iconsax.logout_1,
            title: context.tr.logoutTitle,
            description: context.tr.logoutDescription,
            primaryActionText: context.tr.logoutAction,
            secondaryActionText: context.tr.cancel,
            primaryActionColor: AppColors.red,
            isLoading: isLoading,
            onPrimaryAction: isLoading
                ? null
                : () => _performLogout(context),
            onSecondaryAction: isLoading
                ? null
                : () => Navigator.pop(sheetContext),
          );
        },
      ),
    );
  }

  void _showDeleteAccountFlow(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (sheetContext) => BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
        listener: (context, state) {
          debugPrint("Current Delete Account State: ${state.status}");
          if (state.status == DeleteAccountStatus.failure) {
            Navigator.pop(sheetContext);
            context.read<DeleteAccountCubit>().clearError();
          } else if (state.status == DeleteAccountStatus.success) {
            Navigator.pop(sheetContext);
            _handleDeleteAccountSuccess(context);
          }
        },
        builder: (context, state) {
          final isLoading = state.status == DeleteAccountStatus.loading;
          return AppConfirmationBottomSheet(
            icon: Iconsax.trash,
            title: context.tr.deleteAccountTitle,
            description: context.tr.deleteAccountDescription,
            primaryActionText: context.tr.deleteAccountAction,
            secondaryActionText: context.tr.cancel,
            primaryActionColor: AppColors.red,
            isLoading: isLoading,
            onPrimaryAction: isLoading
                ? null
                : () => _showFinalConfirmationDialog(context),
            onSecondaryAction: isLoading
                ? null
                : () => Navigator.pop(sheetContext),
          );
        },
      ),
    );
  }

  void _showFinalConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: AppColors.scrim.withValues(alpha: 0.55),
      builder: (dialogContext) => AppConfirmDialog(
        message: context.tr.deleteAccountWarning,
        secondaryActionText: context.tr.cancel,
        onSecondaryAction: () => Navigator.pop(dialogContext),
        primaryActionText: context.tr.commonDelete,
        onPrimaryAction: () {
          Navigator.pop(dialogContext);
          _performDeleteAccount(context);
        },
        primaryActionColor: AppColors.red,
      ),
    );
  }

  void _performLogout(BuildContext context) {
    context.read<LogoutCubit>().logout(context);
  }

  void _performDeleteAccount(BuildContext context) {
    context.read<DeleteAccountCubit>().deleteAccount(context);
  }

  Future<void> _handleLogoutSuccess(BuildContext context) async {
    await context.read<LogoutCubit>().clearSession();
    if (context.mounted) {
      sl<AppNavigator>().pushAndRemoveUntil(screen: const LoginView());
    }
  }

  Future<void> _handleDeleteAccountSuccess(BuildContext context) async {
    await context.read<DeleteAccountCubit>().clearSession();
    if (context.mounted) {
      sl<AppNavigator>().pushAndRemoveUntil(screen: const LoginView());
    }
    if (context.mounted) {
      appToast(
        context: context,
        type: ToastType.success,
        message: context.tr.deleteAccountSuccess,
      );
    }
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

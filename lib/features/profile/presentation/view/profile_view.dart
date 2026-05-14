import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/widgets/app_confirm_dialog.dart';

import '../../../../core/extensions/localization.dart';
import '../../../../core/storage/data/storage.dart';
import '../../../../core/toast/app_toast.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../auth/presentation/view/login_view.dart';
import '../../../settings/presentation/view/customer_service_view.dart';
import '../../../settings/presentation/view/faqs_view.dart';
import '../../../settings/presentation/view/settings_view.dart';
import '../../../settings/presentation/view/terms_view.dart';
import '../theme/profile_handoff_tokens.dart';
import '../widgets/menu_item.dart';
import '../widgets/profile_avatar.dart';
import 'my_followings_view.dart';
import 'my_reviews_view.dart';
import 'personal_info_view.dart';

/// Account / profile — Figma **Profile** `1:22365` (frame 430×~1000).
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = ProfileHandoffTokens.of(context);
    final topPad = MediaQuery.paddingOf(context).top;
    final purpleH = t.w(263);
    final sheetRadius = t.w(16);
    final userJson = sl<Storage>().getUserJson();
    final name = (userJson?['name'] as String?)?.trim();
    final email = (userJson?['email'] as String?)?.trim();
    const tripsBooked = 14;
    final hMargin = t.w(20);
    final avatarRowTop = topPad + t.w(70);

    return Scaffold(
      backgroundColor: ProfileHandoffTokens.canvas(context),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            height: purpleH,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: ProfileHandoffTokens.headerGradient(),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: purpleH - t.w(58)),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ProfileHandoffTokens.canvas(context),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(sheetRadius),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: hMargin,
                      end: hMargin,
                      top: t.w(40),
                      bottom: 24.h,
                    ),
                    child: Column(
                      children: [
                        _HandoffCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                context.tr.profileTitleAccount,
                                style: ProfileHandoffTokens.sectionHeaderStyle(
                                  context,
                                ),
                              ),
                              SizedBox(height: t.w(8)),
                              ProfileMenuItem(
                                icon: Iconsax.user,
                                title: context.tr.profilePersonalInfo,
                                onTap: () => sl<AppNavigator>().push(
                                  screen: const PersonalInfoView(),
                                ),
                              ),
                              _HandoffDivider(),
                              ProfileMenuItem(
                                icon: Iconsax.card,
                                title: context.tr.profilePaymentMethod,
                                onTap: () {},
                              ),
                              _HandoffDivider(),
                              ProfileMenuItem(
                                icon: Iconsax.star,
                                title: context.tr.profileMyReviews,
                                onTap: () => sl<AppNavigator>().push(
                                  screen: const MyReviewsView(),
                                ),
                              ),
                              _HandoffDivider(),
                              ProfileMenuItem(
                                icon: Iconsax.tick_circle,
                                title: context.tr.profileFollowingCompanies,
                                onTap: () => sl<AppNavigator>().push(
                                  screen: const MyFollowingsView(),
                                ),
                              ),
                              _HandoffDivider(),
                              ProfileMenuItem(
                                icon: Iconsax.setting_2,
                                title: context.tr.profileSettings,
                                onTap: () => sl<AppNavigator>().push(
                                  screen: const SettingsView(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: t.w(16)),
                        _HandoffCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                context.tr.profileTitleSupport,
                                style: ProfileHandoffTokens.sectionHeaderStyle(
                                  context,
                                ),
                              ),
                              SizedBox(height: t.w(16)),
                              ProfileMenuItem(
                                icon: Iconsax.headphone,
                                title: context.tr.profileCustomerService,
                                onTap: () => sl<AppNavigator>().push(
                                  screen: const CustomerServiceView(),
                                ),
                              ),
                              _HandoffDivider(),
                              ProfileMenuItem(
                                icon: Iconsax.message_question,
                                title: context.tr.profileFaqs,
                                onTap: () => sl<AppNavigator>().push(
                                  screen: const FaqsView(),
                                ),
                              ),
                              _HandoffDivider(),
                              ProfileMenuItem(
                                icon: Iconsax.task,
                                title: context.tr.profileTermsAndConditions,
                                onTap: () => sl<AppNavigator>().push(
                                  screen: const TermsView(),
                                ),
                              ),
                              _HandoffDivider(),
                              ProfileMenuItem(
                                icon: Iconsax.trash,
                                title: context.tr.profileDeleteAccount,
                                titleColor: ProfileHandoffTokens.deleteTitle(
                                  context,
                                ),
                                iconColor: AppColors.error,
                                showChevron: false,
                                verticalPaddingFigma: 16,
                                onTap: () => _showDeleteAccountDialog(context),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: t.w(16)),
                        _HandoffLogoutBar(
                          onTap: () => _showLogoutDialog(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            top: avatarRowTop,
            start: hMargin,
            end: hMargin,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileAvatar(
                  onEditTap: () {},
                ),
                SizedBox(width: t.w(16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (name == null || name.isEmpty) ? '—' : name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: ProfileHandoffTokens.headerNameStyle(),
                      ),
                      SizedBox(height: t.w(4)),
                      Text(
                        (email == null || email.isEmpty) ? '—' : email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: ProfileHandoffTokens.headerEmailStyle(context),
                      ),
                      SizedBox(height: t.w(4)),
                      Text(
                        context.tr.profileTripsBooked(tripsBooked),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: ProfileHandoffTokens.headerTripsStyle(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: AppColors.scrim.withValues(alpha: 0.55),
      builder: (dialogContext) => AppConfirmDialog(
        message: context.tr.profileDeleteAccountMessage,
        secondaryActionText: context.tr.commonCancel,
        onSecondaryAction: () => Navigator.pop(dialogContext),
        primaryActionText: context.tr.commonDelete,
        onPrimaryAction: () {
          Navigator.pop(dialogContext);
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: AppColors.scrim.withValues(alpha: 0.55),
      builder: (dialogContext) => AppConfirmDialog(
        message: context.tr.profileLogoutConfirmMessage,
        secondaryActionText: context.tr.commonCancel,
        onSecondaryAction: () => Navigator.pop(dialogContext),
        primaryActionText: context.tr.profileLogout,
        onPrimaryAction: () {
          Navigator.pop(dialogContext);
          _performLogout(context);
        },
        primaryActionColor: AppColors.error,
      ),
    );
  }

  Future<void> _performLogout(BuildContext context) async {
    final result = await sl<AuthRepository>().logout();

    result.fold(
      (failure) {
        appToast(
          context: context,
          type: ToastType.error,
          message: failure.message,
        );
      },
      (_) async {
        await sl<Storage>().deleteToken();
        await sl<Storage>().deleteUser();
        sl<AppNavigator>().pushAndRemoveUntil(screen: const LoginView());
      },
    );
  }
}

class _HandoffCard extends StatelessWidget {
  const _HandoffCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final t = ProfileHandoffTokens.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.cardBg(context),
        borderRadius: BorderRadius.circular(t.w(16)),
        boxShadow: ProfileHandoffTokens.cardShadow(),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.all(t.w(16)),
        child: child,
      ),
    );
  }
}

class _HandoffDivider extends StatelessWidget {
  const _HandoffDivider();

  @override
  Widget build(BuildContext context) => Divider(
        height: 1,
        thickness: 1,
        color: ProfileHandoffTokens.dividerColor(context),
      );
}

class _HandoffLogoutBar extends StatelessWidget {
  const _HandoffLogoutBar({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = ProfileHandoffTokens.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(t.w(20)),
        child: Ink(
          height: t.w(64),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.cardBg(context),
            borderRadius: BorderRadius.circular(t.w(20)),
            border: Border.all(
              color: ProfileHandoffTokens.dividerColor(context),
            ),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.logout_1, size: t.w(24), color: AppColors.red),
                SizedBox(width: t.w(8)),
                Text(
                  context.tr.profileLogout,
                  style: ProfileHandoffTokens.logoutTitleStyle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

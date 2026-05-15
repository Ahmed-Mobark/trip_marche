import 'package:flutter/material.dart';
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

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = ProfileHandoffTokens.of(context);
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final purpleH = t.w(ProfileHandoffTokens.kHeaderGradientHeightFigma);
    final hInset = t.w(ProfileHandoffTokens.kHorizontalInsetFigma);
    final userJson = sl<Storage>().getUserJson();
    final name = (userJson?['name'] as String?)?.trim();
    final email = (userJson?['email'] as String?)?.trim();
    const tripsBooked = 14;
    final scrollBottomPad = bottomInset + t.w(16);
    final firstCardTop = t.w(ProfileHandoffTokens.kFirstCardTopFigma) - 20;

    return Scaffold(
      backgroundColor: ProfileHandoffTokens.canvas(context),
      body: Stack(
        children: [
          // Purple header gradient
          SizedBox(
            height: purpleH,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: ProfileHandoffTokens.headerGradient(),
              ),
            ),
          ),
          // Avatar row
          PositionedDirectional(
            top: t.w(ProfileHandoffTokens.kAvatarRowTopFigma),
            start: hInset,
            end: hInset,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileAvatar(onEditTap: () {}),
                SizedBox(width: t.w(16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (name == null || name.isEmpty) ? '—' : name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: t.headerNameStyle(),
                      ),
                      SizedBox(height: t.w(4)),
                      Text(
                        (email == null || email.isEmpty) ? '—' : email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: t.headerEmailStyle(context),
                      ),
                      SizedBox(height: t.w(4)),
                      Text(
                        context.tr.profileTripsBooked(tripsBooked),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: t.headerTripsStyle(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Scrollable cards over header
          Column(
            children: [
              SizedBox(height: firstCardTop),
              Expanded(
                child: _buildScrollableCards(
                  context,
                  t,
                  hInset,
                  scrollBottomPad,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableCards(
    BuildContext context,
    ProfileHandoffTokens t,
    double hInset,
    double scrollBottomPad,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: EdgeInsetsDirectional.only(
        start: hInset,
        end: hInset,
        bottom: scrollBottomPad,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _HandoffCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.tr.profileTitleAccount,
                  style: t.sectionHeaderStyle(context),
                ),
                SizedBox(height: t.w(8)),
                ProfileMenuItem(
                  icon: Iconsax.user,
                  title: context.tr.profilePersonalInfo,
                  onTap: () =>
                      sl<AppNavigator>().push(screen: const PersonalInfoView()),
                ),
                const _HandoffDivider(),
                ProfileMenuItem(
                  icon: Iconsax.card,
                  title: context.tr.profilePaymentMethod,
                  onTap: () {},
                ),
                const _HandoffDivider(),
                ProfileMenuItem(
                  icon: Iconsax.star,
                  title: context.tr.profileMyReviews,
                  onTap: () =>
                      sl<AppNavigator>().push(screen: const MyReviewsView()),
                ),
                const _HandoffDivider(),
                ProfileMenuItem(
                  icon: Iconsax.tick_circle,
                  title: context.tr.profileFollowingCompanies,
                  onTap: () =>
                      sl<AppNavigator>().push(screen: const MyFollowingsView()),
                ),
                const _HandoffDivider(),
                ProfileMenuItem(
                  icon: Iconsax.setting_2,
                  title: context.tr.profileSettings,
                  onTap: () =>
                      sl<AppNavigator>().push(screen: const SettingsView()),
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
                  style: t.sectionHeaderStyle(context),
                ),
                SizedBox(height: t.w(16)),
                ProfileMenuItem(
                  icon: Iconsax.headphone,
                  title: context.tr.profileCustomerService,
                  onTap: () => sl<AppNavigator>().push(
                    screen: const CustomerServiceView(),
                  ),
                ),
                const _HandoffDivider(),
                ProfileMenuItem(
                  icon: Iconsax.message_question,
                  title: context.tr.profileFaqs,
                  onTap: () =>
                      sl<AppNavigator>().push(screen: const FaqsView()),
                ),
                const _HandoffDivider(),
                ProfileMenuItem(
                  icon: Iconsax.task,
                  title: context.tr.profileTermsAndConditions,
                  onTap: () =>
                      sl<AppNavigator>().push(screen: const TermsView()),
                ),
                const _HandoffDivider(),
                ProfileMenuItem(
                  icon: Iconsax.trash,
                  title: context.tr.profileDeleteAccount,
                  titleColor: ProfileHandoffTokens.deleteTitle(context),
                  iconColor: AppColors.error,
                  showChevron: false,
                  verticalPaddingFigma: 16,
                  onTap: () => _showDeleteAccountDialog(context),
                ),
              ],
            ),
          ),
          SizedBox(height: t.w(16)),
          _HandoffLogoutBar(onTap: () => _showLogoutDialog(context)),
          SizedBox(height: t.w(8)),
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
      child: Padding(padding: EdgeInsetsDirectional.all(t.w(16)), child: child),
    );
  }
}

class _HandoffDivider extends StatelessWidget {
  const _HandoffDivider();

  static const double _leadingInsetFigma = 32;

  @override
  Widget build(BuildContext context) {
    final t = ProfileHandoffTokens.of(context);
    return Divider(
      height: 1,
      thickness: 1,
      indent: t.w(_leadingInsetFigma),
      color: ProfileHandoffTokens.dividerColor(context),
    );
  }
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
          padding: EdgeInsetsDirectional.only(start: t.w(16), end: t.w(16)),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Iconsax.logout_1, size: t.w(24), color: AppColors.red),
                SizedBox(width: t.w(8)),
                Text(context.tr.profileLogout, style: t.logoutTitleStyle()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

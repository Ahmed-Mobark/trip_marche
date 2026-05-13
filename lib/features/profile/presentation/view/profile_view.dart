import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/widgets/app_confirm_dialog.dart';
import '../widgets/menu_item.dart';
import '../widgets/profile_avatar.dart';
import 'personal_info_view.dart';
import 'my_reviews_view.dart';
import 'my_followings_view.dart';
import '../../../settings/presentation/view/settings_view.dart';
import '../../../settings/presentation/view/customer_service_view.dart';
import '../../../settings/presentation/view/faqs_view.dart';
import '../../../settings/presentation/view/terms_view.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/storage/data/storage.dart';
import '../../../../core/toast/app_toast.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../auth/presentation/view/login_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;
    final avatarRadius = 48.r;
    final avatarDiameter = avatarRadius * 2;
    final headerGradientHeight = topPad + 80.h + avatarDiameter / 2;
    final sheetRadius = 32.r;
    final userJson = sl<Storage>().getUserJson();
    final name = (userJson?['name'] as String?)?.trim();
    final email = (userJson?['email'] as String?)?.trim();
    final tripsBooked = 14;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg(context),
      body: Stack(
        children: [
          // Purple gradient header
          Container(
            height: headerGradientHeight,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
          ),

          // Scrollable content
          SingleChildScrollView(
            padding: EdgeInsetsDirectional.only(
              top: headerGradientHeight - sheetRadius,
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.scaffoldBg(context),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(sheetRadius),
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 18.w,
                  end: 18.w,
                  top: avatarDiameter / 2 + 16.h,
                  bottom: 24.h,
                ),
                child: Column(
                  children: [
                    _SectionCard(
                      title: context.tr.profileTitleAccount,
                      children: [
                        ProfileMenuItem(
                          icon: Iconsax.user,
                          title: context.tr.profilePersonalInfo,
                          onTap: () => sl<AppNavigator>().push(
                            screen: const PersonalInfoView(),
                          ),
                        ),
                        _CardDivider(),
                        ProfileMenuItem(
                          icon: Iconsax.card,
                          title: context.tr.profilePaymentMethod,
                          onTap: () {},
                        ),
                        _CardDivider(),
                        ProfileMenuItem(
                          icon: Iconsax.star,
                          title: context.tr.profileMyReviews,
                          onTap: () => sl<AppNavigator>().push(
                            screen: const MyReviewsView(),
                          ),
                        ),
                        _CardDivider(),
                        ProfileMenuItem(
                          icon: Iconsax.tick_circle,
                          title: context.tr.profileFollowingCompanies,
                          onTap: () => sl<AppNavigator>().push(
                            screen: const MyFollowingsView(),
                          ),
                        ),
                        _CardDivider(),
                        ProfileMenuItem(
                          icon: Iconsax.setting_2,
                          title: context.tr.profileSettings,
                          onTap: () => sl<AppNavigator>().push(
                            screen: const SettingsView(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _SectionCard(
                      title: context.tr.profileTitleSupport,
                      children: [
                        ProfileMenuItem(
                          icon: Iconsax.headphone,
                          title: context.tr.profileCustomerService,
                          onTap: () => sl<AppNavigator>().push(
                            screen: const CustomerServiceView(),
                          ),
                        ),
                        _CardDivider(),
                        ProfileMenuItem(
                          icon: Iconsax.message_question,
                          title: context.tr.profileFaqs,
                          onTap: () =>
                              sl<AppNavigator>().push(screen: const FaqsView()),
                        ),
                        _CardDivider(),
                        ProfileMenuItem(
                          icon: Iconsax.document_text,
                          title: context.tr.profileTermsAndConditions,
                          onTap: () => sl<AppNavigator>().push(
                            screen: const TermsView(),
                          ),
                        ),
                        _CardDivider(),
                        ProfileMenuItem(
                          icon: Iconsax.trash,
                          title: context.tr.profileDeleteAccount,
                          titleColor: AppColors.error,
                          iconColor: AppColors.error,
                          showChevron: false,
                          onTap: () => _showDeleteAccountDialog(context),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    _LogoutButton(onTap: () => _showLogoutDialog(context)),
                  ],
                ),
              ),
            ),
          ),

          // Avatar + info overlay (stacked on top of the boundary)
          PositionedDirectional(
            top: topPad + 24.h,
            start: 18.w,
            end: 18.w,
            child: Row(
              children: [
                ProfileAvatar(
                  radius: avatarRadius,
                  editIcon: Iconsax.camera,
                  editButtonSize: 28.r,
                  editIconSize: 15.sp,
                  onEditTap: () {},
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (name == null || name.isEmpty) ? '—' : name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.heading3(
                          color: AppColors.onImage,
                        ).copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        (email == null || email.isEmpty) ? '—' : email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyMedium(
                          color: AppColors.onImage.withValues(alpha: 0.85),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        context.tr.profileTripsBooked(tripsBooked),
                        style: AppTextStyles.bodyMedium(
                          color: AppColors.yellow,
                        ).copyWith(fontWeight: FontWeight.w700),
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

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg(context),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: 18.w,
              end: 18.w,
              top: 16.h,
              bottom: 8.h,
            ),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                title,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.greyText(context),
                ).copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class _CardDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 18.w, end: 18.w),
      child: Divider(height: 1.h, color: AppColors.border(context)),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.cardBg(context),
          side: BorderSide(color: AppColors.border(context)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Iconsax.logout_1, size: 18.sp, color: AppColors.red),
            SizedBox(width: 10.w),
            Text(
              context.tr.profileLogout,
              style: AppTextStyles.button(
                color: AppColors.red,
              ).copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

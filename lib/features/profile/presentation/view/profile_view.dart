import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/widgets/app_cached_network_image.dart';
import 'package:trip_marche/core/widgets/custom_loading.dart';
import 'package:trip_marche/core/widgets/app_confirm_dialog.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/toast/app_toast.dart';

import '../../../../core/extensions/localization.dart';
import '../../../../core/storage/data/storage.dart';
import '../../../../core/widgets/profile_image_source_bottom_sheet.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../auth/presentation/view/login_view.dart';
import '../../../settings/presentation/view/customer_service_view.dart';
import '../../../settings/presentation/view/faqs_view.dart';
import '../../../settings/presentation/view/settings_view.dart';
import '../../../settings/presentation/view/terms_view.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../cubit/update_profile_cubit.dart';
import '../cubit/update_profile_state.dart';
import '../theme/profile_handoff_tokens.dart';
import '../widgets/menu_item.dart';
import '../widgets/profile_avatar.dart';
import 'my_followings_view.dart';
import 'my_reviews_view.dart';
import 'personal_info_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _isUploadingAvatar = false;

  @override
  Widget build(BuildContext context) {
    final t = ProfileHandoffTokens.of(context);
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final purpleH = t.w(ProfileHandoffTokens.kHeaderGradientHeightFigma);
    final hInset = t.w(ProfileHandoffTokens.kHorizontalInsetFigma);
    final scrollBottomPad = bottomInset + t.w(16);
    final firstCardTop = t.w(ProfileHandoffTokens.kFirstCardTopFigma) - 20;

    // ProfileView owns its ProfileCubit scope. We reuse the app-wide
    // singleton instance (sl<ProfileCubit>()) so the same state is shared
    // with the nav shell. Providing it here guarantees the provider is
    // always found above this widget, whether ProfileView is rendered as a
    // tab or pushed through navigation (no "Could not find Provider" error).
    // The Builder ensures no context.read<ProfileCubit>() runs before the
    // BlocProvider is inserted into the tree.
    return BlocProvider<ProfileCubit>.value(
      value: sl<ProfileCubit>(),
      child: Builder(
        builder: (context) {
          return BlocProvider(
            create: (_) => UpdateProfileCubit(
              UpdateProfileUseCase(sl<ProfileRepository>()),
            ),
            child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
              listenWhen: (previous, current) =>
                  current.status == UpdateProfileStatus.success,
              listener: (context, state) {
                context.read<ProfileCubit>().fetchProfile();
              },
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, profileState) {
                  final profile = profileState.profile;
                  final name = profile?.name;
                  final email = profile?.email;
                  final tripsBooked = profile?.stats.tripsBooked ?? 0;
                  final avatarUrl = profile?.avatar;

                  final updateCubit = context.watch<UpdateProfileCubit>();
                  final avatarPreviewPath = updateCubit.state.avatarPreviewPath;
            final effectiveAvatar = avatarPreviewPath != null
                ? FileImage(File(avatarPreviewPath))
                : (avatarUrl != null
                    ? AppCachedNetworkImage.getImageProvider(avatarUrl)
                    : null);

            Widget bodyContent;
            if (profileState.status == ProfileStatus.loading &&
                profile == null) {
              bodyContent = SizedBox(
                height: 200,
                child: const CustomLoading(size: 36, strokeWidth: 2.5),
              );
            } else if (profileState.status == ProfileStatus.failure) {
              bodyContent = Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48,
                        color: AppColors.greyText(context),
                      ),
                      SizedBox(height: 12),
                      Text(
                        profileState.errorMessage ?? 'Something went wrong',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium(
                          color: AppColors.greyText(context),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<ProfileCubit>().fetchProfile(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Retry',
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.onPrimary(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              bodyContent = _buildScrollableCards(
                context,
                t,
                hInset,
                scrollBottomPad,
                avatarUrl: avatarUrl,
              );
            }

            return Scaffold(
              backgroundColor: ProfileHandoffTokens.canvas(context),
              body: Stack(
                children: [
                  SizedBox(
                    height: purpleH,
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: ProfileHandoffTokens.headerGradient(),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: t.w(ProfileHandoffTokens.kAvatarRowTopFigma),
                    start: hInset,
                    end: hInset,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfileAvatar(
                          backgroundImage: effectiveAvatar,
                          onEditTap: _isUploadingAvatar
                              ? null
                              : _handleAvatarEdit,
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
                  Column(
                    children: [
                      SizedBox(height: firstCardTop),
                      Expanded(child: bodyContent),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      );
      },
    ),
    );
  }

  Future<void> _handleAvatarEdit() async {
    final cubit = context.read<UpdateProfileCubit>();
    final pickFailedMsg = context.tr.profilePhotoPickFailed;
    final successMsg = context.tr.profileUpdateSuccess;

    final pickedFile = await showImageSourceBottomSheet(context);
    if (pickedFile == null || !mounted) return;

    setState(() => _isUploadingAvatar = true);

    try {
      cubit.setAvatarPreview(pickedFile);
      await cubit.updateProfile(avatarFile: pickedFile);

      if (!mounted) return;

      final newState = cubit.state;
      if (newState.status == UpdateProfileStatus.failure) {
        appToast(
          context: context,
          type: ToastType.error,
          message: newState.errorMessage ?? pickFailedMsg,
        );
      } else if (newState.status == UpdateProfileStatus.success) {
        appToast(
          context: context,
          type: ToastType.success,
          message: successMsg,
        );
      }
    } catch (_) {
      if (mounted) {
        appToast(
          context: context,
          type: ToastType.error,
          message: pickFailedMsg,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUploadingAvatar = false);
      }
    }
  }

  Widget _buildScrollableCards(
    BuildContext context,
    ProfileHandoffTokens t,
    double hInset,
    double scrollBottomPad, {
    String? avatarUrl,
  }) {
    return RefreshIndicator(
      onRefresh: () => context.read<ProfileCubit>().fetchProfile(),
      child: SingleChildScrollView(
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
                    onTap: () => sl<AppNavigator>().push(
                      screen: MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: context.read<ProfileCubit>(),
                          ),
                          BlocProvider.value(
                            value: context.read<UpdateProfileCubit>(),
                          ),
                        ],
                        child: const PersonalInfoView(),
                      ),
                    ),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../features/profile/domain/repositories/profile_repository.dart';
import '../../../../features/profile/domain/usecases/update_profile_usecase.dart';
import '../../../../features/profile/domain/usecases/change_password_usecase.dart';
import '../../../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../../../features/profile/presentation/cubit/profile_state.dart';
import '../../../../features/profile/presentation/cubit/update_profile_cubit.dart';
import '../../../../features/profile/presentation/view/edit_profile_bottom_sheet.dart';
import '../../../../features/profile/presentation/cubit/change_password_cubit.dart';
import '../../../../features/profile/presentation/view/change_password_bottom_sheet.dart';

class PersonalInfoView extends StatelessWidget {
  const PersonalInfoView({super.key});

  Future<void> _openChangePasswordSheet(BuildContext context) async {
    final cubit = ChangePasswordCubit(
      ChangePasswordUseCase(sl<ProfileRepository>()),
    );

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: AppColors.cardBg(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => BlocProvider.value(
        value: cubit,
        child: const ChangePasswordBottomSheet(),
      ),
    );
  }

  Future<void> _openEditSheet(BuildContext context, EditProfileField field) async {
    final profile = context.read<ProfileCubit>().state.profile;
    final initialValue = profile?.name ?? '';
    final initialCountryCode = profile?.phone?.countryCode ?? '';
    final initialNumber = profile?.phone?.number ?? '';

    final cubit = UpdateProfileCubit(
      UpdateProfileUseCase(sl<ProfileRepository>()),
    );

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBg(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => BlocProvider.value(
        value: cubit,
        child: EditProfileBottomSheet(
          field: field,
          initialValue: initialValue,
          initialCountryCode: initialCountryCode,
          initialNumber: initialNumber,
        ),
      ),
    );

    if (context.mounted) {
      context.read<ProfileCubit>().fetchProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profile = state.profile;
        final fullName = profile?.name ?? '-';
        final email = profile?.email ?? '-';
        final phoneNumber = profile?.phone?.full ?? '-';
        final country = profile?.country;
        final city = profile?.city;

        return Scaffold(
          backgroundColor: AppColors.background(context),
          appBar: AppBar(
            backgroundColor: AppColors.background(context),
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.darkText(context),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              context.tr.profilePersonalInfoTitle,
              style: AppTextStyles.subtitle(color: AppColors.darkText(context)),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 10.h),
            child: Column(
              children: [
                _InfoRow(
                  label: context.tr.profileFullNameLabel,
                  value: fullName,
                  actionText: context.tr.profileEditAction,
                  onAction: () => _openEditSheet(context, EditProfileField.name),
                ),
                _DividerLine(),
                _InfoRow(
                  label: context.tr.profileEmailLabel,
                  value: email,
                ),
                _DividerLine(),
                _InfoRow(
                  label: context.tr.profilePhoneNumberLabel,
                  value: phoneNumber,
                  actionText: context.tr.profileEditAction,
                  onAction: () => _openEditSheet(context, EditProfileField.phone),
                ),
                _DividerLine(),
                _InfoRow(
                  label: context.tr.profilePasswordLabel,
                  value: '***********',
                  actionText: context.tr.profileChangePasswordAction,
                  onAction: () => _openChangePasswordSheet(context),
                ),
                _DividerLine(),
                _InfoRow(label: context.tr.profileCountryLabel, value: country ?? '-'),
                _DividerLine(),
                _InfoRow(label: context.tr.profileCityLabel, value: city ?? '-'),
                _DividerLine(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.actionText,
    this.onAction,
  });

  final String label;
  final String value;
  final String? actionText;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 18.h, bottom: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.darkText(context),
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10.h),
                Text(
                  value,
                  style: AppTextStyles.bodyMedium(color: AppColors.greyText(context)),
                ),
              ],
            ),
          ),
          if (actionText != null)
            Padding(
              padding: EdgeInsetsDirectional.only(top: 26.h),
              child: InkWell(
                onTap: onAction,
                child: Text(
                  actionText!,
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.darkText(context),
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 1.h, color: AppColors.border(context));
  }
}

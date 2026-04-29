import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/config/app_icons.dart';
import '../../../../core/toast/app_toast.dart';
import '../../domain/repositories/auth_repository.dart';
import '../cubit/reset_password/reset_password_cubit.dart';
import '../cubit/reset_password/reset_password_state.dart';
import '../widgets/auth_header.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({
    super.key,
    required this.email,
    required this.code,
  });

  final String email;
  final String code;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetPasswordCubit(
        sl<AppNavigator>(),
        sl<AuthRepository>(),
        email: email,
        code: code,
      ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: BlocListener<ResetPasswordCubit, ResetPasswordState>(
              listenWhen: (p, n) => p.status != n.status,
              listener: (context, state) {
                if (state.status == ResetPasswordStatus.failure) {
                  final desc = state.validationErrorsDescription;
                  final msg = state.errorMessage ?? 'Something went wrong';
                  appToast(
                    context: context,
                    type: ToastType.error,
                    message: msg,
                    description: desc != msg ? desc : null,
                  );
                }
                if (state.status == ResetPasswordStatus.success) {
                  appToast(
                    context: context,
                    type: ToastType.success,
                    message: 'Password reset successfully',
                  );
                }
              },
              child: AuthHeader(
                showIllustration: false,
                compactTopBar: true,
                onBack: () => sl<AppNavigator>().pop(),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr.authResetPasswordTitle,
                        style: AppTextStyles.heading2(),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        context.tr.authResetPasswordSubtitle,
                        style: AppTextStyles.body(color: AppColors.greyText),
                      ),
                      const SizedBox(height: 32),

                      Text(
                        context.tr.authNewPasswordLabel,
                        style: AppTextStyles.bodyMedium(
                          color: AppColors.darkText,
                        ).copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                        buildWhen: (p, n) =>
                            p.obscurePassword != n.obscurePassword,
                        builder: (context, state) {
                          return AppTextField(
                            hint: context.tr.authNewPasswordHint,
                            controller: context
                                .read<ResetPasswordCubit>()
                                .passwordController,
                            obscureText: state.obscurePassword,
                            prefixWidget: Padding(
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                AppIcons.icLock,
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                  AppColors.greyText,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                state.obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.greyText,
                                size: 20,
                              ),
                              onPressed: context
                                  .read<ResetPasswordCubit>()
                                  .toggleObscurePassword,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),

                      Text(
                        context.tr.authConfirmNewPasswordLabel,
                        style: AppTextStyles.bodyMedium(
                          color: AppColors.darkText,
                        ).copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                        buildWhen: (p, n) =>
                            p.obscureConfirmPassword !=
                            n.obscureConfirmPassword,
                        builder: (context, state) {
                          return AppTextField(
                            hint: context.tr.authConfirmNewPasswordHint,
                            controller: context
                                .read<ResetPasswordCubit>()
                                .confirmPasswordController,
                            obscureText: state.obscureConfirmPassword,
                            prefixWidget: Padding(
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                AppIcons.icLock,
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                  AppColors.greyText,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                state.obscureConfirmPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.greyText,
                                size: 20,
                              ),
                              onPressed: context
                                  .read<ResetPasswordCubit>()
                                  .toggleObscureConfirmPassword,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 44),

                      BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                        buildWhen: (p, n) => p.status != n.status,
                        builder: (context, state) {
                          final isLoading =
                              state.status == ResetPasswordStatus.loading;
                          return AppButton(
                            text: isLoading
                                ? null
                                : context.tr.authResetPasswordButton,
                            radius: 999,
                            heigh: 54,
                            onTap: isLoading
                                ? null
                                : () {
                                    context
                                        .read<ResetPasswordCubit>()
                                        .submit();
                                  },
                            child: isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : null,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

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
import '../cubit/forgot_password/forgot_password_cubit.dart';
import '../cubit/forgot_password/forgot_password_state.dart';
import '../widgets/auth_header.dart';
import '../../../../core/toast/app_toast.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ForgotPasswordCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
              listenWhen: (p, n) => p.status != n.status,
              listener: (context, state) {
                if (state.status == ForgotPasswordStatus.failure) {
                  appToast(
                    context: context,
                    type: ToastType.error,
                    message: state.errorMessage ?? 'Something went wrong',
                  );
                }
              },
              child: AuthHeader(
              showIllustration: false,
              compactTopBar: true,
              onBack: () => sl<AppNavigator>().pop(),
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr.authForgotPasswordTitle,
                      style: AppTextStyles.heading2(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.tr.authForgotPasswordSubtitle,
                      style: AppTextStyles.body(color: AppColors.greyText),
                    ),
                    const SizedBox(height: 32),

                    _FieldTitle(text: context.tr.authEmailLabel),
                    const SizedBox(height: 8),
                    AppTextField(
                      hint: context.tr.authEmailHint,
                      controller:
                          context.read<ForgotPasswordCubit>().emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixWidget: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          AppIcons.icSms,
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                            AppColors.greyText,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 44),

                    BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      buildWhen: (p, n) => p.status != n.status,
                      builder: (context, state) {
                        final isLoading = state.status == ForgotPasswordStatus.loading;
                        return AppButton(
                          text: isLoading ? null : context.tr.authSendCodeButton,
                          radius: 999,
                          heigh: 54,
                          onTap: isLoading ? null : () {
                            context.read<ForgotPasswordCubit>().submit();
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

class _FieldTitle extends StatelessWidget {
  const _FieldTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.bodyMedium(color: AppColors.darkText).copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/config/styles/styles.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/widgets/social_login_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../widgets/auth_header.dart';
import '../widgets/divider_with_text.dart';
import '../../../../core/extensions/localization.dart';
import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_state.dart';
import '../../../../core/config/app_icons.dart';
import '../../../../core/toast/app_toast.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: BlocListener<LoginCubit, LoginState>(
              listenWhen: (p, n) => p.status != n.status,
              listener: (context, state) {
                if (state.status == LoginStatus.failure) {
                  final desc = state.validationErrorsDescription;
                  final msg = state.errorMessage ?? 'Something went wrong';
                  appToast(
                    context: context,
                    type: ToastType.error,
                    message: msg,
                    description: desc != msg ? desc : null,
                  );
                }
              },
              child: AuthHeader(
                scrollable: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    // Title
                    Text(
                      context.tr.authLoginTitle,
                      style: GoogleFonts.inter(
                        fontSize: AppFonts.heading2,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkText,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _FieldTitle(text: context.tr.authEmailLabel),
                    const SizedBox(height: 8),
                    AppTextField(
                      hint: context.tr.authEmailHint,
                      controller: context.read<LoginCubit>().emailController,
                      prefixWidget: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          AppIcons.icSms,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            AppColors.greyText,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 18),

                    _FieldTitle(text: context.tr.authPasswordLabel),
                    const SizedBox(height: 8),
                    BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (p, n) =>
                          p.obscurePassword != n.obscurePassword,
                      builder: (context, state) {
                        return AppTextField(
                          hint: context.tr.authPasswordHint,
                          controller: context
                              .read<LoginCubit>()
                              .passwordController,
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
                          obscureText: state.obscurePassword,
                          suffixIcon: GestureDetector(
                            onTap: context
                                .read<LoginCubit>()
                                .toggleObscurePassword,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                AppIcons.icEyeSlash,
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                  AppColors.greyText,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),

                    // Forget Password
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: context.read<LoginCubit>().openForgotPassword,
                        child: Text(
                          context.tr.authForgotPassword,
                          style: GoogleFonts.inter(
                            fontSize: AppFonts.bodySmall,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Login button
                    BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (p, n) => p.status != n.status,
                      builder: (context, state) {
                        final isLoading = state.status == LoginStatus.loading;
                        return SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : () {
                              context.read<LoginCubit>().submitLogin();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Text(
                                    context.tr.authLoginButton,
                                    style: GoogleFonts.inter(
                                      fontSize: AppFonts.bodyLarge,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Don't have an account? Create One
                    Center(
                      child: GestureDetector(
                        onTap: context.read<LoginCubit>().openSignUp,
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.inter(
                              fontSize: AppFonts.bodyMedium,
                              color: AppColors.greyText,
                            ),
                            children: [
                              TextSpan(text: context.tr.authNoAccountPrompt),
                              TextSpan(
                                text: context.tr.authCreateOne,
                                style: GoogleFonts.inter(
                                  fontSize: AppFonts.bodyMedium,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Divider: "Or Login with"
                    DividerWithText(text: context.tr.authOrLoginWith),
                    const SizedBox(height: 14),

                    // Continue with Google
                    SocialLoginButton(
                      icon: SvgPicture.asset(
                        AppIcons.icGoogle,
                        width: 20,
                        height: 20,
                      ),
                      text: context.tr.authContinueWithGoogle,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),

                    // Continue with Apple
                    SocialLoginButton(
                      icon: SvgPicture.asset(
                        AppIcons.icApple,
                        width: 20,
                        height: 20,
                      ),
                      text: context.tr.authContinueWithApple,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 18),

                    // Travel Agency
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.inter(
                            fontSize: AppFonts.bodyMedium,
                            color: AppColors.greyText,
                          ),
                          children: [
                            TextSpan(text: context.tr.authTravelAgencyPrompt),
                            TextSpan(
                              text: context.tr.authJoinAsTripPartner,
                              style: GoogleFonts.inter(
                                fontSize: AppFonts.bodyMedium,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
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
      style: GoogleFonts.inter(
        fontSize: AppFonts.bodyLarge,
        fontWeight: FontWeight.w700,
        color: AppColors.darkText,
      ),
    );
  }
}

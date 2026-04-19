import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/widgets/social_login_button.dart';
import 'package:trip_marche/core/widgets/app_text_field.dart';
import 'package:trip_marche/features/auth/presentation/widgets/auth_header.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:trip_marche/features/auth/presentation/cubit/login/login_state.dart';
import 'package:trip_marche/core/config/app_icons.dart';

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
            body: AuthHeader(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              const SizedBox(height: 24),

              // Email field
              AppTextField(
                label: context.tr.authEmailLabel,
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
              const SizedBox(height: 16),

              // Password field
              BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (p, n) => p.obscurePassword != n.obscurePassword,
                builder: (context, state) {
                  return AppTextField(
                    label: context.tr.authPasswordLabel,
                    hint: context.tr.authPasswordHint,
                    controller: context.read<LoginCubit>().passwordController,
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
                      onTap: context.read<LoginCubit>().toggleObscurePassword,
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
              const SizedBox(height: 8),

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
              const SizedBox(height: 24),

              // Login button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: context.read<LoginCubit>().submitLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    context.tr.authLoginButton,
                    style: GoogleFonts.inter(
                      fontSize: AppFonts.bodyLarge,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
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
              const SizedBox(height: 24),

              // Divider: "Or Login with"
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: const Color(0xFF9A9A9A).withValues(alpha: 0.4),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      context.tr.authOrLoginWith,
                      style: GoogleFonts.inter(
                        fontSize: AppFonts.bodyMedium,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF9A9A9A),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: const Color(0xFF9A9A9A).withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

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
              const SizedBox(height: 24),

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
          );
        },
      ),
    );
  }
}

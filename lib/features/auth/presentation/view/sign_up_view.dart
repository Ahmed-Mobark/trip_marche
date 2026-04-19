import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/widgets/app_button.dart';
import 'package:trip_marche/core/widgets/app_text_field.dart';
import 'package:trip_marche/core/widgets/social_login_button.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/features/auth/presentation/cubit/sign_up/sign_up_cubit.dart';
import 'package:trip_marche/features/auth/presentation/cubit/sign_up/sign_up_state.dart';
import 'package:trip_marche/features/auth/presentation/widgets/auth_link_text.dart';
import 'package:trip_marche/features/auth/presentation/widgets/divider_with_text.dart';
import 'package:trip_marche/core/extensions/localization.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SignUpCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              // Back arrow
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.inputBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: AppColors.darkText,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Text(context.tr.authSignUpTitle, style: AppTextStyles.heading2()),
              const SizedBox(height: 24),

              // Full Name
              AppTextField(
                label: context.tr.authFullNameLabel,
                hint: context.tr.authFullNameHint,
                controller: context.read<SignUpCubit>().fullNameController,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16),

              // Email
              AppTextField(
                label: context.tr.authEmailLabel,
                hint: context.tr.authEmailHint,
                controller: context.read<SignUpCubit>().emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Phone Number
              AppTextField(
                label: context.tr.authPhoneLabel,
                hint: context.tr.authPhoneHint,
                controller: context.read<SignUpCubit>().phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              // Password
              BlocBuilder<SignUpCubit, SignUpState>(
                buildWhen: (p, n) => p.obscurePassword != n.obscurePassword,
                builder: (context, state) {
                  return AppTextField(
                    label: context.tr.authPasswordLabel,
                    hint: context.tr.authPasswordHint,
                    controller: context.read<SignUpCubit>().passwordController,
                    obscureText: state.obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.greyText,
                        size: 20,
                      ),
                      onPressed: context.read<SignUpCubit>().toggleObscurePassword,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Confirm Password
              BlocBuilder<SignUpCubit, SignUpState>(
                buildWhen: (p, n) =>
                    p.obscureConfirmPassword != n.obscureConfirmPassword,
                builder: (context, state) {
                  return AppTextField(
                    label: context.tr.authConfirmPasswordLabel,
                    hint: context.tr.authConfirmPasswordHint,
                    controller:
                        context.read<SignUpCubit>().confirmPasswordController,
                    obscureText: state.obscureConfirmPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.obscureConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.greyText,
                        size: 20,
                      ),
                      onPressed:
                          context.read<SignUpCubit>().toggleObscureConfirmPassword,
                    ),
                  );
                },
              ),
              const SizedBox(height: 28),

              // Sign Up button
              AppButton(
                text: context.tr.authSignUpButton,
                onTap: () {
                  context.read<SignUpCubit>().submitSignUp();
                },
              ),
              const SizedBox(height: 24),

              // Or Sign Up with divider
              DividerWithText(text: context.tr.authOrSignUpWith),
              const SizedBox(height: 20),

              // Social login buttons
              SocialLoginButton(
                icon: const Icon(Icons.g_mobiledata_outlined, size: 24),
                text: context.tr.authSocialGoogle,
                onPressed: () {},
              ),

              const SizedBox(height: 12),
              SocialLoginButton(
                icon: const Icon(Icons.apple, size: 24),
                text: context.tr.authSocialApple,
                onPressed: () {},
              ),
              const SizedBox(height: 24),

              // Already have an account
              AuthLinkText(
                leadingText: context.tr.authHaveAccountPrompt,
                actionText: context.tr.authLoginAction,
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 24),
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

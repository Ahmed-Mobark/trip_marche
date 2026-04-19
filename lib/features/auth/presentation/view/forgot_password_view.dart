import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/widgets/app_button.dart';
import 'package:trip_marche/core/widgets/app_text_field.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';

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
            body: SafeArea(
              child: Padding(
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

              Text(
                context.tr.authForgotPasswordTitle,
                style: AppTextStyles.heading2(),
              ),
              const SizedBox(height: 12),

              Text(
                context.tr.authForgotPasswordDescription,
                style: AppTextStyles.body(color: AppColors.greyText),
              ),
              const SizedBox(height: 32),

              // Email field
              AppTextField(
                label: context.tr.authEmailLabel,
                hint: context.tr.authEmailHint,
                controller: context.read<ForgotPasswordCubit>().emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 32),

              // Send button
              AppButton(
                text: context.tr.authSendButton,
                onTap: () {
                  context.read<ForgotPasswordCubit>().submit();
                },
              ),
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

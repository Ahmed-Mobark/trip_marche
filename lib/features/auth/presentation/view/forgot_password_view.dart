import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/widgets/app_button.dart';
import 'package:trip_marche/core/widgets/app_text_field.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/config/app_icons.dart';
import 'package:trip_marche/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:trip_marche/features/auth/presentation/widgets/auth_header.dart';

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
            body: AuthHeader(
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

                    AppButton(
                      text: context.tr.authSendCodeButton,
                      radius: 999,
                      heigh: 54,
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

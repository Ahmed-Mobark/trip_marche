import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_icons.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/toast/app_toast.dart';
import 'package:trip_marche/core/widgets/app_button.dart';
import 'package:trip_marche/core/widgets/app_text_field.dart';
import 'package:trip_marche/core/widgets/social_login_button.dart';
import '../cubit/sign_up/sign_up_cubit.dart';
import '../cubit/sign_up/sign_up_state.dart';
import '../widgets/auth_link_text.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_phone_number_field.dart';
import '../widgets/divider_with_text.dart';

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
            body: BlocListener<SignUpCubit, SignUpState>(
              listenWhen: (p, n) => p.status != n.status,
              listener: (context, state) {
                if (state.status == SignUpStatus.failure) {
                  final desc = state.validationErrorsDescription;
                  final msg = state.errorMessage ?? 'Something went wrong';
                  appToast(
                    context: context,
                    type: ToastType.error,
                    message: msg,
                    description: desc != msg ? desc : null,
                  );
                }
                if (state.status == SignUpStatus.success) {
                  appToast(
                    context: context,
                    type: ToastType.success,
                    message: state.successMessage ?? 'Registration successful',
                  );
                }
              },
              child: AuthHeader(
                scrollable: true,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 20.w,
                    end: 20.w,
                    top: 20.h,
                    bottom: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr.authSignUpSubtitle,
                        style: AppTextStyles.heading2(
                          color: AppColors.darkText,
                        ).copyWith(fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: 18.h),

                      _FieldTitle(text: context.tr.authFullNameLabel),
                      SizedBox(height: 8.h),
                      AppTextField(
                        validator: (value) =>
                            context.read<SignUpCubit>().validateName(value),
                        hint: context.tr.authFullNameHint,
                        controller: context
                            .read<SignUpCubit>()
                            .fullNameController,
                        keyboardType: TextInputType.name,
                        prefixWidget: Padding(
                          padding: EdgeInsets.all(12.r),
                          child: Icon(
                            Icons.person_outline,
                            size: 22.sp,
                            color: AppColors.greyText,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      _FieldTitle(text: context.tr.authEmailLabel),
                      SizedBox(height: 8.h),
                      AppTextField(
                        validator: (value) =>
                            context.read<SignUpCubit>().validateEmail(value),
                        hint: context.tr.authEmailHint,
                        controller: context.read<SignUpCubit>().emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixWidget: Padding(
                          padding: EdgeInsets.all(12.r),
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
                      ),
                      SizedBox(height: 16.h),

                      _FieldTitle(text: context.tr.authPasswordLabel),
                      SizedBox(height: 8.h),
                      BlocBuilder<SignUpCubit, SignUpState>(
                        buildWhen: (p, n) =>
                            p.obscurePassword != n.obscurePassword,
                        builder: (context, state) {
                          return AppTextField(
                            validator: (value) => context
                                .read<SignUpCubit>()
                                .validatePassword(value),
                            errorMaxLines: 2,

                            hint: context.tr.authPasswordHint,
                            controller: context
                                .read<SignUpCubit>()
                                .passwordController,
                            obscureText: state.obscurePassword,
                            prefixWidget: Padding(
                              padding: EdgeInsets.all(12.r),
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
                                size: 20.sp,
                              ),
                              onPressed: context
                                  .read<SignUpCubit>()
                                  .toggleObscurePassword,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16.h),

                      _FieldTitle(text: context.tr.authPhoneLabel),
                      SizedBox(height: 8.h),
                      BlocBuilder<SignUpCubit, SignUpState>(
                        buildWhen: (p, n) => p.dialCode != n.dialCode,
                        builder: (context, state) {
                          return AuthPhoneNumberField(
                            validator: (value) => context
                                .read<SignUpCubit>()
                                .validatePhone(value),
                            controller: context
                                .read<SignUpCubit>()
                                .phoneController,
                            hint: context.tr.authPhoneHint,
                            selectedDialCode: state.dialCode,
                            onDialCodeChanged: context
                                .read<SignUpCubit>()
                                .setDialCode,
                          );
                        },
                      ),
                      SizedBox(height: 22.h),

                      // Sign Up button
                      BlocBuilder<SignUpCubit, SignUpState>(
                        buildWhen: (p, n) => p.status != n.status,
                        builder: (context, state) {
                          final isLoading =
                              state.status == SignUpStatus.loading;
                          return AppButton(
                            heigh: 54.h,
                            radius: 999.r,
                            color: AppColors.primary,
                            text: isLoading
                                ? null
                                : context.tr.authSignUpButton,
                            onTap: isLoading
                                ? null
                                : () {
                                    context.read<SignUpCubit>().submitSignUp();
                                  },
                            child: isLoading
                                ? SizedBox(
                                    width: 22.r,
                                    height: 22.r,
                                    child: const CircularProgressIndicator(
                                      color: AppColors.onImage,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : null,
                          );
                        },
                      ),
                      SizedBox(height: 16.h),

                      // Already have an account
                      Center(
                        child: AuthLinkText(
                          leadingText: context.tr.authHaveAccountPrompt,
                          actionText: context.tr.authLoginAction,
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      SizedBox(height: 14.h),

                      // Or Login with divider (design)
                      DividerWithText(text: context.tr.authOrLoginWith),
                      SizedBox(height: 12.h),

                      // Social login buttons
                      SocialLoginButton(
                        icon: SvgPicture.asset(
                          AppIcons.icGoogle,
                          width: 20,
                          height: 20,
                        ),
                        text: context.tr.authContinueWithGoogle,
                        onPressed: () {},
                      ),

                      SizedBox(height: 12.h),
                      SocialLoginButton(
                        icon: SvgPicture.asset(
                          AppIcons.icApple,
                          width: 20,
                          height: 20,
                        ),
                        text: context.tr.authContinueWithApple,
                        onPressed: () {},
                      ),
                      SizedBox(height: 16.h),
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
    return Text(text, style: AppTextStyles.subtitle(color: AppColors.darkText));
  }
}

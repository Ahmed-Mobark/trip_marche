import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_icons.dart';
import 'package:trip_marche/core/config/app_web_urls.dart';
import 'package:trip_marche/core/config/styles/styles.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/toast/app_toast.dart';
import 'package:trip_marche/core/widgets/app_button.dart';
import 'package:trip_marche/core/widgets/app_text_field.dart';
import 'package:trip_marche/core/widgets/app_web_view_screen.dart';
import 'package:trip_marche/core/widgets/social_login_button.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/auth_header.dart';
import '../widgets/divider_with_text.dart';
import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_state.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.background(context),
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
                  padding: EdgeInsetsDirectional.only(
                    start: 20.w,
                    end: 20.w,
                    top: 20.h,
                    bottom: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        context.tr.authLoginTitle,
                        style: AppTextStyles.heading2(
                          color: AppColors.darkText(context),
                        ).copyWith(fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: 20.h),
                      _FieldTitle(text: context.tr.authEmailLabel),
                      SizedBox(height: 8.h),
                      AppTextField(
                        hint: context.tr.authEmailHint,
                        controller: context.read<LoginCubit>().emailController,
                        prefixWidget: Padding(
                          padding: EdgeInsets.all(12.r),
                          child: SvgPicture.asset(
                            AppIcons.icSms,
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              AppColors.greyText(context),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 18.h),

                      _FieldTitle(text: context.tr.authPasswordLabel),
                      SizedBox(height: 8.h),
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
                              padding: EdgeInsets.all(12.r),
                              child: SvgPicture.asset(
                                AppIcons.icLock,
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                  AppColors.greyText(context),
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
                                padding: EdgeInsets.all(12.r),
                                child: SvgPicture.asset(
                                  AppIcons.icEyeSlash,
                                  width: 20,
                                  height: 20,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.greyText(context),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.h),

                      // Forget Password
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: context.read<LoginCubit>().openForgotPassword,
                          child: Text(
                            context.tr.authForgotPassword,
                            style: AppTextStyles.bodySmall(
                              color: AppColors.primary,
                            ).copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(height: 22.h),

                      // Login button
                      BlocBuilder<LoginCubit, LoginState>(
                        buildWhen: (p, n) => p.status != n.status,
                        builder: (context, state) {
                          final isLoading = state.status == LoginStatus.loading;
                          return AppButton(
                            heigh: 54.h,
                            radius: 999.r,
                            color: AppColors.primary,
                            onTap: isLoading
                                ? null
                                : () =>
                                      context.read<LoginCubit>().submitLogin(),
                            child: isLoading
                                ? SizedBox(
                                    width: 22.r,
                                    height: 22.r,
                                    child: const CircularProgressIndicator(
                                      color: AppColors.onImage,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Text(
                                    context.tr.authLoginButton,
                                    style: AppTextStyles.button(
                                      color: AppColors.onImage,
                                    ).copyWith(fontWeight: FontWeight.w700),
                                  ),
                          );
                        },
                      ),
                      SizedBox(height: 16.h),

                      // Don't have an account? Create One
                      Center(
                        child: GestureDetector(
                          onTap: context.read<LoginCubit>().openSignUp,
                          child: RichText(
                            text: TextSpan(
                              style: AppTextStyles.bodyMedium(
                                color: AppColors.greyText(context),
                              ),
                              children: [
                                TextSpan(text: context.tr.authNoAccountPrompt),
                                TextSpan(
                                  text: context.tr.authCreateOne,
                                  style: AppTextStyles.bodyMedium(
                                    color: AppColors.primary,
                                  ).copyWith(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 18.h),

                      // Divider: "Or Login with"
                      DividerWithText(text: context.tr.authOrLoginWith),
                      SizedBox(height: 14.h),

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
                      SizedBox(height: 12.h),

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
                      SizedBox(height: 18.h),

                      // Vendor / partner portal (opens in-app webview)
                      Center(
                        child: Semantics(
                          button: true,
                          label:
                              '${context.tr.authTravelAgencyPrompt}${context.tr.authJoinAsTripPartner}',
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                sl<AppNavigator>().push(
                                  screen: AppWebViewScreen(
                                    title:
                                        context.tr.authPartnerPortalTitle,
                                    url: AppWebUrls.partnerPortalLogin,
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(14.r),
                              splashColor:
                                  AppColors.primary.withValues(alpha: 0.12),
                              highlightColor:
                                  AppColors.primary.withValues(alpha: 0.06),
                              child: Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 12.w,
                                  vertical: 12.h,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Iconsax.shop,
                                      size: 22.sp,
                                      color: AppColors.primary,
                                    ),
                                    SizedBox(width: 10.w),
                                    Flexible(
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          style: AppTextStyles.bodyMedium(
                                            color: AppColors.greyText(context),
                                          ),
                                          children: [
                                            TextSpan(
                                              text: context
                                                  .tr.authTravelAgencyPrompt,
                                            ),
                                            TextSpan(
                                              text: context
                                                  .tr.authJoinAsTripPartner,
                                              style: AppTextStyles.bodyMedium(
                                                color: AppColors.primary,
                                              ).copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
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
    return Text(
      text,
      style: AppTextStyles.bodyMedium(
        color: AppColors.darkText(context),
      ).copyWith(fontWeight: FontWeight.w700),
    );
  }
}

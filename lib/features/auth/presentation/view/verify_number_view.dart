import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/config/app_icons.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/app_button.dart';
import 'package:trip_marche/features/auth/presentation/widgets/otp_input_field.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/features/auth/presentation/cubit/verify_number/verify_number_cubit.dart';
import 'package:trip_marche/features/auth/presentation/cubit/verify_number/verify_number_state.dart';
import 'package:trip_marche/features/auth/presentation/widgets/auth_header.dart';

class VerifyNumberView extends StatelessWidget {
  const VerifyNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<VerifyNumberCubit>()..startTimer(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: AuthHeader(
              illustration: AppIcons.verifyIcon,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr.authVerifyEmailTitle,
                      style: AppTextStyles.heading2(),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      context.tr.authVerifyEmailSubtitle,
                      style: AppTextStyles.body(color: AppColors.greyText),
                    ),
                    const SizedBox(height: 18),

                    Center(
                      child: OtpInputField(
                        length: 6,
                        boxSize: 52,
                        spacing: 12,
                        onCompleted: (_) {},
                      ),
                    ),
                    const SizedBox(height: 14),

                    Center(
                      child: BlocBuilder<VerifyNumberCubit, VerifyNumberState>(
                        buildWhen: (p, n) => p.canResend != n.canResend,
                        builder: (context, state) {
                          final canResend = state.canResend;
                          return RichText(
                            text: TextSpan(
                              style: AppTextStyles.bodySmall(
                                color: AppColors.greyText,
                              ),
                              children: [
                                TextSpan(
                                  text: context
                                      .tr
                                      .authVerificationCodeNotReceived,
                                ),
                                const TextSpan(text: ' '),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: GestureDetector(
                                    onTap: canResend
                                        ? context
                                              .read<VerifyNumberCubit>()
                                              .resend
                                        : null,
                                    child: Text(
                                      context.tr.authResendNow,
                                      style: AppTextStyles.bodySmall(
                                        color: canResend
                                            ? AppColors.primary
                                            : AppColors.greyText,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 22),

                    AppButton(
                      text: context.tr.authVerifyButton,
                      radius: 999,
                      heigh: 54,
                      onTap: () {
                        context.read<VerifyNumberCubit>().verify();
                      },
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: SizedBox(
                        width: 400.w,
                        height: 54,
                        child: OutlinedButton(
                          onPressed: () => sl<AppNavigator>().pop(),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(54, 54),
                            fixedSize: const Size(54, 54),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            side: const BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            context.tr.authBack,
                            style: AppTextStyles.bodyMedium(
                              color: AppColors.primary,
                            ),
                          ),
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

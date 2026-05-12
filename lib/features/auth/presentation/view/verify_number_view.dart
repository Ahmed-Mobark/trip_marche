import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/config/app_icons.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../widgets/otp_input_field.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/injection/injection_container.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/storage/data/storage.dart';
import '../cubit/verify_number/verify_number_cubit.dart';
import '../cubit/verify_number/verify_number_state.dart';
import '../widgets/auth_header.dart';
import '../../../../core/toast/app_toast.dart';

class VerifyNumberView extends StatelessWidget {
  const VerifyNumberView({
    super.key,
    required this.email,
    this.verifyType = VerifyType.emailVerification,
  });

  final String email;
  final VerifyType verifyType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerifyNumberCubit(
        sl<AppNavigator>(),
        sl<AuthRepository>(),
        sl<Storage>(),
        email: email,
        verifyType: verifyType,
      )..startTimer(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.background(context),
            body: BlocListener<VerifyNumberCubit, VerifyNumberState>(
              listenWhen: (p, n) => p.status != n.status,
              listener: (context, state) {
                if (state.status == VerifyStatus.failure) {
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
                        style: AppTextStyles.body(
                          color: AppColors.greyText(context),
                        ),
                      ),
                      const SizedBox(height: 18),

                      Center(
                        child: OtpInputField(
                          length: 6,
                          boxSize: 48,
                          spacing: 9,
                          onChanged: (code) {
                            context.read<VerifyNumberCubit>().setOtpCode(code);
                          },
                          onCompleted: (_) {
                            context.read<VerifyNumberCubit>().verify();
                          },
                        ),
                      ),
                      const SizedBox(height: 14),

                      Center(
                        child:
                            BlocBuilder<VerifyNumberCubit, VerifyNumberState>(
                              buildWhen: (p, n) => p.canResend != n.canResend,
                              builder: (context, state) {
                                final canResend = state.canResend;
                                return RichText(
                                  text: TextSpan(
                                    style: AppTextStyles.bodySmall(
                                      color: AppColors.greyText(context),
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
                                                  : AppColors.greyText(context),
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

                      BlocBuilder<VerifyNumberCubit, VerifyNumberState>(
                        buildWhen: (p, n) => p.status != n.status,
                        builder: (context, state) {
                          final isLoading =
                              state.status == VerifyStatus.loading;
                          return AppButton(
                            text: isLoading
                                ? null
                                : context.tr.authVerifyButton,
                            radius: 999,
                            heigh: 54,
                            onTap: isLoading
                                ? null
                                : () {
                                    context.read<VerifyNumberCubit>().verify();
                                  },
                            child: isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: AppColors.onImage,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : null,
                          );
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
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/widgets/app_button.dart';
import 'package:trip_marche/features/auth/presentation/widgets/otp_input_field.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/features/auth/presentation/cubit/verify_number/verify_number_cubit.dart';
import 'package:trip_marche/features/auth/presentation/cubit/verify_number/verify_number_state.dart';

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

              Text(context.tr.authVerifyTitle, style: AppTextStyles.heading2()),
              const SizedBox(height: 12),

              Text(
                context.tr.authVerifyDescription,
                style: AppTextStyles.body(color: AppColors.greyText),
              ),
              const SizedBox(height: 32),

              // OTP input boxes
              OtpInputField(length: 4, onCompleted: (_) {}),
              const SizedBox(height: 24),

              // Timer
              Center(
                child: BlocBuilder<VerifyNumberCubit, VerifyNumberState>(
                  buildWhen: (p, n) =>
                      p.secondsRemaining != n.secondsRemaining,
                  builder: (context, state) {
                    final minutes = (state.secondsRemaining ~/ 60)
                        .toString()
                        .padLeft(2, '0');
                    final seconds = (state.secondsRemaining % 60)
                        .toString()
                        .padLeft(2, '0');
                    final formatted = '$minutes:$seconds';
                    return Text(
                      formatted,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),

              // Verify button
              AppButton(
                text: context.tr.authVerifyButton,
                onTap: () {
                  context.read<VerifyNumberCubit>().verify();
                },
              ),
              const SizedBox(height: 24),

              // Resend Code
              Center(
                child: GestureDetector(
                  onTap: () => context.read<VerifyNumberCubit>().resend(),
                  child: Text(
                    context.tr.authResendCode,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: context.watch<VerifyNumberCubit>().state.canResend
                          ? AppColors.primary
                          : AppColors.greyText,
                    ),
                  ),
                ),
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

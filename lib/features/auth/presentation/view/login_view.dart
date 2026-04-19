import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_fonts.dart';
import 'package:trip_marche/core/widgets/app_text_field.dart';
import 'package:trip_marche/core/widgets/social_login_button.dart';
import 'package:trip_marche/features/auth/presentation/widgets/auth_header.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AuthHeader(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Login To Your Account',
                style: GoogleFonts.inter(
                  fontSize: AppFonts.heading2,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 24),

              // Email field
              AppTextField(
                label: 'Email',
                hint: 'Enter your email',
                controller: _emailController,
                prefixSvg: 'assets/icons/ic_sms.svg',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Password field
              AppTextField(
                label: 'Password',
                hint: 'Enter your password',
                controller: _passwordController,
                prefixSvg: 'assets/icons/ic_lock.svg',
                obscureText: _obscurePassword,
                suffixIcon: GestureDetector(
                  onTap: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      'assets/icons/ic_eye_slash.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        AppColors.greyText,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Forget Password
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/forgot-password'),
                  child: Text(
                    'Forget Your Password?',
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
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    'Login',
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
                  onTap: () => Navigator.pushNamed(context, '/sign-up'),
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.inter(
                        fontSize: AppFonts.bodyMedium,
                        color: AppColors.greyText,
                      ),
                      children: [
                        const TextSpan(text: "Don't have an account? "),
                        TextSpan(
                          text: 'Create One',
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
                      'Or Login with',
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
                  'assets/icons/ic_google.svg',
                  width: 20,
                  height: 20,
                ),
                text: 'Continue with Google',
              ),
              const SizedBox(height: 12),

              // Continue with Apple
              SocialLoginButton(
                icon: SvgPicture.asset(
                  'assets/icons/ic_apple.svg',
                  width: 20,
                  height: 20,
                ),
                text: 'Continue with Apple',
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
                      const TextSpan(text: 'Travel Agency? '),
                      TextSpan(
                        text: 'Join as a trip partner',
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
  }
}

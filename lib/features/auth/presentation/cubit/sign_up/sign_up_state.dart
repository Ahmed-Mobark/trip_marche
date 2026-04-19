import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.dialCode = '+20',
  });

  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final String dialCode;

  SignUpState copyWith({
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    String? dialCode,
  }) {
    return SignUpState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      dialCode: dialCode ?? this.dialCode,
    );
  }

  @override
  List<Object?> get props => [obscurePassword, obscureConfirmPassword, dialCode];
}


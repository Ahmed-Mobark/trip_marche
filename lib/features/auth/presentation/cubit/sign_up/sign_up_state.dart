import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
  });

  final bool obscurePassword;
  final bool obscureConfirmPassword;

  SignUpState copyWith({
    bool? obscurePassword,
    bool? obscureConfirmPassword,
  }) {
    return SignUpState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
    );
  }

  @override
  List<Object?> get props => [obscurePassword, obscureConfirmPassword];
}


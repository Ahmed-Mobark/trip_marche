import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  const LoginState({
    this.obscurePassword = true,
  });

  final bool obscurePassword;

  LoginState copyWith({
    bool? obscurePassword,
  }) {
    return LoginState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }

  @override
  List<Object?> get props => [obscurePassword];
}


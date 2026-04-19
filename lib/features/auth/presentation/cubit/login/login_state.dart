import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  const LoginState({
    this.obscurePassword = true,
    this.status = LoginStatus.initial,
    this.errorMessage,
    this.validationErrors,
  });

  final bool obscurePassword;
  final LoginStatus status;
  final String? errorMessage;
  final Map<String, dynamic>? validationErrors;

  String? get validationErrorsDescription {
    if (validationErrors == null || validationErrors!.isEmpty) return null;
    return validationErrors!.entries.map((e) {
      final msgs =
          e.value is List ? (e.value as List).join(', ') : e.value.toString();
      return msgs;
    }).join('\n');
  }

  LoginState copyWith({
    bool? obscurePassword,
    LoginStatus? status,
    String? errorMessage,
    Map<String, dynamic>? validationErrors,
  }) {
    return LoginState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      status: status ?? this.status,
      errorMessage: errorMessage,
      validationErrors: validationErrors,
    );
  }

  @override
  List<Object?> get props => [
        obscurePassword,
        status,
        errorMessage,
        validationErrors,
      ];
}

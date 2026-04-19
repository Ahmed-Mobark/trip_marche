import 'package:equatable/equatable.dart';

enum ResetPasswordStatus { initial, loading, success, failure }

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.status = ResetPasswordStatus.initial,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.errorMessage,
    this.validationErrors,
  });

  final ResetPasswordStatus status;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
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

  ResetPasswordState copyWith({
    ResetPasswordStatus? status,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    String? errorMessage,
    Map<String, dynamic>? validationErrors,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      errorMessage: errorMessage,
      validationErrors: validationErrors,
    );
  }

  @override
  List<Object?> get props => [
        status,
        obscurePassword,
        obscureConfirmPassword,
        errorMessage,
        validationErrors,
      ];
}

import 'package:equatable/equatable.dart';

enum SignUpStatus { initial, loading, success, failure }

class SignUpState extends Equatable {
  const SignUpState({
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.dialCode = '+20',
    this.status = SignUpStatus.initial,
    this.errorMessage,
    this.successMessage,
    this.validationErrors,
  });

  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final String dialCode;
  final SignUpStatus status;
  final String? errorMessage;
  final String? successMessage;
  final Map<String, dynamic>? validationErrors;

  /// Returns a combined description of all validation errors.
  String? get validationErrorsDescription {
    if (validationErrors == null || validationErrors!.isEmpty) return null;
    return validationErrors!.entries.map((e) {
      final msgs = e.value is List ? (e.value as List).join(', ') : e.value.toString();
      return msgs;
    }).join('\n');
  }

  SignUpState copyWith({
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    String? dialCode,
    SignUpStatus? status,
    String? errorMessage,
    String? successMessage,
    Map<String, dynamic>? validationErrors,
  }) {
    return SignUpState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      dialCode: dialCode ?? this.dialCode,
      status: status ?? this.status,
      errorMessage: errorMessage,
      successMessage: successMessage,
      validationErrors: validationErrors,
    );
  }
  

  @override
  List<Object?> get props => [
        obscurePassword,
        obscureConfirmPassword,
        dialCode,
        status,
        errorMessage,
        successMessage,
        validationErrors,
      ];
}

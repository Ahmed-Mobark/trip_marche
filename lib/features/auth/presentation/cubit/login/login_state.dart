import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure }

enum SocialLoginProvider { google, apple }

class LoginState extends Equatable {
  const LoginState({
    this.obscurePassword = true,
    this.status = LoginStatus.initial,
    this.socialProvider,
    this.isGuestLoading = false,
    this.errorMessage,
    this.validationErrors,
  });

  final bool obscurePassword;
  final LoginStatus status;
  final SocialLoginProvider? socialProvider;
  final bool isGuestLoading;
  final String? errorMessage;
  final Map<String, dynamic>? validationErrors;

  String? get validationErrorsDescription {
    if (validationErrors == null || validationErrors!.isEmpty) return null;
    return validationErrors!.entries
        .map((e) {
          final msgs = e.value is List
              ? (e.value as List).join(', ')
              : e.value.toString();
          return msgs;
        })
        .join('\n');
  }

  LoginState copyWith({
    bool? obscurePassword,
    LoginStatus? status,
    SocialLoginProvider? socialProvider,
    bool? isGuestLoading,
    String? errorMessage,
    Map<String, dynamic>? validationErrors,
    bool clearSocialProvider = false,
  }) {
    return LoginState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      status: status ?? this.status,
      socialProvider: clearSocialProvider
          ? null
          : socialProvider ?? this.socialProvider,
      isGuestLoading: isGuestLoading ?? this.isGuestLoading,
      errorMessage: errorMessage,
      validationErrors: validationErrors,
    );
  }

  @override
  List<Object?> get props => [
    obscurePassword,
    status,
    socialProvider,
    isGuestLoading,
    errorMessage,
    validationErrors,
  ];
}

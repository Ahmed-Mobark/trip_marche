import 'package:equatable/equatable.dart';

enum VerifyStatus { initial, loading, success, failure }

class VerifyNumberState extends Equatable {
  const VerifyNumberState({
    this.secondsRemaining = 60,
    this.canResend = false,
    this.status = VerifyStatus.initial,
    this.errorMessage,
    this.validationErrors,
  });

  final int secondsRemaining;
  final bool canResend;
  final VerifyStatus status;
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

  VerifyNumberState copyWith({
    int? secondsRemaining,
    bool? canResend,
    VerifyStatus? status,
    String? errorMessage,
    Map<String, dynamic>? validationErrors,
  }) {
    return VerifyNumberState(
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      canResend: canResend ?? this.canResend,
      status: status ?? this.status,
      errorMessage: errorMessage,
      validationErrors: validationErrors,
    );
  }

  @override
  List<Object?> get props => [
    secondsRemaining,
    canResend,
    status,
    errorMessage,
    validationErrors,
  ];
}

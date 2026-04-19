import 'package:equatable/equatable.dart';

class VerifyNumberState extends Equatable {
  const VerifyNumberState({
    this.secondsRemaining = 60,
    this.canResend = false,
  });

  final int secondsRemaining;
  final bool canResend;

  VerifyNumberState copyWith({
    int? secondsRemaining,
    bool? canResend,
  }) {
    return VerifyNumberState(
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      canResend: canResend ?? this.canResend,
    );
  }

  @override
  List<Object?> get props => [secondsRemaining, canResend];
}


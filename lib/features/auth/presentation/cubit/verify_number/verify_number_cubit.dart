import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/navigation/app_navigator.dart';
import '../../../../../core/storage/data/storage.dart';
import '../../../data/models/verify_email_request.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'verify_number_state.dart';
import '../../view/reset_password_view.dart';
import '../../../../nav_bar/presentation/view/main_nav_view.dart';

enum VerifyType { emailVerification, passwordReset }

class VerifyNumberCubit extends Cubit<VerifyNumberState> {
  VerifyNumberCubit(
    this._navigator,
    this._authRepository,
    this._storage, {
    required this.email,
    required this.verifyType,
  }) : super(const VerifyNumberState());

  final AppNavigator _navigator;
  final AuthRepository _authRepository;
  final Storage _storage;
  final String email;
  final VerifyType verifyType;
  Timer? _timer;

  String _otpCode = '';

  void setOtpCode(String code) {
    _otpCode = code;
  }

  void startTimer() {
    _timer?.cancel();
    emit(const VerifyNumberState(secondsRemaining: 60, canResend: false));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final next = state.secondsRemaining - 1;
      if (next <= 0) {
        timer.cancel();
        emit(state.copyWith(secondsRemaining: 0, canResend: true));
      } else {
        emit(state.copyWith(secondsRemaining: next));
      }
    });
  }

  String get _resendType => verifyType == VerifyType.passwordReset
      ? 'password_reset'
      : 'email_verification';

  Future<void> resend() async {
    if (!state.canResend) return;

    final result = await _authRepository.sendOtp(
      email: email,
      type: _resendType,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: VerifyStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (_) => startTimer(),
    );
  }

  Future<void> verify() async {
    if (_otpCode.length < 6) return;

    emit(state.copyWith(status: VerifyStatus.loading));

    if (verifyType == VerifyType.emailVerification) {
      await _verifyEmail();
    } else {
      await _verifyOtp();
    }
  }

  Future<void> _verifyEmail() async {
    final request = VerifyEmailRequest(email: email, code: _otpCode);
    final result = await _authRepository.verifyEmail(request);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: VerifyStatus.failure,
          errorMessage: failure.message,
          validationErrors: failure.errors,
        ));
      },
      (data) async {
        final user = data['data'];
        if (user is Map<String, dynamic>) {
          await _storage.storeUser(userJson: user);
        }

        final token = (user is Map<String, dynamic>)
            ? user['token'] as String?
            : data['data']?['token'] as String?;
        if (token != null) {
          await _storage.storeToken(token: token);
        }
        emit(state.copyWith(status: VerifyStatus.success));
        _navigator.pushAndRemoveUntil(screen: const MainNavView());
      },
    );
  }

  Future<void> _verifyOtp() async {
    final result = await _authRepository.verifyOtp(
      email: email,
      code: _otpCode,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: VerifyStatus.failure,
          errorMessage: failure.message,
          validationErrors: failure.errors,
        ));
      },
      (_) {
        emit(state.copyWith(status: VerifyStatus.success));
        _navigator.push(
          screen: ResetPasswordView(email: email, code: _otpCode),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/features/auth/data/models/reset_password_request.dart';
import 'package:trip_marche/features/auth/data/repositories/auth_repository.dart';
import 'package:trip_marche/features/auth/presentation/cubit/reset_password/reset_password_state.dart';
import 'package:trip_marche/features/auth/presentation/view/login_view.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(
    this._navigator,
    this._authRepository, {
    required this.email,
    required this.code,
  }) : super(const ResetPasswordState());

  final AppNavigator _navigator;
  final AuthRepository _authRepository;
  final String email;
  final String code;

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void toggleObscurePassword() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleObscureConfirmPassword() {
    emit(state.copyWith(
        obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  Future<void> submit() async {
    emit(state.copyWith(status: ResetPasswordStatus.loading));

    final request = ResetPasswordRequest(
      email: email,
      code: code,
      password: passwordController.text,
      passwordConfirmation: confirmPasswordController.text,
    );

    final result = await _authRepository.resetPassword(request);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: ResetPasswordStatus.failure,
          errorMessage: failure.message,
          validationErrors: failure.errors,
        ));
      },
      (_) {
        emit(state.copyWith(status: ResetPasswordStatus.success));
        _navigator.pushAndRemoveUntil(screen: const LoginView());
      },
    );
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}

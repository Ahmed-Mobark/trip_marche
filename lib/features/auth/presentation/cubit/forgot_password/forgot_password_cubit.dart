import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/features/auth/data/repositories/auth_repository.dart';
import 'package:trip_marche/features/auth/presentation/cubit/forgot_password/forgot_password_state.dart';
import 'package:trip_marche/features/auth/presentation/cubit/verify_number/verify_number_cubit.dart';
import 'package:trip_marche/features/auth/presentation/view/verify_number_view.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._navigator, this._authRepository)
      : super(const ForgotPasswordState());

  final AppNavigator _navigator;
  final AuthRepository _authRepository;

  final emailController = TextEditingController();

  Future<void> submit() async {
    emit(state.copyWith(status: ForgotPasswordStatus.loading));

    final result = await _authRepository.sendOtp(
      email: emailController.text.trim(),
      type: 'password_reset',
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: ForgotPasswordStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (_) {
        emit(state.copyWith(status: ForgotPasswordStatus.success));
        _navigator.push(
          screen: VerifyNumberView(
            email: emailController.text.trim(),
            verifyType: VerifyType.passwordReset,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}

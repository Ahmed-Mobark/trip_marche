import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/features/auth/data/models/register_request.dart';
import 'package:trip_marche/features/auth/domain/repositories/auth_repository.dart';
import 'package:trip_marche/features/auth/presentation/cubit/sign_up/sign_up_state.dart';
import 'package:trip_marche/features/auth/presentation/view/verify_number_view.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._navigator, this._authRepository) : super(const SignUpState());

  final AppNavigator _navigator;
  final AuthRepository _authRepository;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void toggleObscurePassword() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleObscureConfirmPassword() {
    emit(
      state.copyWith(
        obscureConfirmPassword: !state.obscureConfirmPassword,
      ),
    );
  }

  void setDialCode(String dialCode) {
    if (dialCode == state.dialCode) return;
    emit(state.copyWith(dialCode: dialCode));
  }

  Future<void> submitSignUp() async {
    emit(state.copyWith(status: SignUpStatus.loading));

    final request = RegisterRequest(
      name: fullNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      phoneNumber: phoneController.text.trim(),
      countryCode: state.dialCode,
    );

    final result = await _authRepository.register(request);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: failure.message,
          validationErrors: failure.errors,
        ));
      },
      (data) {
        final message = data['message'] as String?;
        emit(state.copyWith(
          status: SignUpStatus.success,
          successMessage: message,
        ));
        _navigator.push(
          screen: VerifyNumberView(email: emailController.text.trim()),
        );
      },
    );
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/features/auth/presentation/cubit/sign_up/sign_up_state.dart';
import 'package:trip_marche/features/auth/presentation/view/verify_number_view.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._navigator) : super(const SignUpState());

  final AppNavigator _navigator;

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

  void submitSignUp() {
    _navigator.push(screen: const VerifyNumberView());
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


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/features/auth/presentation/cubit/login/login_state.dart';
import 'package:trip_marche/features/auth/presentation/view/forgot_password_view.dart';
import 'package:trip_marche/features/auth/presentation/view/sign_up_view.dart';
import 'package:trip_marche/features/nav_bar/presentation/view/main_nav_view.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._navigator) : super(const LoginState());

  final AppNavigator _navigator;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void toggleObscurePassword() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void openForgotPassword() {
    _navigator.push(screen: const ForgotPasswordView());
  }

  void openSignUp() {
    _navigator.push(screen: const SignUpView());
  }

  void submitLogin() {
    _navigator.pushAndRemoveUntil(screen: const MainNavView());
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}


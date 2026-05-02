import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/navigation/app_navigator.dart';
import '../../../../../core/storage/data/storage.dart';
import '../../../data/models/login_request.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'login_state.dart';
import '../../view/forgot_password_view.dart';
import '../../view/sign_up_view.dart';
import '../../../../nav_bar/presentation/view/main_nav_view.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._navigator, this._authRepository, this._storage)
    : super(const LoginState());

  final AppNavigator _navigator;
  final AuthRepository _authRepository;
  final Storage _storage;

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

  Future<void> submitLogin() async {
    emit(state.copyWith(status: LoginStatus.loading));

    final request = LoginRequest(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    final result = await _authRepository.login(request);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            errorMessage: failure.message,
            validationErrors: failure.errors,
          ),
        );
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
        emit(state.copyWith(status: LoginStatus.success));
        _navigator.pushAndRemoveUntil(screen: const MainNavView());
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/navigation/app_navigator.dart';
import '../../../../../core/notification/firebase_notification_service.dart';
import '../../../../../core/storage/data/storage.dart';
import '../../../data/datasources/social_auth_service.dart';
import '../../../data/models/login_request.dart';
import '../../../data/models/social_login_request.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'login_state.dart';
import '../../view/forgot_password_view.dart';
import '../../view/sign_up_view.dart';
import '../../../../nav_bar/presentation/view/main_nav_view.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
    this._navigator,
    this._authRepository,
    this._storage,
    this._notifications,
    this._socialAuthService,
  ) : super(const LoginState());

  final AppNavigator _navigator;
  final AuthRepository _authRepository;
  final Storage _storage;
  final FirebaseNotificationService _notifications;
  final SocialAuthService _socialAuthService;

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

    await result.fold(
      (failure) async => _emitFailure(failure.message, failure.errors),
      _completeAuthenticatedLogin,
    );
  }

  Future<void> continueWithGoogle() async {
    await _submitSocialLogin(
      SocialLoginProvider.google,
      _socialAuthService.signInWithGoogle,
    );
  }

  Future<void> continueWithApple() async {
    await _submitSocialLogin(
      SocialLoginProvider.apple,
      _socialAuthService.signInWithApple,
    );
  }

  Future<void> continueAsGuest() async {
    emit(
      state.copyWith(
        status: LoginStatus.initial,
        isGuestLoading: true,
        clearSocialProvider: true,
      ),
    );
    await _storage.deleteToken();
    await _storage.deleteUser();
    emit(state.copyWith(isGuestLoading: false));
    _navigator.pushAndRemoveUntil(screen: const MainNavView());
  }

  Future<void> _submitSocialLogin(
    SocialLoginProvider provider,
    Future<SocialLoginRequest> Function() signIn,
  ) async {
    emit(
      state.copyWith(
        status: LoginStatus.loading,
        socialProvider: provider,
        isGuestLoading: false,
      ),
    );

    try {
      final request = await signIn();
      final result = await _authRepository.socialLogin(request);
      await result.fold(
        (failure) async => _emitFailure(failure.message, failure.errors),
        _completeAuthenticatedLogin,
      );
    } on SocialLoginCancelled {
      emit(
        state.copyWith(status: LoginStatus.initial, clearSocialProvider: true),
      );
    } on UnsupportedError catch (error) {
      _emitFailure(error.message ?? 'This sign-in method is not available.');
    } catch (_) {
      _emitFailure('Social login failed. Please try again.');
    }
  }

  Future<void> _completeAuthenticatedLogin(Map<String, dynamic> data) async {
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
    await _notifications.registerCurrentDevice();
    emit(
      state.copyWith(status: LoginStatus.success, clearSocialProvider: true),
    );
    _navigator.pushAndRemoveUntil(screen: const MainNavView());
  }

  void _emitFailure(String message, [Map<String, dynamic>? errors]) {
    emit(
      state.copyWith(
        status: LoginStatus.failure,
        errorMessage: message,
        validationErrors: errors,
        isGuestLoading: false,
        clearSocialProvider: true,
      ),
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}

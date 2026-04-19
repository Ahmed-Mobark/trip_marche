import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/features/auth/presentation/view/verify_number_view.dart';

class ForgotPasswordCubit extends Cubit<void> {
  ForgotPasswordCubit(this._navigator) : super(null);

  final AppNavigator _navigator;

  final emailController = TextEditingController();

  void submit() {
    _navigator.push(screen: const VerifyNumberView());
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}


import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/features/auth/presentation/cubit/verify_number/verify_number_state.dart';
import 'package:trip_marche/features/nav_bar/presentation/view/main_nav_view.dart';

class VerifyNumberCubit extends Cubit<VerifyNumberState> {
  VerifyNumberCubit(this._navigator) : super(const VerifyNumberState());

  final AppNavigator _navigator;
  Timer? _timer;

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

  void resend() {
    if (!state.canResend) return;
    startTimer();
  }

  void verify() {
    _navigator.pushAndRemoveUntil(screen: const MainNavView());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/storage/data/storage.dart';
import '../../../../../core/notification/firebase_notification_service.dart';
import '../../../../../core/toast/app_toast.dart';
import '../../../domain/usecases/logout_usecase.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this._logoutUseCase, this._storage, this._notifications)
    : super(const LogoutState());

  final LogoutUseCase _logoutUseCase;
  final Storage _storage;
  final FirebaseNotificationService _notifications;

  Future<void> logout(BuildContext context) async {
    if (state.status == LogoutStatus.loading) return;
    debugPrint("Logout button pressed");
    debugPrint("Emit Loading");
    emit(state.copyWith(status: LogoutStatus.loading));

    debugPrint("Calling API...");
    final result = await _logoutUseCase();

    result.fold(
      (failure) {
        debugPrint("API Failure: ${failure.message}");
        emit(
          state.copyWith(
            status: LogoutStatus.failure,
            errorMessage: failure.message,
          ),
        );
        appToast(
          context: context,
          type: ToastType.error,
          message: failure.message,
        );
      },
      (_) {
        debugPrint("API Success");
        emit(state.copyWith(status: LogoutStatus.success));
      },
    );
  }

  Future<void> clearSession() async {
    await _notifications.unregisterCurrentDevice();
    await _storage.deleteToken();
    await _storage.deleteUser();
  }

  void clearError() {
    if (state.status == LogoutStatus.failure) {
      emit(state.copyWith(status: LogoutStatus.initial, errorMessage: null));
    }
  }
}

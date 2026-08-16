import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/data/storage.dart';
import '../../../../core/toast/app_toast.dart';
import '../../domain/usecases/delete_account_usecase.dart';
import 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit(this._deleteAccountUseCase, this._storage)
    : super(const DeleteAccountState());

  final DeleteAccountUseCase _deleteAccountUseCase;
  final Storage _storage;

  Future<void> deleteAccount(BuildContext context) async {
    if (state.status == DeleteAccountStatus.loading) return;
    debugPrint("Delete Account button pressed");
    debugPrint("Emit Loading");
    emit(state.copyWith(status: DeleteAccountStatus.loading));

    debugPrint("Calling API...");
    final result = await _deleteAccountUseCase();

    result.fold(
      (failure) {
        debugPrint("API Failure: ${failure.message}");
        emit(
          state.copyWith(
            status: DeleteAccountStatus.failure,
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
        emit(state.copyWith(status: DeleteAccountStatus.success));
      },
    );
  }

  Future<void> clearSession() async {
    await _storage.deleteToken();
    await _storage.deleteUser();
    await _storage.deleteLang();
    await _storage.deleteThemeMode();
  }

  void clearError() {
    if (state.status == DeleteAccountStatus.failure) {
      emit(state.copyWith(status: DeleteAccountStatus.initial, errorMessage: null));
    }
  }
}

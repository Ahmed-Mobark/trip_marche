import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/change_password_request.dart';
import '../../domain/usecases/change_password_usecase.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this._changePasswordUseCase)
      : super(const ChangePasswordState());

  final ChangePasswordUseCase _changePasswordUseCase;

  Future<void> changePassword({
    required String currentPassword,
    required String password,
  }) async {
    if (state.status == ChangePasswordStatus.loading) return;
    emit(state.copyWith(status: ChangePasswordStatus.loading));

    final request = ChangePasswordRequest(
      currentPassword: currentPassword,
      password: password,
    );

    final result = await _changePasswordUseCase(request);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: ChangePasswordStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (_) {
        emit(state.copyWith(
          status: ChangePasswordStatus.success,
          errorMessage: null,
        ));
      },
    );
  }

  void reset() {
    emit(const ChangePasswordState());
  }
}

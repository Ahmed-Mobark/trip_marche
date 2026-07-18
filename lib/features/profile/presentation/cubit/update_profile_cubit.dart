import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/profile_update_request.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this._updateProfileUseCase)
      : super(const UpdateProfileState());

  final UpdateProfileUseCase _updateProfileUseCase;

  Future<void> updateProfile({
    required String field,
    required String value,
  }) async {
    if (state.status == UpdateProfileStatus.loading) return;
    emit(state.copyWith(status: UpdateProfileStatus.loading));

    final request = field == 'name'
        ? ProfileUpdateRequest(name: value)
        : ProfileUpdateRequest(phone: value);

    final result = await _updateProfileUseCase(request);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: UpdateProfileStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (_) {
        emit(state.copyWith(
          status: UpdateProfileStatus.success,
          errorMessage: null,
        ));
      },
    );
  }

  void reset() {
    emit(const UpdateProfileState());
  }
}

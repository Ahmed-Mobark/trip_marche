import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getProfileUseCase) : super(const ProfileState());

  final GetProfileUseCase _getProfileUseCase;

  Future<void> fetchProfile({bool showErrorToast = true}) async {
    if (state.status == ProfileStatus.loading) return;
    emit(state.copyWith(status: ProfileStatus.loading));

    final result = await _getProfileUseCase();

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (profile) {
        emit(state.copyWith(
          status: ProfileStatus.success,
          profile: profile,
          errorMessage: null,
        ));
      },
    );
  }

  void clearError() {
    if (state.status == ProfileStatus.failure) {
      emit(state.copyWith(status: ProfileStatus.initial, errorMessage: null));
    }
  }
}

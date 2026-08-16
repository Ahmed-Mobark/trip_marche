import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/following_entity.dart';
import '../../domain/usecases/get_followings_usecase.dart';
import '../../domain/usecases/toggle_follow_vendor_usecase.dart';
import 'followings_state.dart';

class FollowingsCubit extends Cubit<FollowingsState> {
  FollowingsCubit(this._getFollowingsUseCase, this._toggleFollowVendorUseCase)
      : super(const FollowingsState());

  final GetFollowingsUseCase _getFollowingsUseCase;
  final ToggleFollowVendorUseCase _toggleFollowVendorUseCase;
  final Set<int> _followBusy = {};

  Future<void> fetchFollowings() async {
    if (state.status == FollowingsStatus.loading) return;
    emit(state.copyWith(status: FollowingsStatus.loading, clearError: true));

    final result = await _getFollowingsUseCase();

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: FollowingsStatus.failure,
          errorMessage: failure.message,
        ));
      },
      (parsed) {
        emit(state.copyWith(
          status: FollowingsStatus.success,
          companies: parsed.companies,
          errorMessage: null,
        ));
      },
    );
  }

  bool isFollowBusy(int vendorId) => _followBusy.contains(vendorId);

  Future<void> toggleFollowVendor(int vendorId) async {
    if (vendorId <= 0 ||
        _followBusy.contains(vendorId) ||
        state.companies.isEmpty) {
      return;
    }

    int companyIndex = -1;
    for (int i = 0; i < state.companies.length; i++) {
      if (state.companies[i].id == vendorId) {
        companyIndex = i;
        break;
      }
    }
    if (companyIndex == -1) return;

    final previous = state.companies[companyIndex].isFollowing;
    _followBusy.add(vendorId);

    emit(state.copyWith(
      busyVendorIds: Set<int>.from(_followBusy),
      clearError: true,
    ));

    final companies = List<FollowingEntity>.from(state.companies);
    companies[companyIndex] = state.companies[companyIndex].copyWith(
      isFollowing: !previous,
    );
    emit(state.copyWith(companies: companies));

    final result = await _toggleFollowVendorUseCase(vendorId);
    _followBusy.remove(vendorId);

    result.fold(
      (failure) {
        final reverted = List<FollowingEntity>.from(state.companies);
        reverted[companyIndex] = reverted[companyIndex].copyWith(
          isFollowing: previous,
        );
        emit(state.copyWith(
          companies: reverted,
          busyVendorIds: Set<int>.from(_followBusy),
          toggleMessage: failure.message,
          toggleMessageIsError: true,
        ));
      },
      (success) {
        emit(state.copyWith(
          companies: state.companies.map((c) {
            if (c.id == vendorId) {
              return c.copyWith(isFollowing: success.isFollowing);
            }
            return c;
          }).toList(),
          busyVendorIds: Set<int>.from(_followBusy),
          toggleMessage: success.message,
          toggleMessageIsError: false,
        ));
      },
    );
  }

  void clearToggleMessage() {
    emit(state.copyWith(toggleMessage: null));
  }
}

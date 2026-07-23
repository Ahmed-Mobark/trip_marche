import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/features/company_profile/domain/usecases/get_vendor_profile_usecase.dart';
import 'package:trip_marche/features/profile/domain/usecases/toggle_follow_vendor_usecase.dart';
import 'vendor_profile_state.dart';

class VendorProfileCubit extends Cubit<VendorProfileState> {
  VendorProfileCubit(this._getVendorProfile, this._toggleFollowVendorUseCase)
    : super(const VendorProfileInitial());

  final GetVendorProfileUseCase _getVendorProfile;
  final ToggleFollowVendorUseCase _toggleFollowVendorUseCase;
  int? _currentVendorId;
  final Map<int, bool> _followStatusCache = {};
  final Set<int> _followBusy = {};

  Future<void> loadVendorProfile(int vendorId) async {
    if (vendorId <= 0) {
      if (kDebugMode) {
        print(
          '[VendorProfileCubit] loadVendorProfile SKIPPED: vendorId=$vendorId <= 0',
        );
      }
      return;
    }
    if (_currentVendorId == vendorId && state is VendorProfileSuccess) {
      if (kDebugMode) {
        print(
          '[VendorProfileCubit] loadVendorProfile SKIPPED: already loaded vendorId=$vendorId',
        );
      }
      return;
    }

    _currentVendorId = vendorId;
    if (kDebugMode) {
      print('[VendorProfileCubit] loadVendorProfile START vendorId=$vendorId');
    }
    if (kDebugMode) {
      print(
        '[VendorProfileCubit] Before emit Loading, currentState=${state.runtimeType}',
      );
    }
    emit(const VendorProfileLoading());
    if (kDebugMode) {
      print(
        '[VendorProfileCubit] After emit Loading, newState=${state.runtimeType}',
      );
    }

    final result = await _getVendorProfile(vendorId);

    result.fold(
      (failure) {
        if (kDebugMode) {
          print(
            '[VendorProfileCubit] loadVendorProfile FAILURE: ${failure.message}',
          );
        }
        if (_currentVendorId == vendorId) {
          if (kDebugMode) {
            print(
              '[VendorProfileCubit] Before emit Error, currentState=${state.runtimeType}',
            );
          }
          emit(VendorProfileError(failure.message));
          if (kDebugMode) {
            print(
              '[VendorProfileCubit] After emit Error, newState=${state.runtimeType}',
            );
          }
        }
      },
      (profile) {
        if (kDebugMode) {
          print(
            '[VendorProfileCubit] loadVendorProfile SUCCESS vendor=${profile.vendor.name}',
          );
        }
        if (_currentVendorId == vendorId) {
          if (profile.vendor.id > 0) {
            _followStatusCache[profile.vendor.id] =
                profile.vendor.isFollowing ?? false;
          }
          if (kDebugMode) {
            print(
              '[VendorProfileCubit] Before emit Success, currentState=${state.runtimeType}',
            );
          }
          emit(VendorProfileSuccess(profile));
          if (kDebugMode) {
            print(
              '[VendorProfileCubit] After emit Success, newState=${state.runtimeType}',
            );
          }
        }
      },
    );
  }

  bool isFollowing(int vendorId) => _followStatusCache[vendorId] ?? false;

  bool isFollowBusy(int vendorId) => _followBusy.contains(vendorId);

  Future<void> toggleFollow(int vendorId) async {
    if (vendorId <= 0 || _followBusy.contains(vendorId)) {
      if (kDebugMode) {
        print(
          '[VendorProfileCubit] toggleFollow SKIPPED vendorId=$vendorId busy=${_followBusy.contains(vendorId)}',
        );
      }
      return;
    }

    final previous = _followStatusCache[vendorId] ?? false;
    final optimistic = !previous;
    _followBusy.add(vendorId);
    _followStatusCache[vendorId] = optimistic;

    _applyFollowStatus(vendorId, true);

    final result = await _toggleFollowVendorUseCase(vendorId);
    _followBusy.remove(vendorId);

    result.fold(
      (failure) {
        if (kDebugMode) {
          print(
            '[VendorProfileCubit] toggleFollow FAILURE: ${failure.message}',
          );
        }
        _followStatusCache[vendorId] = previous;
        _applyFollowStatus(vendorId, false);
        if (_currentVendorId == vendorId) {
          emit(VendorProfileError(failure.message));
        }
      },
      (success) {
        if (kDebugMode) {
          print(
            '[VendorProfileCubit] toggleFollow SUCCESS isFollowing=${success.isFollowing}',
          );
        }
        _followStatusCache[vendorId] = success.isFollowing;
        _applyFollowStatus(vendorId, false);
      },
    );
  }

  void _applyFollowStatus(int vendorId, bool busy) {
    if (state is! VendorProfileSuccess) {
      if (kDebugMode) {
        print(
          '[VendorProfileCubit] _applyFollowStatus SKIPPED state is not Success',
        );
      }
      return;
    }
    final current = (state as VendorProfileSuccess).profile;
    if (current.vendor.id != vendorId) {
      if (kDebugMode) {
        print(
          '[VendorProfileCubit] _applyFollowStatus SKIPPED vendorId mismatch ${current.vendor.id} vs $vendorId',
        );
      }
      return;
    }
    final isNowFollowing = _followStatusCache[vendorId] ?? false;
    if (kDebugMode) {
      print(
        '[VendorProfileCubit] Before _applyFollowStatus emit, isNowFollowing=$isNowFollowing',
      );
    }
    emit(
      VendorProfileSuccess(
        current.copyWith(
          vendor: current.vendor.copyWith(isFollowing: isNowFollowing),
        ),
      ),
    );
    if (kDebugMode) {
      print(
        '[VendorProfileCubit] After _applyFollowStatus emit, state=${state.runtimeType}',
      );
    }
  }

  Future<void> refresh(int vendorId) async {
    if (vendorId <= 0) {
      if (kDebugMode) {
        print('[VendorProfileCubit] refresh SKIPPED: vendorId=$vendorId <= 0');
      }
      return;
    }
    _currentVendorId = vendorId;
    if (kDebugMode) {
      print('[VendorProfileCubit] refresh START vendorId=$vendorId');
    }
    final result = await _getVendorProfile(vendorId);

    result.fold(
      (failure) {
        if (kDebugMode) {
          print('[VendorProfileCubit] refresh FAILURE: ${failure.message}');
        }
        if (_currentVendorId == vendorId) {
          emit(VendorProfileError(failure.message));
        }
      },
      (profile) {
        if (kDebugMode) {
          print(
            '[VendorProfileCubit] refresh SUCCESS vendor=${profile.vendor.name}',
          );
        }
        if (_currentVendorId == vendorId) {
          if (profile.vendor.id > 0) {
            _followStatusCache[profile.vendor.id] =
                profile.vendor.isFollowing ?? false;
          }
          emit(VendorProfileSuccess(profile));
        }
      },
    );
  }

  void clearError() {
    if (state is VendorProfileError) {
      if (kDebugMode) {
        print('[VendorProfileCubit] clearError');
      }
      emit(const VendorProfileInitial());
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/home_banner_model.dart';
import '../../domain/repositories/home_repository.dart';
import 'home_banners_state.dart';

class HomeBannersCubit extends Cubit<HomeBannersState> {
  HomeBannersCubit(this._homeRepository) : super(const HomeBannersState());

  final HomeRepository _homeRepository;

  Future<void> loadBanners() async {
    emit(state.copyWith(status: HomeBannersStatus.loading));

    final result = await _homeRepository.getHomeBanners();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: HomeBannersStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (data) {
        final response = HomeBannerResponse.fromJson(data);
        emit(
          state.copyWith(
            status: HomeBannersStatus.success,
            banners: response.data,
          ),
        );
      },
    );
  }

  /// Reload banners without dropping existing ones during the request.
  Future<void> refreshBanners() async {
    if (state.status != HomeBannersStatus.success) {
      await loadBanners();
      return;
    }
    final result = await _homeRepository.getHomeBanners();
    result.fold(
      (_) {},
      (data) {
        final response = HomeBannerResponse.fromJson(data);
        emit(
          state.copyWith(
            status: HomeBannersStatus.success,
            banners: response.data,
          ),
        );
      },
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/home_section_response.dart';
import '../../domain/repositories/home_repository.dart';
import 'home_sections_state.dart';

class HomeSectionsCubit extends Cubit<HomeSectionsState> {
  HomeSectionsCubit(this._homeRepository) : super(const HomeSectionsState());

  final HomeRepository _homeRepository;

  Future<void> loadSections() async {
    emit(state.copyWith(status: HomeSectionsStatus.loading));

    final result = await _homeRepository.getHomeSections();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: HomeSectionsStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (data) {
        final response = HomeSectionsResponse.fromJson(data);
        emit(
          state.copyWith(
            status: HomeSectionsStatus.success,
            sections: response.sections,
          ),
        );
      },
    );
  }
}

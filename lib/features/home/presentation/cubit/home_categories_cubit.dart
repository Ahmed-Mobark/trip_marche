import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/home_category_model.dart';
import '../../domain/repositories/home_repository.dart';
import 'home_categories_state.dart';

class HomeCategoriesCubit extends Cubit<HomeCategoriesState> {
  HomeCategoriesCubit(this._homeRepository) : super(const HomeCategoriesState());

  final HomeRepository _homeRepository;

  Future<void> loadCategories() async {
    emit(state.copyWith(status: HomeCategoriesStatus.loading));

    final result = await _homeRepository.getHomeCategories();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: HomeCategoriesStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (data) {
        final response = HomeCategoryResponse.fromJson(data);
        final categories = response.data;
        emit(
          state.copyWith(
            status: HomeCategoriesStatus.success,
            categories: categories,
            selectedSlug: categories.isNotEmpty ? categories.first.slug : null,
            selectedId: categories.isNotEmpty ? categories.first.id : null,
          ),
        );
      },
    );
  }

  void selectCategory(String slug, int id) {
    emit(state.copyWith(selectedSlug: slug, selectedId: id));
  }
}

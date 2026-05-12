import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/home_category_model.dart';
import '../../domain/repositories/home_repository.dart';
import 'home_categories_state.dart';

class HomeCategoriesCubit extends Cubit<HomeCategoriesState> {
  HomeCategoriesCubit(this._homeRepository)
    : super(const HomeCategoriesState());

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
            emptyCategoryIds: const <int>{},
          ),
        );
      },
    );
  }

  void selectCategory(String slug, int id) {
    emit(state.copyWith(selectedSlug: slug, selectedId: id));
  }

  /// Marks a category as known-empty so it is hidden from the tab bar.
  /// If the marked category is the currently selected one, jumps to the next
  /// visible category (or clears the selection if no visible ones remain).
  void markCategoryAsEmpty(int id) {
    if (state.emptyCategoryIds.contains(id)) {
      return;
    }
    final updatedEmpty = <int>{...state.emptyCategoryIds, id};
    final wasSelected = state.selectedId == id;

    if (!wasSelected) {
      emit(state.copyWith(emptyCategoryIds: updatedEmpty));
      return;
    }

    HomeCategoryModel? nextVisible;
    for (final c in state.categories) {
      if (c.id != id && !updatedEmpty.contains(c.id)) {
        nextVisible = c;
        break;
      }
    }

    if (nextVisible == null) {
      emit(
        state.copyWith(
          emptyCategoryIds: updatedEmpty,
          clearSelection: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        emptyCategoryIds: updatedEmpty,
        selectedSlug: nextVisible.slug,
        selectedId: nextVisible.id,
      ),
    );
  }

  /// Reload categories while preserving the selected chip when it still exists.
  Future<void> refreshCategories() async {
    if (state.status != HomeCategoriesStatus.success ||
        state.categories.isEmpty) {
      await loadCategories();
      return;
    }
    final prevSlug = state.selectedSlug;
    final result = await _homeRepository.getHomeCategories();
    result.fold(
      (_) {},
      (data) {
        final response = HomeCategoryResponse.fromJson(data);
        final categories = response.data;
        if (categories.isEmpty) {
          emit(
            const HomeCategoriesState(
              status: HomeCategoriesStatus.success,
              categories: [],
              selectedSlug: null,
              selectedId: null,
            ),
          );
          return;
        }
        var selected = categories.first;
        if (prevSlug != null) {
          for (final c in categories) {
            if (c.slug == prevSlug) {
              selected = c;
              break;
            }
          }
        }
        emit(
          state.copyWith(
            status: HomeCategoriesStatus.success,
            categories: categories,
            selectedSlug: selected.slug,
            selectedId: selected.id,
            emptyCategoryIds: const <int>{},
          ),
        );
      },
    );
  }
}

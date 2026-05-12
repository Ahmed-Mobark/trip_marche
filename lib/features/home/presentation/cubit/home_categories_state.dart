import 'package:equatable/equatable.dart';
import '../../data/models/home_category_model.dart';

enum HomeCategoriesStatus { initial, loading, success, failure }

class HomeCategoriesState extends Equatable {
  const HomeCategoriesState({
    this.status = HomeCategoriesStatus.initial,
    this.categories = const [],
    this.selectedSlug,
    this.selectedId,
    this.errorMessage,
    this.emptyCategoryIds = const <int>{},
  });

  final HomeCategoriesStatus status;
  final List<HomeCategoryModel> categories;
  final String? selectedSlug;
  final int? selectedId;
  final String? errorMessage;

  /// Categories that have been discovered to have no special trips during
  /// this session. They are hidden from the tab bar (client feedback #61).
  final Set<int> emptyCategoryIds;

  /// Categories that should actually be rendered in the tab bar (i.e. all
  /// categories minus the ones known to be empty).
  List<HomeCategoryModel> get visibleCategories {
    if (emptyCategoryIds.isEmpty) {
      return categories;
    }
    return categories
        .where((c) => !emptyCategoryIds.contains(c.id))
        .toList(growable: false);
  }

  bool get hasAnyVisibleCategory => visibleCategories.isNotEmpty;

  HomeCategoriesState copyWith({
    HomeCategoriesStatus? status,
    List<HomeCategoryModel>? categories,
    String? selectedSlug,
    int? selectedId,
    String? errorMessage,
    Set<int>? emptyCategoryIds,
    bool clearSelection = false,
  }) {
    return HomeCategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      selectedSlug: clearSelection ? null : (selectedSlug ?? this.selectedSlug),
      selectedId: clearSelection ? null : (selectedId ?? this.selectedId),
      errorMessage: errorMessage,
      emptyCategoryIds: emptyCategoryIds ?? this.emptyCategoryIds,
    );
  }

  @override
  List<Object?> get props => [
    status,
    categories,
    selectedSlug,
    selectedId,
    errorMessage,
    emptyCategoryIds,
  ];
}

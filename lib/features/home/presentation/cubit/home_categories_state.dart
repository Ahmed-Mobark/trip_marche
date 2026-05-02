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
  });

  final HomeCategoriesStatus status;
  final List<HomeCategoryModel> categories;
  final String? selectedSlug;
  final int? selectedId;
  final String? errorMessage;

  HomeCategoriesState copyWith({
    HomeCategoriesStatus? status,
    List<HomeCategoryModel>? categories,
    String? selectedSlug,
    int? selectedId,
    String? errorMessage,
  }) {
    return HomeCategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      selectedSlug: selectedSlug ?? this.selectedSlug,
      selectedId: selectedId ?? this.selectedId,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    categories,
    selectedSlug,
    selectedId,
    errorMessage,
  ];
}

import 'package:equatable/equatable.dart';
import '../../data/models/home_section_response.dart';

enum HomeSectionsStatus { initial, loading, success, failure }

class HomeSectionsState extends Equatable {
  const HomeSectionsState({
    this.status = HomeSectionsStatus.initial,
    this.sections = const [],
    this.errorMessage,
  });

  final HomeSectionsStatus status;
  final List<HomeSectionModel> sections;
  final String? errorMessage;

  HomeSectionModel? sectionByKey(String key) {
    try {
      return sections.firstWhere((s) => s.key == key);
    } catch (_) {
      return null;
    }
  }

  HomeSectionsState copyWith({
    HomeSectionsStatus? status,
    List<HomeSectionModel>? sections,
    String? errorMessage,
  }) {
    return HomeSectionsState(
      status: status ?? this.status,
      sections: sections ?? this.sections,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, sections, errorMessage];
}

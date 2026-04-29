class HomeCategoryResponse {
  final List<HomeCategoryModel> data;

  const HomeCategoryResponse({required this.data});

  factory HomeCategoryResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>? ?? [];
    return HomeCategoryResponse(
      data: data
          .map((e) => HomeCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class HomeCategoryModel {
  final int id;
  final String name;
  final String slug;

  const HomeCategoryModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory HomeCategoryModel.fromJson(Map<String, dynamic> json) {
    return HomeCategoryModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
    );
  }
}

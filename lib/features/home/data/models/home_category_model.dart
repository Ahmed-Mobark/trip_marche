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

  /// Optional remote icon URL (PNG/SVG). The home_categories endpoint may
  /// include this in `icon` / `icon_url` / `image` keys; we accept any of
  /// them so the UI can light up the tab bar as soon as the API exposes it.
  final String? iconUrl;

  const HomeCategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    this.iconUrl,
  });

  factory HomeCategoryModel.fromJson(Map<String, dynamic> json) {
    String? readIcon() {
      for (final key in const ['icon', 'icon_url', 'image']) {
        final v = json[key];
        if (v is String && v.trim().isNotEmpty) {
          return v.trim();
        }
      }
      return null;
    }

    return HomeCategoryModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      iconUrl: readIcon(),
    );
  }
}

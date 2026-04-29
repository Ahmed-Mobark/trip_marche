class HomeBannerResponse {
  final List<HomeBannerModel> data;

  const HomeBannerResponse({required this.data});

  factory HomeBannerResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>? ?? [];
    return HomeBannerResponse(
      data: data
          .map((e) => HomeBannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class HomeBannerModel {
  final int id;
  final String title;
  final String subtitle;
  final String image;
  final String ctaLabel;
  final String linkUrl;

  const HomeBannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.ctaLabel,
    required this.linkUrl,
  });

  factory HomeBannerModel.fromJson(Map<String, dynamic> json) {
    return HomeBannerModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      image: json['image'] as String? ?? '',
      ctaLabel: json['cta_label'] as String? ?? '',
      linkUrl: json['link_url'] as String? ?? '',
    );
  }
}

import 'home_section_response.dart';

class TrendingDestinationsItemsResponse {
  final List<DestinationModel> destinations;
  final TrendingDestinationsItemsMeta meta;

  const TrendingDestinationsItemsResponse({
    required this.destinations,
    required this.meta,
  });

  factory TrendingDestinationsItemsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    final data = json['data'] as List<dynamic>? ?? [];
    return TrendingDestinationsItemsResponse(
      destinations: data
          .map((e) => DestinationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: TrendingDestinationsItemsMeta.fromJson(
        json['meta'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

class TrendingDestinationsItemsMeta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final String? itemType;
  final String? sectionKey;
  final String? sectionTitle;

  const TrendingDestinationsItemsMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    this.itemType,
    this.sectionKey,
    this.sectionTitle,
  });

  bool get hasMore => currentPage < lastPage;

  factory TrendingDestinationsItemsMeta.fromJson(Map<String, dynamic> json) {
    return TrendingDestinationsItemsMeta(
      currentPage: json['current_page'] as int? ?? 1,
      lastPage: json['last_page'] as int? ?? 1,
      perPage: json['per_page'] as int? ?? 15,
      total: json['total'] as int? ?? 0,
      itemType: json['item_type'] as String?,
      sectionKey: json['section_key'] as String?,
      sectionTitle: json['section_title'] as String?,
    );
  }
}

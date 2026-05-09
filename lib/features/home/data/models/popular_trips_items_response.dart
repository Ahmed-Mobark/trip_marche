import 'home_section_response.dart';

class PopularTripsItemsResponse {
  final List<TripModel> trips;
  final PopularTripsItemsMeta meta;

  const PopularTripsItemsResponse({required this.trips, required this.meta});

  factory PopularTripsItemsResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>? ?? [];
    return PopularTripsItemsResponse(
      trips: data
          .map((e) => TripModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: PopularTripsItemsMeta.fromJson(
        json['meta'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

class PopularTripsItemsMeta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final String? itemType;
  final String? sectionKey;
  final String? sectionTitle;

  const PopularTripsItemsMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    this.itemType,
    this.sectionKey,
    this.sectionTitle,
  });

  bool get hasMore => currentPage < lastPage;

  factory PopularTripsItemsMeta.fromJson(Map<String, dynamic> json) {
    return PopularTripsItemsMeta(
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

import 'home_section_response.dart';

class SponsoredTripsItemsResponse {
  final List<TripModel> trips;
  final SponsoredTripsItemsMeta meta;

  const SponsoredTripsItemsResponse({required this.trips, required this.meta});

  factory SponsoredTripsItemsResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>? ?? [];
    return SponsoredTripsItemsResponse(
      trips: data
          .map((e) => TripModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: SponsoredTripsItemsMeta.fromJson(
        json['meta'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

class SponsoredTripsItemsMeta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final String? itemType;
  final String? sectionKey;
  final String? sectionTitle;

  const SponsoredTripsItemsMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    this.itemType,
    this.sectionKey,
    this.sectionTitle,
  });

  bool get hasMore => currentPage < lastPage;

  factory SponsoredTripsItemsMeta.fromJson(Map<String, dynamic> json) {
    return SponsoredTripsItemsMeta(
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

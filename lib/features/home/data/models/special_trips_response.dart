import '../../data/models/home_section_response.dart';

class SpecialTripsResponse {
  final List<TripModel> trips;
  final PaginationMeta meta;

  const SpecialTripsResponse({required this.trips, required this.meta});

  factory SpecialTripsResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>? ?? [];
    return SpecialTripsResponse(
      trips: data
          .map((e) => TripModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: PaginationMeta.fromJson(
        json['meta'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

class PaginationMeta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const PaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  bool get hasMore => currentPage < lastPage;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json['current_page'] as int? ?? 1,
      lastPage: json['last_page'] as int? ?? 1,
      perPage: json['per_page'] as int? ?? 5,
      total: json['total'] as int? ?? 0,
    );
  }
}

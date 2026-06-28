import 'package:equatable/equatable.dart';

class FilterDestination extends Equatable {
  const FilterDestination({
    required this.id,
    required this.name,
    required this.code,
    required this.slug,
    required this.country,
    this.image,
    this.trendingRank,
  });

  final int id;
  final String name;

  /// Backend destination identifier used in trips catalog `search`.
  final String code;
  final String slug;
  final String country;
  final String? image;
  final int? trendingRank;

  /// Value sent to trips catalog search — prefers [code], falls back to [slug].
  String get searchCode => code.isNotEmpty ? code : slug;

  @override
  List<Object?> get props => [id, name, code, slug, country, image, trendingRank];
}

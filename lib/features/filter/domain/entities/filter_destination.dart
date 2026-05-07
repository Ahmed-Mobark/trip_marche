import 'package:equatable/equatable.dart';

class FilterDestination extends Equatable {
  const FilterDestination({
    required this.id,
    required this.name,
    required this.slug,
    required this.country,
    this.image,
    this.trendingRank,
  });

  final int id;
  final String name;
  final String slug;
  final String country;
  final String? image;
  final int? trendingRank;

  @override
  List<Object?> get props => [id, name, slug, country, image, trendingRank];
}

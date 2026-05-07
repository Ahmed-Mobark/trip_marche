import 'package:trip_marche/features/filter/domain/entities/filter_destination.dart';

class FilterDestinationModel {
  const FilterDestinationModel({
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

  factory FilterDestinationModel.fromJson(Map<String, dynamic> json) {
    return FilterDestinationModel(
      id: _asInt(json['id']),
      name: _asString(json['name']),
      slug: _asString(json['slug']),
      country: _asString(json['country']),
      image: _asNullableString(json['image']),
      trendingRank: _asNullableInt(json['trending_rank']),
    );
  }

  FilterDestination toEntity() {
    return FilterDestination(
      id: id,
      name: name,
      slug: slug,
      country: country,
      image: image,
      trendingRank: trendingRank,
    );
  }

  static int _asInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  static int? _asNullableInt(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  static String _asString(dynamic value) {
    if (value == null) {
      return '';
    }
    return value.toString();
  }

  static String? _asNullableString(dynamic value) {
    if (value == null) {
      return null;
    }
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }
}

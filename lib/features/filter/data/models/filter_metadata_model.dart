import 'package:trip_marche/features/filter/domain/entities/filter_metadata.dart';

class FilterMetadataModel {
  const FilterMetadataModel({required this.metadata});

  final FilterMetadata metadata;

  factory FilterMetadataModel.fromResponse(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is! Map<String, dynamic>) {
      return FilterMetadataModel(
        metadata: const FilterMetadata(
          total: 0,
          tripType: {},
          features: {},
          visa: {},
          season: {},
          duration: {},
          groupSize: {},
          price: FilterPriceMetadata(min: 0, max: 10000, currency: 'EGP'),
        ),
      );
    }
    final priceRaw = data['price'];
    return FilterMetadataModel(
      metadata: FilterMetadata(
        total: _asInt(data['total']),
        tripType: _asIntMap(data['trip_type']),
        features: _asIntMap(data['features']),
        visa: _asIntMap(data['visa']),
        season: _asIntMap(data['season']),
        duration: _asIntMap(data['duration']),
        groupSize: _asIntMap(data['group_size']),
        price: priceRaw is Map<String, dynamic>
            ? FilterPriceMetadata(
                min: _asDouble(priceRaw['min']),
                max: _asDouble(priceRaw['max']),
                currency: _asString(priceRaw['currency'], 'EGP'),
              )
            : const FilterPriceMetadata(min: 0, max: 10000, currency: 'EGP'),
      ),
    );
  }

  FilterMetadata toEntity() => metadata;

  static Map<String, int> _asIntMap(dynamic value) {
    if (value is! Map<String, dynamic>) {
      return {};
    }
    final result = <String, int>{};
    value.forEach((key, val) {
      result[key] = _asInt(val);
    });
    return result;
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

  static double _asDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value) ?? 0;
    }
    return 0;
  }

  static String _asString(dynamic value, [String fallback = '']) {
    if (value == null) {
      return fallback;
    }
    return value.toString();
  }
}

import '../../domain/entities/currency_entity.dart';

class CurrencyModel {
  const CurrencyModel({
    required this.code,
    required this.name,
    required this.symbol,
    required this.rate,
    required this.isBase,
  });

  final String code;
  final String name;
  final String symbol;
  final double rate;
  final bool isBase;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      code: json['code']?.toString().trim().toUpperCase() ?? '',
      name: json['name']?.toString().trim() ?? '',
      symbol: json['symbol']?.toString().trim() ?? '',
      rate: _asDouble(json['rate']),
      isBase: _asBool(json['is_base']),
    );
  }

  static double _asDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static bool _asBool(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    return value?.toString().toLowerCase() == 'true';
  }

  CurrencyEntity toEntity() => CurrencyEntity(
    code: code,
    name: name,
    symbol: symbol,
    rate: rate,
    isBase: isBase,
  );
}

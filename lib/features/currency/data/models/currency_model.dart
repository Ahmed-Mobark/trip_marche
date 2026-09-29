import '../../domain/entities/currency_entity.dart';

class CurrencyModel {
  const CurrencyModel({
    required this.code,
    required this.name,
    required this.symbol,
    required this.isBase,
  });

  final String code;
  final String name;
  final String symbol;
  final bool isBase;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      code: json['code']?.toString().trim().toUpperCase() ?? '',
      name: json['name']?.toString().trim() ?? '',
      symbol: json['symbol']?.toString().trim() ?? '',
      isBase: _asBool(json['is_base']),
    );
  }

  static bool _asBool(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    return value?.toString().toLowerCase() == 'true';
  }

  CurrencyEntity toEntity() =>
      CurrencyEntity(code: code, name: name, symbol: symbol, isBase: isBase);
}

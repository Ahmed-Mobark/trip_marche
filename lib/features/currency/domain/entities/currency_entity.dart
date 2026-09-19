import 'package:equatable/equatable.dart';

class CurrencyEntity extends Equatable {
  const CurrencyEntity({
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

  @override
  List<Object?> get props => [code, name, symbol, rate, isBase];
}

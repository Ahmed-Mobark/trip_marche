import 'package:equatable/equatable.dart';

class CurrencyEntity extends Equatable {
  const CurrencyEntity({
    required this.code,
    required this.name,
    required this.symbol,
    required this.isBase,
  });

  final String code;
  final String name;
  final String symbol;
  final bool isBase;

  @override
  List<Object?> get props => [code, name, symbol, isBase];
}

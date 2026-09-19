import 'package:equatable/equatable.dart';

import '../../domain/entities/currency_entity.dart';

enum CurrencyStatus { initial, loading, success, empty, failure }

class CurrencyState extends Equatable {
  const CurrencyState({
    this.status = CurrencyStatus.initial,
    this.currencies = const [],
    this.selectedCode,
    this.errorMessage,
  });

  final CurrencyStatus status;
  final List<CurrencyEntity> currencies;
  final String? selectedCode;
  final String? errorMessage;

  CurrencyState copyWith({
    CurrencyStatus? status,
    List<CurrencyEntity>? currencies,
    String? selectedCode,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CurrencyState(
      status: status ?? this.status,
      currencies: currencies ?? this.currencies,
      selectedCode: selectedCode ?? this.selectedCode,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, currencies, selectedCode, errorMessage];
}

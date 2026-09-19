import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/data/storage.dart';
import '../../domain/entities/currency_entity.dart';
import '../../domain/usecases/get_currencies_use_case.dart';
import 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  CurrencyCubit(this._getCurrencies, this._storage)
    : super(CurrencyState(selectedCode: _storage.getCurrencyCode()));

  final GetCurrenciesUseCase _getCurrencies;
  final Storage _storage;

  Future<void> ensureCurrencySelected() async {
    if (state.selectedCode != null) return;
    await loadCurrencies();
    if (state.selectedCode == null) {
      await _selectCode('EGP');
    }
  }

  Future<void> loadCurrencies() async {
    if (state.status == CurrencyStatus.loading) return;
    emit(state.copyWith(status: CurrencyStatus.loading, clearError: true));

    final result = await _getCurrencies();
    await result.fold(
      (failure) async {
        emit(
          state.copyWith(
            status: CurrencyStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (currencies) async {
        if (currencies.isEmpty) {
          emit(
            state.copyWith(status: CurrencyStatus.empty, currencies: const []),
          );
          return;
        }

        var selectedCode = state.selectedCode;
        final savedIsAvailable = currencies.any(
          (currency) => currency.code == selectedCode,
        );
        if (!savedIsAvailable) {
          selectedCode = _firstCodeWhere(
            currencies,
            (currency) => currency.isBase,
          );
          selectedCode ??=
              _firstCodeWhere(
                currencies,
                (currency) => currency.code == 'EGP',
              ) ??
              'EGP';
          await _storage.storeCurrencyCode(currencyCode: selectedCode);
        }

        emit(
          state.copyWith(
            status: CurrencyStatus.success,
            currencies: currencies,
            selectedCode: selectedCode,
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> selectCurrency(CurrencyEntity currency) async {
    if (currency.code == state.selectedCode) return;
    await _selectCode(currency.code);
  }

  Future<void> _selectCode(String code) async {
    await _storage.storeCurrencyCode(currencyCode: code);
    emit(state.copyWith(selectedCode: code));
  }

  String? _firstCodeWhere(
    List<CurrencyEntity> currencies,
    bool Function(CurrencyEntity currency) test,
  ) {
    for (final currency in currencies) {
      if (test(currency)) return currency.code;
    }
    return null;
  }
}

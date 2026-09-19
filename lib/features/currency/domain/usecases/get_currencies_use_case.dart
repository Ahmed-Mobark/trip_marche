import 'package:dartz/dartz.dart';

import '../../../../core/network/network_service/failures.dart';
import '../entities/currency_entity.dart';
import '../repositories/currency_repository.dart';

class GetCurrenciesUseCase {
  const GetCurrenciesUseCase(this._repository);

  final CurrencyRepository _repository;

  Future<Either<Failure, List<CurrencyEntity>>> call() =>
      _repository.getCurrencies();
}

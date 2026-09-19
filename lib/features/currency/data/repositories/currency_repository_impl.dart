import 'package:dartz/dartz.dart';

import '../../../../core/network/network_service/failures.dart';
import '../../../../core/network/network_service/repository_helper.dart';
import '../../domain/entities/currency_entity.dart';
import '../../domain/repositories/currency_repository.dart';
import '../datasources/currency_remote_data_source.dart';

class CurrencyRepositoryImpl
    with RepositoryHelper
    implements CurrencyRepository {
  const CurrencyRepositoryImpl(this._remoteDataSource);

  final CurrencyRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<CurrencyEntity>>> getCurrencies() =>
      handleEither(() async {
        final currencies = await _remoteDataSource.getCurrencies();
        return currencies.map((currency) => currency.toEntity()).toList();
      });
}

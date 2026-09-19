import 'package:dartz/dartz.dart';

import '../../../../core/network/network_service/failures.dart';
import '../entities/currency_entity.dart';

abstract class CurrencyRepository {
  Future<Either<Failure, List<CurrencyEntity>>> getCurrencies();
}

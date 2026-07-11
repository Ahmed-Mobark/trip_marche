import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/core/network/network_service/repository_helper.dart';
import 'package:trip_marche/features/payment_method/data/datasources/payment_method_remote_data_source.dart';
import 'package:trip_marche/features/payment_method/domain/entities/payment_method_entity.dart';
import 'package:trip_marche/features/payment_method/domain/repositories/payment_method_repository.dart';

class PaymentMethodRepositoryImpl
    with RepositoryHelper
    implements PaymentMethodRepository {
  PaymentMethodRepositoryImpl(this._remote);
  final PaymentMethodRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<PaymentMethodEntity>>> getPaymentMethods() =>
      handleEither(() async {
        final response = await _remote.getPaymentMethods();
        return response.data.map((m) => m.toEntity()).toList();
      });
}

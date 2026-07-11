import 'package:dartz/dartz.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/features/payment_method/domain/entities/payment_method_entity.dart';
import 'package:trip_marche/features/payment_method/domain/repositories/payment_method_repository.dart';

class GetPaymentMethodsUseCase {
  const GetPaymentMethodsUseCase(this._repository);
  final PaymentMethodRepository _repository;

  Future<Either<Failure, List<PaymentMethodEntity>>> call() =>
      _repository.getPaymentMethods();
}

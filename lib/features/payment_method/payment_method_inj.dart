import 'package:get_it/get_it.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/payment_method/data/datasources/payment_method_remote_data_source.dart';
import 'package:trip_marche/features/payment_method/data/repositories/payment_method_repository_impl.dart';
import 'package:trip_marche/features/payment_method/domain/repositories/payment_method_repository.dart';
import 'package:trip_marche/features/payment_method/domain/usecases/get_payment_methods_use_case.dart';
import 'package:trip_marche/features/payment_method/presentation/cubit/payment_methods_cubit.dart';

void initPaymentMethodInjection(GetIt sl) {
  sl.registerLazySingleton<PaymentMethodRemoteDataSource>(
    () => PaymentMethodRemoteDataSourceImpl(sl<ApiBaseHelper>()),
  );
  sl.registerLazySingleton<PaymentMethodRepository>(
    () => PaymentMethodRepositoryImpl(sl<PaymentMethodRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => GetPaymentMethodsUseCase(sl<PaymentMethodRepository>()),
  );
  sl.registerFactory(() => PaymentMethodsCubit(sl<GetPaymentMethodsUseCase>()));
}

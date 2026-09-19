import 'package:get_it/get_it.dart';

import '../../core/network/network_service/api_basehelper.dart';
import '../../core/storage/data/storage.dart';
import 'data/datasources/currency_remote_data_source.dart';
import 'data/repositories/currency_repository_impl.dart';
import 'domain/repositories/currency_repository.dart';
import 'domain/usecases/get_currencies_use_case.dart';
import 'presentation/cubit/currency_cubit.dart';

void initCurrencyInjection(GetIt sl) {
  sl.registerLazySingleton<CurrencyRemoteDataSource>(
    () => CurrencyRemoteDataSourceImpl(sl<ApiBaseHelper>()),
  );
  sl.registerLazySingleton<CurrencyRepository>(
    () => CurrencyRepositoryImpl(sl<CurrencyRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => GetCurrenciesUseCase(sl<CurrencyRepository>()),
  );
  sl.registerLazySingleton(
    () => CurrencyCubit(sl<GetCurrenciesUseCase>(), sl<Storage>()),
  );
}

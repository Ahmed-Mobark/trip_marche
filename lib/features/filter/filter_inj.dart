import 'package:get_it/get_it.dart';
import 'package:trip_marche/features/filter/data/datasources/filter_remote_data_source.dart';
import 'package:trip_marche/features/filter/data/repositories/filter_repository_impl.dart';
import 'package:trip_marche/features/filter/domain/repositories/filter_repository.dart';
import 'package:trip_marche/features/filter/domain/usecases/get_destinations_usecase.dart';
import 'package:trip_marche/features/filter/domain/usecases/get_filter_metadata_usecase.dart';
import 'package:trip_marche/features/filter/presentation/cubit/filter_cubit.dart';

Future<void> initFilterInjection(GetIt sl) async {
  sl.registerLazySingleton<FilterRemoteDataSource>(
    () => FilterRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<FilterRepository>(() => FilterRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetDestinationsUseCase(sl()));
  sl.registerLazySingleton(() => GetFilterMetadataUseCase(sl()));
  sl.registerFactory(() => FilterCubit(sl(), sl()));
}

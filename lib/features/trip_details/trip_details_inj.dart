import 'package:get_it/get_it.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/trip_details/data/datasources/trip_details_remote_data_source.dart';
import 'package:trip_marche/features/trip_details/data/repositories/trip_details_repository_impl.dart';
import 'package:trip_marche/features/trip_details/domain/repositories/trip_details_repository.dart';
import 'package:trip_marche/features/trip_details/domain/usecases/get_trip_details_usecase.dart';

void initTripDetailsInjection(GetIt sl) {
  sl.registerLazySingleton<TripDetailsRemoteDataSource>(
    () => TripDetailsRemoteDataSourceImpl(sl<ApiBaseHelper>()),
  );
  sl.registerLazySingleton<TripDetailsRepository>(
    () => TripDetailsRepositoryImpl(sl<TripDetailsRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => GetTripDetailsUseCase(sl<TripDetailsRepository>()),
  );
}

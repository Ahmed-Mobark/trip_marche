import 'package:get_it/get_it.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/wishlist/domain/usecases/toggle_wishlist_usecase.dart';
import 'data/datasources/trips_catalog_remote_data_source.dart';
import 'data/repositories/trips_catalog_repository_impl.dart';
import 'domain/repositories/trips_catalog_repository.dart';
import 'domain/usecases/fetch_trips_catalog_usecase.dart';
import 'presentation/cubit/my_trips_list_cubit.dart';
import 'presentation/cubit/my_trips_shell_cubit.dart';

void initMyTripsInjection(GetIt sl) {
  sl.registerLazySingleton<TripsCatalogRemoteDataSource>(
    () => TripsCatalogRemoteDataSourceImpl(sl<ApiBaseHelper>()),
  );
  sl.registerLazySingleton<TripsCatalogRepository>(
    () => TripsCatalogRepositoryImpl(sl<TripsCatalogRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => FetchTripsCatalogUseCase(sl<TripsCatalogRepository>()),
  );
  sl.registerFactory<MyTripsListCubit>(
    () => MyTripsListCubit(
      sl<FetchTripsCatalogUseCase>(),
      sl<ToggleWishlistUseCase>(),
    ),
  );
  sl.registerFactory<MyTripsShellCubit>(() => MyTripsShellCubit());
}

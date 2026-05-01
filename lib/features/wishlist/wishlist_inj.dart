import 'package:get_it/get_it.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/wishlist/domain/repositories/trip_wishlist_repository.dart';
import 'data/datasources/wishlist_remote_data_source.dart';
import 'data/repositories/wishlist_repository_impl.dart';
import 'domain/usecases/fetch_wishlist_usecase.dart';
import 'domain/usecases/toggle_wishlist_usecase.dart';
import 'presentation/cubit/wishlist_cubit.dart';

void initWishlistInjection(GetIt sl) {
  sl.registerLazySingleton<WishlistRemoteDataSource>(
    () => WishlistRemoteDataSourceImpl(sl<ApiBaseHelper>()),
  );
  sl.registerLazySingleton<TripWishlistRepository>(
    () => TripWishlistRepositoryImpl(sl<WishlistRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => FetchWishlistUseCase(sl<TripWishlistRepository>()),
  );
  sl.registerLazySingleton(
    () => ToggleWishlistUseCase(sl<TripWishlistRepository>()),
  );
  sl.registerFactory<WishlistCubit>(
    () => WishlistCubit(
      sl<FetchWishlistUseCase>(),
      sl<ToggleWishlistUseCase>(),
    ),
  );
}

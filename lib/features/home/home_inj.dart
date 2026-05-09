import 'package:get_it/get_it.dart';
import 'package:trip_marche/features/wishlist/domain/repositories/trip_wishlist_repository.dart';
import '../../core/network/network_service/api_basehelper.dart';
import 'data/datasources/home_remote_data_source.dart';
import 'data/repositories/home_repository_impl.dart';
import 'domain/repositories/home_repository.dart';
import 'presentation/cubit/home_sections_cubit.dart';
import 'presentation/cubit/home_banners_cubit.dart';
import 'presentation/cubit/home_categories_cubit.dart';
import 'presentation/cubit/special_trips_cubit.dart';
import 'presentation/cubit/trending_destinations_items_cubit.dart';
import 'presentation/cubit/popular_trips_items_cubit.dart';
import 'presentation/cubit/sponsored_trips_items_cubit.dart';
import 'presentation/cubit/domestic_trips_items_cubit.dart';
import 'presentation/cubit/international_trips_items_cubit.dart';
import 'presentation/cubit/recommended_for_you_items_cubit.dart';

void initHomeInjection(GetIt sl) {
  // Data Sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(sl<ApiBaseHelper>()),
  );

  // Repositories
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl<HomeRemoteDataSource>()),
  );

  // Cubits
  sl.registerFactory<HomeSectionsCubit>(
    () => HomeSectionsCubit(sl<HomeRepository>(), sl<TripWishlistRepository>()),
  );
  sl.registerFactory<HomeBannersCubit>(
    () => HomeBannersCubit(sl<HomeRepository>()),
  );
  sl.registerFactory<HomeCategoriesCubit>(
    () => HomeCategoriesCubit(sl<HomeRepository>()),
  );
  sl.registerFactory<SpecialTripsCubit>(
    () => SpecialTripsCubit(sl<HomeRepository>(), sl<TripWishlistRepository>()),
  );
  sl.registerFactory<TrendingDestinationsItemsCubit>(
    () => TrendingDestinationsItemsCubit(sl<HomeRepository>()),
  );
  sl.registerFactory<PopularTripsItemsCubit>(
    () => PopularTripsItemsCubit(
      sl<HomeRepository>(),
      sl<TripWishlistRepository>(),
    ),
  );
  sl.registerFactory<SponsoredTripsItemsCubit>(
    () => SponsoredTripsItemsCubit(
      sl<HomeRepository>(),
      sl<TripWishlistRepository>(),
    ),
  );
  sl.registerFactory<DomesticTripsItemsCubit>(
    () => DomesticTripsItemsCubit(
      sl<HomeRepository>(),
      sl<TripWishlistRepository>(),
    ),
  );
  sl.registerFactory<InternationalTripsItemsCubit>(
    () => InternationalTripsItemsCubit(
      sl<HomeRepository>(),
      sl<TripWishlistRepository>(),
    ),
  );
  sl.registerFactory<RecommendedForYouItemsCubit>(
    () => RecommendedForYouItemsCubit(
      sl<HomeRepository>(),
      sl<TripWishlistRepository>(),
    ),
  );
}

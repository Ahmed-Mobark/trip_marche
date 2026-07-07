import 'package:get_it/get_it.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/booking/data/datasources/coupon_remote_data_source.dart';
import 'package:trip_marche/features/booking/data/datasources/create_booking_remote_data_source.dart';
import 'package:trip_marche/features/booking/data/repositories/coupon_repository_impl.dart';
import 'package:trip_marche/features/booking/data/repositories/create_booking_repository_impl.dart';
import 'package:trip_marche/features/booking/domain/repositories/coupon_repository.dart';
import 'package:trip_marche/features/booking/domain/repositories/create_booking_repository.dart';
import 'package:trip_marche/features/booking/domain/usecases/create_booking_use_case.dart';
import 'package:trip_marche/features/booking/domain/usecases/validate_coupon_usecase.dart';
import 'package:trip_marche/features/booking/presentation/cubit/coupon_cubit.dart';
import 'package:trip_marche/features/booking/presentation/cubit/create_booking_cubit.dart';

void initBookingInjection(GetIt sl) {
  sl.registerLazySingleton<CouponRemoteDataSource>(
    () => CouponRemoteDataSourceImpl(sl<ApiBaseHelper>()),
  );
  sl.registerLazySingleton<CouponRepository>(
    () => CouponRepositoryImpl(sl<CouponRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => ValidateCouponUseCase(sl<CouponRepository>()),
  );
  sl.registerFactory(
    () => CouponCubit(sl<ValidateCouponUseCase>()),
  );

  sl.registerLazySingleton<CreateBookingRemoteDataSource>(
    () => CreateBookingRemoteDataSourceImpl(sl<ApiBaseHelper>()),
  );
  sl.registerLazySingleton<CreateBookingRepository>(
    () => CreateBookingRepositoryImpl(sl<CreateBookingRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => CreateBookingUseCase(sl<CreateBookingRepository>()),
  );
  sl.registerFactory(
    () => CreateBookingCubit(sl<CreateBookingUseCase>()),
  );
}

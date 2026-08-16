import 'package:get_it/get_it.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/profile/domain/usecases/toggle_follow_vendor_usecase.dart';
import 'data/datasources/vendor_profile_remote_data_source.dart';
import 'data/repositories/vendor_profile_repository_impl.dart';
import 'domain/repositories/vendor_profile_repository.dart';
import 'domain/usecases/get_vendor_profile_usecase.dart';
import 'presentation/cubit/vendor_profile_cubit.dart';

void initCompanyProfileInjection(GetIt sl) {
  sl.registerLazySingleton<VendorProfileRemoteDataSource>(
    () => VendorProfileRemoteDataSourceImpl(sl<ApiBaseHelper>()),
  );
  sl.registerLazySingleton<VendorProfileRepository>(
    () => VendorProfileRepositoryImpl(sl<VendorProfileRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => GetVendorProfileUseCase(sl<VendorProfileRepository>()),
  );
  sl.registerFactory<VendorProfileCubit>(
    () => VendorProfileCubit(
      sl<GetVendorProfileUseCase>(),
      sl<ToggleFollowVendorUseCase>(),
    ),
  );
}

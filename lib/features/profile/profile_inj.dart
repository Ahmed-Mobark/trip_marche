import 'package:get_it/get_it.dart';
import '../../core/network/network_service/api_basehelper.dart';
import '../../core/storage/data/storage.dart';
import 'data/datasources/profile_remote_data_source.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/get_profile_usecase.dart';
import 'domain/usecases/update_profile_usecase.dart';
import 'domain/usecases/change_password_usecase.dart';
import 'domain/usecases/delete_account_usecase.dart';
import 'presentation/cubit/profile_cubit.dart';
import 'presentation/cubit/update_profile_cubit.dart';
import 'presentation/cubit/change_password_cubit.dart';
import 'presentation/cubit/delete_account_cubit.dart';

Future<void> initProfileInjection(GetIt sl) async {
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl<ApiBaseHelper>()),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl<ProfileRemoteDataSource>()),
  );

  sl.registerLazySingleton<ProfileCubit>(
    () => ProfileCubit(GetProfileUseCase(sl<ProfileRepository>())),
  );

  sl.registerFactory<UpdateProfileCubit>(
    () => UpdateProfileCubit(UpdateProfileUseCase(sl<ProfileRepository>())),
  );

  sl.registerFactory<ChangePasswordCubit>(
    () => ChangePasswordCubit(ChangePasswordUseCase(sl<ProfileRepository>())),
  );

  sl.registerFactory<DeleteAccountCubit>(
    () => DeleteAccountCubit(
      DeleteAccountUseCase(sl<ProfileRepository>()),
      sl<Storage>(),
    ),
  );
}

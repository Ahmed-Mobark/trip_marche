import 'package:get_it/get_it.dart';
import '../../core/navigation/app_navigator.dart';
import '../../core/network/network_service/api_basehelper.dart';
import '../../core/storage/data/storage.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'presentation/cubit/forgot_password/forgot_password_cubit.dart';
import 'presentation/cubit/login/login_cubit.dart';
import 'presentation/cubit/sign_up/sign_up_cubit.dart';


Future<void> initAuthInjection(GetIt sl) async {
  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<ApiBaseHelper>()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );

  // Cubits
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(sl<AppNavigator>(), sl<AuthRepository>(), sl<Storage>()),
  );
  sl.registerFactory<SignUpCubit>(
    () => SignUpCubit(sl<AppNavigator>(), sl<AuthRepository>()),
  );
  sl.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(sl<AppNavigator>(), sl<AuthRepository>()),
  );
  // VerifyNumberCubit is created directly in the view (requires email param)
}


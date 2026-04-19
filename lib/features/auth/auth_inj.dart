import 'package:get_it/get_it.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/core/storage/data/storage.dart';
import 'package:trip_marche/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:trip_marche/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:trip_marche/features/auth/domain/repositories/auth_repository.dart';
import 'package:trip_marche/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:trip_marche/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:trip_marche/features/auth/presentation/cubit/sign_up/sign_up_cubit.dart';


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


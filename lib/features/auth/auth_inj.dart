import 'package:get_it/get_it.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:trip_marche/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:trip_marche/features/auth/presentation/cubit/sign_up/sign_up_cubit.dart';
import 'package:trip_marche/features/auth/presentation/cubit/verify_number/verify_number_cubit.dart';

Future<void> initAuthInjection(GetIt sl) async {
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl<AppNavigator>()));
  sl.registerFactory<SignUpCubit>(() => SignUpCubit(sl<AppNavigator>()));
  sl.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(sl<AppNavigator>()),
  );
  sl.registerFactory<VerifyNumberCubit>(
    () => VerifyNumberCubit(sl<AppNavigator>()),
  );
}


import 'package:dio/dio.dart';
import 'connectivity/connectivity_cubit.dart';
import 'network_service/api_basehelper.dart';
import 'package:get_it/get_it.dart';

void initNetworkServiceInjection(GetIt sl) {
  sl.registerLazySingleton<ConnectivityCubit>(() => ConnectivityCubit());
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<ApiBaseHelper>(() => ApiBaseHelper());
}

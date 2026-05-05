import 'package:dio/dio.dart';
import 'network_service/api_basehelper.dart';
import 'package:get_it/get_it.dart';

void initNetworkServiceInjection(GetIt sl) {
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<ApiBaseHelper>(() => ApiBaseHelper());
}

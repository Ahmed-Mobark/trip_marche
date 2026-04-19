import 'package:get_it/get_it.dart';
import 'package:trip_marche/core/services/media_service/media_service_impl.dart';
import 'package:trip_marche/core/services/media_service/media_services.dart';

void initMediaServiceInjection(GetIt sl) {
  sl.registerLazySingleton<MediaService>(() => MediaServiceImpl());
}
import 'package:get_it/get_it.dart';
import 'media_service/media_service_impl.dart';
import 'media_service/media_services.dart';

void initMediaServiceInjection(GetIt sl) {
  sl.registerLazySingleton<MediaService>(() => MediaServiceImpl());
}

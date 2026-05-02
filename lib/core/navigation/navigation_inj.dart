import 'app_navigator.dart';
import 'package:get_it/get_it.dart';

void initNavigationInjection(GetIt sl) {
  sl.registerLazySingleton<AppNavigator>(() => AppNavigator());
}

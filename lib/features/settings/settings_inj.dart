import 'package:get_it/get_it.dart';

import 'data/datasources/help_center_remote_data_source.dart';
import 'data/repositories/help_center_repository_impl.dart';
import 'domain/repositories/help_center_repository.dart';

void initSettingsInjection(GetIt sl) {
  sl.registerLazySingleton<HelpCenterRemoteDataSource>(
    () => HelpCenterRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<HelpCenterRepository>(
    () => HelpCenterRepositoryImpl(sl()),
  );
}

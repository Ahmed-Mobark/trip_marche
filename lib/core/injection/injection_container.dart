import 'package:trip_marche/core/navigation/navigation_inj.dart';
import 'package:trip_marche/core/network/network_service_inj.dart';
import 'package:trip_marche/core/services/media_service_inj.dart';
import 'package:trip_marche/core/storage/storage_inj.dart';
import 'package:trip_marche/features/auth/auth_inj.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  await initStorageInjection(sl);
  initNavigationInjection(sl);
  initNetworkServiceInjection(sl);
  initMediaServiceInjection(sl);
  await initAuthInjection(sl);
}

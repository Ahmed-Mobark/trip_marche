import '../navigation/navigation_inj.dart';
import '../network/network_service_inj.dart';
import '../services/media_service_inj.dart';
import '../storage/storage_inj.dart';
import '../../features/auth/auth_inj.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  await initStorageInjection(sl);
  initNavigationInjection(sl);
  initNetworkServiceInjection(sl);
  initMediaServiceInjection(sl);
  await initAuthInjection(sl);
}

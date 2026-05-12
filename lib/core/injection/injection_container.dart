import '../navigation/navigation_inj.dart';
import '../network/network_service_inj.dart';
import '../services/location_service.dart';
import '../services/media_service_inj.dart';
import '../storage/storage_inj.dart';
import '../../features/auth/auth_inj.dart';
import '../../features/home/home_inj.dart';
import '../../features/my_trips/my_trips_inj.dart';
import '../../features/filter/filter_inj.dart';
import '../../features/trip_details/trip_details_inj.dart';
import '../../features/wishlist/wishlist_inj.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  await initStorageInjection(sl);
  initNavigationInjection(sl);
  sl.registerLazySingleton<LocationService>(() => LocationService());
  initNetworkServiceInjection(sl);
  initMediaServiceInjection(sl);
  await initAuthInjection(sl);
  initWishlistInjection(sl);
  initTripDetailsInjection(sl);
  initMyTripsInjection(sl);
  initFilterInjection(sl);
  initHomeInjection(sl);
}

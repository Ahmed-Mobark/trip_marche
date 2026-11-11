import 'domain/services/chat_realtime.dart';
import 'data/datasources/chat_realtime_data_source.dart';
import 'package:get_it/get_it.dart';
import '../../core/network/network_service/api_basehelper.dart';
import 'data/datasources/chat_remote_data_source.dart';
import 'data/repositories/chat_repository_impl.dart';
import 'domain/repositories/chat_repository.dart';
import 'domain/usecases/chat_usecases.dart';
import 'presentation/cubit/conversations_cubit.dart';
import 'presentation/cubit/chat_cubit.dart';

void initChatInjection(GetIt sl) {
  sl.registerLazySingleton<ChatRealtime>(
    () => ChatRealtimeDataSource(sl<ApiBaseHelper>()),
  );
  sl.registerLazySingleton(() => ChatRemoteDataSource(sl<ApiBaseHelper>()));
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));
  sl.registerLazySingleton(() => ChatUseCases(sl()));
  sl.registerFactory(
    () => ConversationsCubit(sl(), realtime: sl<ChatRealtime>()),
  );
  sl.registerFactoryParam<ChatCubit, int, void>(
    (id, _) => ChatCubit(sl(), id, realtime: sl<ChatRealtime>()),
  );
}

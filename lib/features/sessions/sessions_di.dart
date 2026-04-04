import 'package:bl_staff/bl_staff.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initSessionsDI() async {
  getIt.registerLazySingleton<SessionsRepository>(
    () => SessionsRepositoryImpl(getIt<SessionsLocalDataSource>()),
  );

  getIt.registerLazySingleton<SessionsLocalDataSource>(
    () => SessionsLocalDataSourceImpl(
      getIt<SharedPreferences>(),
      getIt<FlutterSecureStorage>(),
    ),
  );

  getIt.registerLazySingleton<GetAccessTokenUseCase>(
    () => GetAccessTokenUseCase(getIt<SessionsRepository>()),
  );
  getIt.registerLazySingleton<SaveAccessTokenUseCase>(
    () => SaveAccessTokenUseCase(getIt<SessionsRepository>()),
  );
  getIt.registerLazySingleton<ClearSessionUseCase>(
    () => ClearSessionUseCase(getIt<SessionsRepository>()),
  );

  getIt.registerLazySingleton<SessionsBloc>(
    () => SessionsBloc(
      getIt<SaveAccessTokenUseCase>(),
      getIt<GetAccessTokenUseCase>(),
      getIt<ClearSessionUseCase>(),
    ),
  );
}

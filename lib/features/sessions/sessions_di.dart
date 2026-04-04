import 'package:bl_staff/bl_staff.dart';

Future<void> initSessionsDI() async {
  getIt.registerLazySingleton<SessionsRepository>(
    () => SessionsRepositoryImpl(getIt<SessionsLocalDataSource>()),
  );

  getIt.registerLazySingleton<SessionsLocalDataSource>(
    () => SessionsLocalDataSourceImpl(),
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

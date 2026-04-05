import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/shared/constant.dart';
import 'data/datasources/sessions_local_data_source.dart';
import 'data/repositories/sessions_repository_impl.dart';
import 'domain/repositories/sessions_repository.dart';
import 'domain/usecases/clear_session_use_case.dart';
import 'domain/usecases/get_access_token_use_case.dart';
import 'domain/usecases/save_access_token_use_case.dart';
import 'presentation/bloc/sessions_bloc/sessions_bloc.dart';

/// Registers all sessions feature dependencies into the service locator.
///
/// Must be called once during app initialization, before any sessions
/// component is accessed. Registers [SessionsLocalDataSource],
/// [SessionsRepository], all three session use cases, and [SessionsBloc]
/// as lazy singletons.
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

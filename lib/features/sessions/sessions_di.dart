import 'package:bl_staff/features/sessions/data/datasources/sessions_local_data_source.dart';
import 'package:bl_staff/features/sessions/data/repositories/sessions_repository_impl.dart';
import 'package:bl_staff/features/sessions/domain/repositories/sessions_repository.dart';
import 'package:bl_staff/features/sessions/domain/usecases/get_access_token_use_case.dart';
import 'package:bl_staff/features/sessions/domain/usecases/save_access_token_use_case.dart';
import 'package:bl_staff/features/sessions/presentation/bloc/sessions_bloc/sessions_bloc.dart';
import 'package:bl_staff/utils/shared/constant.dart';

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

  getIt.registerLazySingleton<SessionsBloc>(
    () => SessionsBloc(
      getIt<SaveAccessTokenUseCase>(),
      getIt<GetAccessTokenUseCase>(),
    ),
  );
}

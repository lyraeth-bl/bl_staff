import 'package:hive_flutter/hive_flutter.dart';

import '../../core/core.dart';
import '../../utils/shared/constant.dart';
import './data/datasources/user_local_data_source.dart';
import './data/datasources/user_remote_data_source.dart';
import './data/repositories/user_repository_impl.dart';
import './domain/repositories/user_repository.dart';
import './domain/usecases/fetch_me_use_case.dart';
import './presentation/bloc/user_bloc.dart';

void initUserDI() {
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      getIt<UserRemoteDataSource>(),
      getIt<UserLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(getIt<HiveInterface>()),
  );

  getIt.registerLazySingleton<FetchMeUseCase>(
    () => FetchMeUseCase(getIt<UserRepository>()),
  );

  getIt.registerFactory<UserBloc>(() => UserBloc(getIt<FetchMeUseCase>()));
}

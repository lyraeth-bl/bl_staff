import 'package:shared_preferences/shared_preferences.dart';

import '../../core/api/api_client/api_client.dart';
import '../../utils/shared/constant.dart';
import 'data/datasources/auth_local_data_source.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/get_email_from_remember_me_use_case.dart';
import 'domain/usecases/login_use_case.dart';
import 'domain/usecases/logout_use_case.dart';
import 'domain/usecases/save_email_for_remember_me_use_case.dart';
import 'presentation/bloc/auth_bloc.dart';
import 'presentation/bloc/remember_me/remember_me_cubit.dart';

/// Initializes the dependency injection for the authentication feature.
///
/// This function registers all the necessary repositories, data sources,
/// use cases, and BLoCs with the [getIt] locator.
void initAuthDI() {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
      getIt<AuthLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<GetEmailFromRememberMeUseCase>(
    () => GetEmailFromRememberMeUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<SaveEmailForRememberMeUseCase>(
    () => SaveEmailForRememberMeUseCase(getIt<AuthRepository>()),
  );

  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(getIt<LoginUseCase>(), getIt<LogoutUseCase>()),
  );

  getIt.registerFactory<RememberMeCubit>(
    () => RememberMeCubit(
      getIt<GetEmailFromRememberMeUseCase>(),
      getIt<SaveEmailForRememberMeUseCase>(),
    ),
  );
}

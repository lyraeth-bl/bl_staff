import 'package:bl_staff/bl_staff.dart';

void initAppRouterDI() {
  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(getIt<SessionsBloc>()),
  );
}

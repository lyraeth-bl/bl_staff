import '../../../utils/utils_export.dart';
import '../../features/features.dart';
import 'app_router.dart';

void initAppRouterDI() {
  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(getIt<SessionsBloc>()),
  );
}

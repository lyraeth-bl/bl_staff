import 'package:bl_staff/core/app_router/app_router.dart';
import 'package:bl_staff/utils/shared/constant.dart';

void initAppRouterDI() {
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
}

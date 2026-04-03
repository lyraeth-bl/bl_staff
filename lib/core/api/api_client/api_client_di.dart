import 'package:bl_staff/bl_staff.dart';
import 'package:dio/dio.dart';

void initApiClientDI() {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));
}

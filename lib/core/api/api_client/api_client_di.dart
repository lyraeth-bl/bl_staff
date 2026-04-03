import 'package:bl_staff/core/api/api_client/api_client.dart';
import 'package:bl_staff/utils/shared/constant.dart';
import 'package:dio/dio.dart';

void initApiClientDI() {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));
}

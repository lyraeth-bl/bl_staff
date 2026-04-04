import 'package:dio/dio.dart';

import '../../../utils/utils_export.dart';
import 'api_client.dart';

void initApiClientDI() {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));
}

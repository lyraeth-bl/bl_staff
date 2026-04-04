import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../utils/utils_export.dart';

void initSecureStorageDI() {
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
}

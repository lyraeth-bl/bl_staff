import 'package:bl_staff/utils/shared/constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void initSecureStorageDI() {
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
}

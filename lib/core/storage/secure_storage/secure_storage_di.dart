import 'package:bl_staff/bl_staff.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void initSecureStorageDI() {
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
}

import 'package:bl_staff/core/storage/hive_storage/hive_storage_di.dart';
import 'package:bl_staff/core/storage/prefs_storage/prefs_storage_di.dart';
import 'package:bl_staff/core/storage/secure_storage/secure_storage_di.dart';

Future<void> initStorageDI() async {
  await initHiveStorageDI();
  await initPrefsStorageDI();
  initSecureStorageDI();
}

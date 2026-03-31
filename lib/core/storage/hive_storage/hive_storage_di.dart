import 'package:bl_staff/utils/shared/constant.dart';
import 'package:hive_flutter/hive_flutter.dart';

void initHiveStorageDI() {
  getIt.registerLazySingleton<HiveInterface>(() => Hive);
}

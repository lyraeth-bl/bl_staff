import 'package:hive_flutter/hive_flutter.dart';

import '../../../utils/utils_export.dart';
import '../hive_storage/hive_storage_names.dart';

Future<void> initHiveStorageDI() async {
  await Hive.initFlutter();

  await Hive.openBox(userBoxKey);
  await Hive.openBox(attendanceBoxKey);

  getIt.registerLazySingleton<HiveInterface>(() => Hive);
}

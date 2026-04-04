import 'package:hive_flutter/hive_flutter.dart';

import '../../../utils/utils_export.dart';

Future<void> initHiveStorageDI() async {
  await Hive.initFlutter();

  getIt.registerLazySingleton<HiveInterface>(() => Hive);
}

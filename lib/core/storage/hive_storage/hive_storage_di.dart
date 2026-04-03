import 'package:bl_staff/utils/shared/constant.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initHiveStorageDI() async {
  await Hive.initFlutter();

  getIt.registerLazySingleton<HiveInterface>(() => Hive);
}

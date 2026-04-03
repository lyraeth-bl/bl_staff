import 'package:bl_staff/bl_staff.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initHiveStorageDI() async {
  await Hive.initFlutter();

  getIt.registerLazySingleton<HiveInterface>(() => Hive);
}

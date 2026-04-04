import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/utils_export.dart';

Future<void> initPrefsStorageDI() async {
  final prefs = await SharedPreferences.getInstance();

  getIt.registerSingleton<SharedPreferences>(prefs);
}

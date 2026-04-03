import 'package:bl_staff/bl_staff.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initPrefsStorageDI() async {
  final prefs = await SharedPreferences.getInstance();

  getIt.registerSingleton<SharedPreferences>(prefs);
}

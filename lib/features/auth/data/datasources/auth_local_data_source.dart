import 'package:bl_staff/core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<String?> getEmailFromRememberMe();

  Future<Unit> saveEmailForRememberMe(String email);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<String?> getEmailFromRememberMe() async =>
      _prefs.getString(authEmailRememberMeKey);

  @override
  Future<Unit> saveEmailForRememberMe(String email) async {
    await _prefs.setString(authEmailRememberMeKey, email);
    return unit;
  }
}

import 'package:bl_staff/core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A data source for managing authentication data in local storage.
///
/// This interface defines methods for persisting and retrieving user
/// credentials, specifically for the "remember me" functionality.
///
/// See also:
/// * [AuthLocalDataSourceImpl], for the SharedPreferences implementation.
abstract class AuthLocalDataSource {
  /// Returns the saved email address for the "remember me" feature.
  ///
  /// Returns null if no email is found.
  Future<String?> getEmailFromRememberMe();

  /// Persists the given [email] to local storage.
  ///
  /// Returns [unit] upon successful completion.
  Future<Unit> saveEmailForRememberMe(String email);
}

/// An implementation of [AuthLocalDataSource] using [SharedPreferences].
///
/// This class handles the low-level storage operations for authentication
/// related preferences using the shared preferences plugin.
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  /// Creates an [AuthLocalDataSourceImpl] with the given [SharedPreferences].
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

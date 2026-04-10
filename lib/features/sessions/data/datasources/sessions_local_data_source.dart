import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/storage/secure_storage/secure_storage_names.dart';

/// The contract for local session storage operations.
///
/// Defines how the access token is read, written, and cleared from
/// device storage. Implementations are expected to use secure storage
/// for sensitive token data.
///
/// See also:
/// * [SessionsLocalDataSourceImpl], the concrete implementation backed
///   by [FlutterSecureStorage].
abstract class SessionsLocalDataSource {
  /// Returns the stored access token, or `null` if no token exists.
  Future<String?> getAccessToken();

  /// Persists [value] as the current access token.
  ///
  /// Returns [Unit] on completion regardless of outcome.
  Future<Unit> saveAccessToken(String value);

  /// Removes the access token from secure storage, effectively ending the session.
  ///
  /// Returns [Unit] on completion.
  Future<Unit> clearSession();
}

/// A [SessionsLocalDataSource] backed by [FlutterSecureStorage] and [SharedPreferences].
///
/// Uses [FlutterSecureStorage] for the access token, ensuring the value is
/// stored in the platform keychain (iOS) or Keystore (Android). [SharedPreferences]
/// is injected for potential future non-sensitive session metadata.
class SessionsLocalDataSourceImpl implements SessionsLocalDataSource {
  /// Creates a [SessionsLocalDataSourceImpl] with the given [prefs] and [secureStorage].
  SessionsLocalDataSourceImpl(this.prefs, this.secureStorage);

  /// The shared preferences instance for non-sensitive session data.
  final SharedPreferences prefs;

  /// The secure storage instance used to persist the access token.
  final FlutterSecureStorage secureStorage;

  @override
  Future<String?> getAccessToken() async =>
      await secureStorage.read(key: kAccessTokenKey);

  @override
  Future<Unit> saveAccessToken(String value) async {
    try {
      await secureStorage.write(key: kAccessTokenKey, value: value);
      debugPrint("Success to save accessToken");
    } catch (e) {
      debugPrint("Failed to save accessToken");
    }

    return unit;
  }

  @override
  Future<Unit> clearSession() async {
    await secureStorage.delete(key: kAccessTokenKey);
    debugPrint("await secureStorage.delete(key: kAccessTokenKey) success");

    return unit;
  }
}

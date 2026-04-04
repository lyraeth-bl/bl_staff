import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/storage/secure_storage/secure_storage_names.dart';

abstract class SessionsLocalDataSource {
  Future<String?> getAccessToken();

  Future<Unit> saveAccessToken(String value);

  Future<Unit> clearSession();
}

class SessionsLocalDataSourceImpl implements SessionsLocalDataSource {
  final SharedPreferences prefs;
  final FlutterSecureStorage secureStorage;

  SessionsLocalDataSourceImpl(this.prefs, this.secureStorage);

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

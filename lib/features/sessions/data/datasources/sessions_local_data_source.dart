import 'package:bl_staff/bl_staff.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SessionsLocalDataSource {
  Future<String?> getAccessToken();

  Future<Unit> saveAccessToken(String value);
}

class SessionsLocalDataSourceImpl implements SessionsLocalDataSource {
  final SharedPreferences prefs = getIt<SharedPreferences>();
  final FlutterSecureStorage secureStorage = getIt<FlutterSecureStorage>();

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
}

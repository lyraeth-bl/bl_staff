import 'package:fpdart/fpdart.dart';

abstract class SessionsRepository {
  Future<String?> getAccessToken();

  Future<Unit> saveAccessToken(String value);
}

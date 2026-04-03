import 'package:bl_staff/bl_staff.dart';
import 'package:fpdart/fpdart.dart';

class SessionsRepositoryImpl implements SessionsRepository {
  final SessionsLocalDataSource _sessionsLocalDataSource;

  SessionsRepositoryImpl(this._sessionsLocalDataSource);

  @override
  Future<String?> getAccessToken() async =>
      await _sessionsLocalDataSource.getAccessToken();

  @override
  Future<Unit> saveAccessToken(String value) =>
      _sessionsLocalDataSource.saveAccessToken(value);
}

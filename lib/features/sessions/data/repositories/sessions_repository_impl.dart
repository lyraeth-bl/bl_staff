import 'package:fpdart/fpdart.dart';

import '../../domain/repositories/sessions_repository.dart';
import '../datasources/sessions_local_data_source.dart';

class SessionsRepositoryImpl implements SessionsRepository {
  final SessionsLocalDataSource _sessionsLocalDataSource;

  SessionsRepositoryImpl(this._sessionsLocalDataSource);

  @override
  Future<String?> getAccessToken() async =>
      await _sessionsLocalDataSource.getAccessToken();

  @override
  Future<Unit> saveAccessToken(String value) =>
      _sessionsLocalDataSource.saveAccessToken(value);

  @override
  Future<Unit> clearSession() => _sessionsLocalDataSource.clearSession();
}

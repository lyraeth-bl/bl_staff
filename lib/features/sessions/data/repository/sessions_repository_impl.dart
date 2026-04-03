import 'package:bl_staff/features/sessions/data/datasources/sessions_local_data_source.dart';
import 'package:bl_staff/features/sessions/domain/repository/sessions_repository.dart';
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

import 'package:fpdart/fpdart.dart';

import '../../domain/repositories/sessions_repository.dart';
import '../datasources/sessions_local_data_source.dart';

/// A [SessionsRepository] that delegates all operations to [SessionsLocalDataSource].
///
/// Acts as the bridge between the domain layer and local storage, forwarding
/// each call directly to the underlying data source without additional transformation.
class SessionsRepositoryImpl implements SessionsRepository {
  /// Creates a [SessionsRepositoryImpl] backed by the given [_sessionsLocalDataSource].
  SessionsRepositoryImpl(this._sessionsLocalDataSource);

  final SessionsLocalDataSource _sessionsLocalDataSource;

  @override
  Future<String?> getAccessToken() async =>
      await _sessionsLocalDataSource.getAccessToken();

  @override
  Future<Unit> saveAccessToken(String value) =>
      _sessionsLocalDataSource.saveAccessToken(value);

  @override
  Future<Unit> clearSession() => _sessionsLocalDataSource.clearSession();
}

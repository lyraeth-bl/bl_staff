import 'package:fpdart/fpdart.dart';

import '../../../../utils/shared/entities/sessions_token_entity/sessions_token_entity.dart';
import '../../../../utils/shared/mappers/mappers.dart';
import '../../../../utils/shared/types/types.dart';
import '../../domain/entities/login_params/login_params.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../mappers/auth_mapper.dart';
import '../models/login_response/login_response.dart';

/// An implementation of [AuthRepository] that coordinates authentication tasks.
///
/// This class acts as a bridge between the domain layer and the data sources.
/// It uses [AuthRemoteDataSource] for network-based authentication and
/// [AuthLocalDataSource] for local credential persistence.
///
/// See also:
/// * [AuthRepository], the domain interface this class implements.
class AuthRepositoryImpl implements AuthRepository {
  /// Creates an [AuthRepositoryImpl] with the given data sources.
  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<Result<SessionsTokenEntity>> login(LoginParams loginParams) async {
    final response = await _remoteDataSource.login(loginParams.toRequest());

    return response.match(
      (failure) => left(failure),
      (LoginResponse loginResponse) =>
          right(loginResponse.sessionsToken.toEntity()),
    );
  }

  @override
  Future<Result<Unit>> logout() async {
    final response = await _remoteDataSource.logout();

    return response.match((failure) => left(failure), (u) => right(u));
  }

  @override
  Future<String?> getEmailFromRememberMe() async =>
      await _localDataSource.getEmailFromRememberMe();

  @override
  Future<Unit> saveEmailForRememberMe(String email) async =>
      await _localDataSource.saveEmailForRememberMe(email);
}

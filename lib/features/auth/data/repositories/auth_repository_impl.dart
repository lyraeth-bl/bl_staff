import 'package:fpdart/fpdart.dart';

import '../../../../utils/shared/entities/sessions_token_entity/sessions_token_entity.dart';
import '../../../../utils/shared/mappers/mappers.dart';
import '../../../../utils/shared/types/types.dart';
import '../../domain/entities/login_params/login_params.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../mappers/auth_mapper.dart';
import '../models/login_response/login_response.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

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
}

import 'package:bl_staff/bl_staff.dart';
import 'package:fpdart/fpdart.dart';

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

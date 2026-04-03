import 'package:bl_staff/bl_staff.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRemoteDataSource {
  Future<Result<LoginResponse>> login(LoginRequest loginRequest);

  Future<Result<Unit>> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<LoginResponse>> login(LoginRequest loginRequest) async {
    final request = loginRequest.toJson();

    try {
      final response = await _apiClient.post(ApiPath.login, data: request);

      return response.match(
        (failure) => left(failure),
        (responseMap) => right(LoginResponse.fromJson(responseMap)),
      );
    } catch (e, st) {
      return left(Failure.fromDio(e, st));
    }
  }

  @override
  Future<Result<Unit>> logout() async {
    try {
      final response = await _apiClient.post(ApiPath.logout, data: {});

      return response.match(
        (failure) => left(failure),
        (responseMap) => right(unit),
      );
    } catch (e, st) {
      return left(Failure.fromDio(e, st));
    }
  }
}

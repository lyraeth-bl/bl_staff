import 'package:fpdart/fpdart.dart';

import '../../../../core/api/api_client/api_client.dart';
import '../../../../core/api/failure/failure.dart';
import '../../../../utils/shared/types/types.dart';
import '../../../../utils/utils.dart';
import '../models/login_request/login_request.dart';
import '../models/login_response/login_response.dart';

abstract class AuthRemoteDataSource {
  Future<Result<LoginResponse>> login(LoginRequest loginRequest);

  Future<Result<Unit>> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<LoginResponse>> login(LoginRequest loginRequest) async {
    final deviceName = await Utils.getDeviceName();

    final request = LoginRequest(
      email: loginRequest.email,
      password: loginRequest.password,
      deviceName: deviceName,
    ).toJson();

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

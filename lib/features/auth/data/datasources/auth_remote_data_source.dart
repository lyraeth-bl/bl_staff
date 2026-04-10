import 'package:fpdart/fpdart.dart';

import '../../../../core/api/api_client/api_client.dart';
import '../../../../core/api/failure/failure.dart';
import '../../../../utils/shared/types/types.dart';
import '../../../../utils/utils.dart';
import '../models/login_request/login_request.dart';
import '../models/login_response/login_response.dart';

/// A data source that communicates with the remote authentication API.
///
/// This data source handles the network requests for user authentication
/// and session management.
///
/// See also:
/// * [LoginRequest], the data model for the login request.
/// * [LoginResponse], the data model for the login response.
abstract class AuthRemoteDataSource {
  /// Sends a login request to the remote server.
  ///
  /// Returns a [Result] containing a [LoginResponse] if successful.
  Future<Result<LoginResponse>> login(LoginRequest loginRequest);

  /// Sends a logout request to the remote server.
  ///
  /// Returns a [Result] indicating whether the operation succeeded.
  Future<Result<Unit>> logout();
}

/// Implementation of [AuthRemoteDataSource] using [ApiClient].
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  /// Creates an [AuthRemoteDataSourceImpl] with the given [ApiClient].
  AuthRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

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

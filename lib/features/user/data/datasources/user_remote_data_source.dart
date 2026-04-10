import 'package:fpdart/fpdart.dart';

import '../../../../core/core.dart';
import '../../../../utils/utils_export.dart';
import '../models/user_response/user_response.dart';

abstract class UserRemoteDataSource {
  Future<Result<UserResponse>> fetchMe();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<Result<UserResponse>> fetchMe() async {
    try {
      final response = await _apiClient.get(ApiPath.me);

      return response.match(
        (failure) => left(failure),
        (responseJson) => right(UserResponse.fromJson(responseJson)),
      );
    } catch (e, st) {
      return left(Failure.fromDio(e, st));
    }
  }
}

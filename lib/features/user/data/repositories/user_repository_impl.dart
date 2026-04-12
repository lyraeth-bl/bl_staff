import 'package:fpdart/fpdart.dart';

import '../../../../utils/utils_export.dart';
import '../../domain/entities/user_entity/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';
import '../mappers/user_mapper.dart';
import '../models/user_response/user_response.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;

  @override
  Future<Result<UserEntity>> fetchMe({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final storedUserData = _localDataSource.getSavedUserDetail();

      if (storedUserData != null) return right(storedUserData.toEntity());
    }

    final response = await _remoteDataSource.fetchMe();

    return response.match((failure) => left(failure), (
      UserResponse userResponse,
    ) async {
      await _localDataSource.saveUserDetail(userResponse.userModel);

      return right(userResponse.userModel.toEntity());
    });
  }
}

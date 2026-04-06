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
  Future<Result<UserEntity>> fetchMe() async {
    final response = await _remoteDataSource.fetchMe();

    return response.match(
      (failure) => left(failure),
      (UserResponse userResponse) => right(userResponse.userModel.toEntity()),
    );
  }

  @override
  UserEntity? getSavedUserDetail() {
    final model = _localDataSource.getSavedUserDetail();

    if (model == null) return null;

    return model.toEntity();
  }

  @override
  Future<Unit> saveUserDetail(UserEntity userEntity) async {
    await _localDataSource.saveUserDetail(userEntity.toModel());

    return unit;
  }
}

import 'package:fpdart/fpdart.dart';

import '../../../../utils/utils_export.dart';
import '../entities/user_entity/user_entity.dart';

abstract class UserRepository {
  Future<Result<UserEntity>> fetchMe();

  UserEntity? getSavedUserDetail();

  Future<Unit> saveUserDetail(UserEntity userEntity);
}

import 'package:fpdart/fpdart.dart';

import '../entities/user_entity/user_entity.dart';
import '../repositories/user_repository.dart';

class SaveUserDetailUseCase {
  SaveUserDetailUseCase(this._userRepository);

  final UserRepository _userRepository;

  Future<Unit> call(UserEntity userEntity) async =>
      await _userRepository.saveUserDetail(userEntity);
}

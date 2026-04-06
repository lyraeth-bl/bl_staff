import '../entities/user_entity/user_entity.dart';
import '../repositories/user_repository.dart';

class GetSavedUserDetailUseCase {
  GetSavedUserDetailUseCase(this._userRepository);

  final UserRepository _userRepository;

  UserEntity? call() => _userRepository.getSavedUserDetail();
}

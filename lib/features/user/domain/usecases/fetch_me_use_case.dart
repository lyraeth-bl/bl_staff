import '../../../../utils/utils_export.dart';
import '../entities/user_entity/user_entity.dart';
import '../repositories/user_repository.dart';

class FetchMeUseCase {
  FetchMeUseCase(this._userRepository);

  final UserRepository _userRepository;

  Future<Result<UserEntity>> call() async => await _userRepository.fetchMe();
}

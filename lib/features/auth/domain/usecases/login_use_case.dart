import '../../../../utils/shared/entities/sessions_token_entity/sessions_token_entity.dart';
import '../../../../utils/shared/types/types.dart';
import '../entities/login_params/login_params.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<Result<SessionsTokenEntity>> call(LoginParams loginParams) async =>
      _authRepository.login(loginParams);
}

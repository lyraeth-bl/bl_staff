import 'package:bl_staff/bl_staff.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<Result<SessionsTokenEntity>> call(LoginParams loginParams) async =>
      _authRepository.login(loginParams);
}

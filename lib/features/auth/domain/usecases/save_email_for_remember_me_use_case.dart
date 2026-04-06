import 'package:fpdart/fpdart.dart';

import '../repositories/auth_repository.dart';

class SaveEmailForRememberMeUseCase {
  SaveEmailForRememberMeUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<Unit> call(String email) async =>
      await _authRepository.saveEmailForRememberMe(email);
}

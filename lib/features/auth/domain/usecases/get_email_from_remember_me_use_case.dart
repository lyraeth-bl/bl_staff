import '../repositories/auth_repository.dart';

class GetEmailFromRememberMeUseCase {
  GetEmailFromRememberMeUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<String?> call() async =>
      await _authRepository.getEmailFromRememberMe();
}

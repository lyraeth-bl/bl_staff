import '../../../../utils/shared/entities/sessions_token_entity/sessions_token_entity.dart';
import '../../../../utils/shared/types/types.dart';
import '../entities/login_params/login_params.dart';
import '../repositories/auth_repository.dart';

/// A use case that handles the login process.
///
/// This class encapsulates the business logic for authenticating a user
/// by delegating the call to the [AuthRepository].
class LoginUseCase {
  /// Creates a [LoginUseCase] with the given [AuthRepository].
  LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  /// Executes the login operation.
  ///
  /// Uses [loginParams] to authenticate the user.
  /// Returns a [Result] containing a [SessionsTokenEntity] if successful.
  Future<Result<SessionsTokenEntity>> call(LoginParams loginParams) async =>
      _authRepository.login(loginParams);
}

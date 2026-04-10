import 'package:fpdart/fpdart.dart';

import '../../../../utils/shared/types/types.dart';
import '../repositories/auth_repository.dart';

/// A use case that handles the logout process.
///
/// This class encapsulates the business logic for signing out a user
/// by delegating the call to the [AuthRepository].
class LogoutUseCase {
  /// Creates a [LogoutUseCase] with the given [AuthRepository].
  LogoutUseCase(this._authRepository);

  final AuthRepository _authRepository;

  /// Executes the logout operation.
  ///
  /// Clears the user's session and authentication tokens.
  /// Returns a [Result] indicating whether the operation succeeded.
  Future<Result<Unit>> call() async => await _authRepository.logout();
}
